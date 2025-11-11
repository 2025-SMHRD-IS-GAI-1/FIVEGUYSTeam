// Flask 서버 주소
const FLASK_SERVER_URL = 'http://192.168.219.51:5000/ocr';

// [새로 추가됨] Tomcat 서블릿 주소 (반드시 실제 환경에 맞게 수정하세요)
const TOMCAT_SERVLET_URL = 'http://192.168.219.51:8090/ExMessageSystem/SaveMenu.do';

// DOM 요소 참조
const canvas = document.getElementById('captureCanvas');
const ctx = canvas.getContext('2d');
const ocrButton = document.getElementById('ocrButton');
const imageContainer = document.getElementById('dropzone');
const saveButton = document.getElementById('saveButton'); // [새로 추가됨]
const target_lang = document.getElementById("lang");



// 모달(alert 대용) 요소 참조
const modal = document.getElementById('infoModal');
const modalText = document.getElementById('modalText');
const closeButton = document.querySelector('.close-button');

// [새로 추가됨] OCR/Gemini 처리 결과를 저장할 전역 변수
let processedOcrFields = [];

// --- 모달 닫기 이벤트 ---
// 닫기 버튼(X) 클릭 시
closeButton.onclick = () => {
  modal.style.display = "none";
  // 모달이 닫힐 때 TTS 중지
  window.speechSynthesis.cancel();
};
// 모달 바깥 영역 클릭 시
window.addEventListener("click", (event) => {
	
  if (event.target == modal) {
    modal.style.display = "none";
    // 모달이 닫힐 때 TTS 중지
    window.speechSynthesis.cancel();
  }
});

// 1. 페이지 로드 시 스토리지에서 이미지 데이터 가져와 캔버스에 그리기
// -> 본페이지에서는 canvas로 가져오는 로직이 이부분이 아님

// 2. '이미지 처리' 버튼 클릭 이벤트 리스너
ocrButton.addEventListener('click', () => {
  // 캔버스의 현재 이미지를 Base64 데이터 URL로 변환
  const dataUrl = canvas.toDataURL('image/png');

  // 버튼 비활성화 및 로딩 텍스트 표시
  ocrButton.disabled = true;
  ocrButton.textContent = '처리 중...';
  
  // [수정됨] 저장 버튼 숨기기 및 데이터 초기화
  saveButton.style.display = 'none'; 
  processedOcrFields = [];

  // 기존 오버레이 박스 제거
  document.querySelectorAll('.ocr-box').forEach(box => box.remove());
  let tlan = target_lang.value;
  // 3. Flask 서버로 OCR 요청 전송
  fetch(FLASK_SERVER_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ image: dataUrl, language : tlan }) // Base64 이미지 데이터 전송
  })
  .then(response => {
    if (!response.ok) {
      // Flask 서버 자체가 500 오류 등을 반환한 경우
      throw new Error(`서버 응답 오류: ${response.status} ${response.statusText}`);
    }
    return response.json();
  })
  .then(data => {
    // Flask로부터 받은 JSON을 브라우저 콘솔에 출력 (디버깅용)
    console.log('--- Flask 서버 응답 원본 (필터링됨) ---');
    console.log(data);
    console.log('---------------------------------');

    // 서버가 { "error": "..." }를 반환한 경우
    if (data.error) {
      throw new Error(`서버 처리 오류: ${data.message || data.error}`);
    }
    
    // (문제의 지점) images 필드가 없거나 비어있는 경우
    if (!data.images || data.images.length === 0) {
      // 이 경우는 서버에서 images가 없거나, fields가 0개일 때 발생
      throw new Error('OCR 결과에서 이미지 데이터를 찾을 수 없습니다.');
    }
    
    // 4. OCR 응답 데이터 처리
    drawOcrResults(data); // 결과를 화면에 그리는 함수 호출
    
    // [수정됨] 처리 결과 저장 및 저장 버튼 표시
	if (data.images[0].fields && data.images[0].fields.length > 0) {
        processedOcrFields = data.images[0].fields;
		saveButton.style.display = 'inline-block'; // 저장 버튼 보이기
    }

  })
  .catch(error => {
    // 모든 오류를 여기서 잡음
    console.error('OCR 요청 실패:', error);
    // 모달을 사용하여 오류 메시지 표시
    modalText.innerHTML = `<p style="color: red;"><strong>오류:</strong> ${error.message}</p>`;
    modal.style.display = "block";
  })
  .finally(() => {
    // 버튼 다시 활성화
    ocrButton.disabled = false;
    ocrButton.textContent = '이미지 처리 (OCR)';
  });
});

// [새로 추가됨] 6. 'DB에 저장' 버튼 클릭 이벤트 리스너
saveButton.addEventListener('click', () => {
  if (processedOcrFields.length === 0) {
    modalText.innerHTML = `<p>저장할 데이터가 없습니다. 먼저 이미지 처리를 실행하세요.</p>`;
    modal.style.display = 'block';
    return;
  }

  saveButton.disabled = true;
  saveButton.textContent = '저장 중...';

  try {
    // 1. T_IMAGE 데이터 준비
    const imgId = crypto.randomUUID(); // T_IMAGE의 IMG_ID
    
    const imgName = `menu-capture-${Date.now()}.png`; // T_IMAGE의 IMG_NAME
    const uploadDt = new Date().toISOString(); // T_IMAGE의 UPLOAD_DT

    // 2. T_TRANLATION 데이터 준비
    const translationData = processedOcrFields.map(field => {
      const vertices = field.boundingPoly.vertices;
      const xCoords = vertices.map(v => v.x);
      const yCoords = vertices.map(v => v.y);
      
      return {
        TRANS_ID: crypto.randomUUID(),
        IMG_ID: imgId, // T_IMAGE의 PK와 일치
        X1: Math.round(Math.min(...xCoords)),
        Y1: Math.round(Math.min(...yCoords)),
        X2: Math.round(Math.max(...xCoords)),
        Y2: Math.round(Math.max(...yCoords)),
        MENU_NAME: field.inferText,
        TRANS_TEXT: field.translatedText,
        MENU_DESC: field.description,
        COLOR_BG : field.detectedBackgroundColor,
        COLOR_TXT : field.detectedTextColor
      };
    });
    
    // 3. 서블릿으로 보낼 메타데이터 JSON 생성
    const metadata = {
        T_IMAGE: {
            IMG_ID: imgId,
            ID: userId,
            IMG_NAME: imgName,
            UPLOAD_DT: uploadDt
            // RES_NAME, ADDR 등은 요청대로 제외
        },
        T_TRANLATION: translationData
    };

    // 4. 캔버스 이미지를 BLOB으로 변환 (비동기)
    canvas.toBlob((blob) => {
        if (!blob) {
            throw new Error("캔버스 이미지를 Blob으로 변환하는데 실패했습니다.");
        }

        // 5. FormData 생성
        const formData = new FormData();
        
        // Part 1: 이미지 파일 (BLOB)
        // 서블릿에서 request.getPart("imgFile")로 받음
        formData.append('imgFile', blob, imgName); 
        
        // Part 2: 메타데이터 (JSON 문자열)
        // 서블릿에서 request.getPart("metadata")로 받음
        formData.append('metadata', JSON.stringify(metadata));

        // 6. Tomcat 서블릿으로 FormData 전송
        fetch(TOMCAT_SERVLET_URL, {
            method: 'POST',
            body: formData
            // 'Content-Type': 'multipart/form-data' 헤더는
            // FormData 사용 시 브라우저가 자동으로 설정합니다.
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => { throw new Error(`서버 저장 실패: ${text}`) });
            }
            return response.json(); // 또는 response.text()
        })
        .then(data => {
            // 저장 성공
            console.log("저장 성공:", data);
            modalText.innerHTML = `<p>데이터를 성공적으로 저장했습니다.</p>`;
            modal.style.display = 'block';
        })
        .catch(err => {
            // 저장 실패
            console.error("저장 실패:", err);
            modalText.innerHTML = `<p style="color: red;"><strong>저장 실패:</strong> ${err.message}</p>`;
            modal.style.display = 'block';
        })
        .finally(() => {
            saveButton.disabled = false;
            saveButton.textContent = 'DB에 저장';
        });

    }, 'image/png'); // Blob 형식 지정

  } catch (error) {
    console.error("저장 준비 중 오류:", error);
    modalText.innerHTML = `<p style="color: red;"><strong>오류:</strong> ${error.message}</p>`;
    modal.style.display = 'block';
    saveButton.disabled = false;
    saveButton.textContent = 'DB에 저장';
  }
});


/**
 * 5. Naver Clova OCR + Gemini 결과를 받아 div 오버레이를 생성하는 함수
 */
function drawOcrResults(data) {
  // 서버에서 이미 'isFood: true'인 것만 필터링해서 보내줌
  const fields = data.images[0].fields; 
  
  if (!fields || fields.length === 0) {
      // 서버가 fields를 보냈지만 0개인 경우 (즉, 음식을 하나도 못 찾은 경우)
      modalText.innerHTML = `<p>이미지를 분석했으나, 음식으로 인식된 텍스트가 없습니다.</p>`;
      modal.style.display = "block";
      return;
  }

  // 필터링된 '음식' 항목들을 순회
  fields.forEach(field => {
    // 이제 모든 field는 isFood: true 입니다.
    const vertices = field.boundingPoly.vertices;
    const text = field.inferText; // 원본 텍스트 (예: 김치찌개)
    
    // ColorThief 데이터
    const bgColor = field.detectedBackgroundColor; 
    const textColor = field.detectedTextColor;
    
    // Gemini 데이터
    const translatedText = field.translatedText; // 번역된 텍스트 (예: Kimchi Jjigae)
    const description = field.description; // 설명

    // 좌표 계산
    const xCoords = vertices.map(v => v.x);
    const yCoords = vertices.map(v => v.y);
    const minX = Math.min(...xCoords);
    const minY = Math.min(...yCoords);
    const maxX = Math.max(...xCoords);
    const maxY = Math.max(...yCoords);
    const width = maxX - minX;
    const height = maxY - minY;

    // 오버레이 div 생성
    const overlayBox = document.createElement('div');
    overlayBox.style.left = `${minX}px`;
    overlayBox.style.top = `${minY}px`;
    overlayBox.style.width = `${width}px`;
    overlayBox.style.height = `${height}px`;

    // 색상 적용 (서버에서 받은 값이 없으면 기본값 사용)
    overlayBox.style.color = textColor || 'rgb(0,0,0)';
    overlayBox.style.backgroundColor = bgColor || 'rgba(255,255,255,0)';
    
    // 텍스트 크기 및 세로 정렬
    overlayBox.style.fontSize = `${Math.max(10, height * 0.7)}px`;
    overlayBox.style.lineHeight = `${height}px`; 

    // Gemini 분석 결과 적용 (CSS 클래스 및 텍스트)
    overlayBox.className = 'ocr-box is-food';
    overlayBox.textContent = translatedText; // 번역된 텍스트를 div에 표시
    
    // 클릭 이벤트 추가 (모달 띄우기)
    overlayBox.addEventListener('click', () => {
      // --- [TTS 로직 포함된 코드] ---
      // 1. h3를 div로 변경하고, 원본 텍스트 div에 ID와 스타일 추가
      modalText.innerHTML = `
        <p><h2>원본:</h2><div id="tts-original" style="cursor: pointer; background: #f0f0f0; padding: 5px; border-radius: 4px; display: inline-block;">${text} 🔊</div></p>
        <p><h2>번역:</h2><div>${translatedText}</div></p>
        <p><h2>설명:</h2><div>${description}</div></p>
      `;

      // 2. 모달 보이기
      modal.style.display = 'block';

      // 3. '원본' 텍스트 div를 찾아서 TTS 클릭 이벤트 추가
      const ttsButton = modalText.querySelector('#tts-original');
      if (ttsButton) {
        ttsButton.addEventListener('click', () => {
          // Web Speech API (TTS) 실행
          try {
            // 진행 중인 다른 음성 중지
            window.speechSynthesis.cancel();
            
            // 새 발화(Utterance) 객체 생성
            const utterance = new SpeechSynthesisUtterance(text);
            
            // 언어 설정 (한국어)
            utterance.lang = 'ko-KR';
            
            // 음성 재생
            window.speechSynthesis.speak(utterance);
          } catch (e) {
            console.error("TTS 실행 오류:", e);
          }
        });
      }
      // --- [TTS 코드 끝] ---
    });

    // 완성된 div를 이미지 컨테이너에 추가
    imageContainer.appendChild(overlayBox);
  });
}

