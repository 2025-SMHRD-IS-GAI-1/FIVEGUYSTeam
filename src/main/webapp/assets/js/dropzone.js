document.addEventListener('DOMContentLoaded', () => {
	    const dropzone = document.getElementById('dropzone');
	    const fileInput = document.getElementById('file');
	    const canvas = document.getElementById('captureCanvas');
	    const ctx = canvas.getContext('2d');
	    
	    const dropper = document.getElementById("dropper");

	    // --- 1. 파일 처리 및 캔버스에 그리기 함수 ---
		/*
	    function handleFile(file) {
	        if (file && file.type.startsWith('image/')) {
	            const reader = new FileReader();

	            reader.onload = (e) => {
	                const img = new Image();
	                img.onload = () => {
	                    // 캔버스 크기를 dropzone의 실제 크기로 설정
	                    // CSS에서 dropzone의 크기(min-height 등)가 지정되어 있어야 함
	                    canvas.width = dropzone.offsetWidth;
	                    canvas.height = dropzone.offsetHeight;

	                    // 이미지 비율을 유지하면서 캔버스에 꽉 차게(contain) 계산
	                    const hRatio = canvas.width / img.width;
	                    const vRatio = canvas.height / img.height;
	                    const ratio = Math.min(hRatio, vRatio); // 'contain' 비율
	                    
	                    const scaledWidth = img.width * ratio;
	                    const scaledHeight = img.height * ratio;

	                    // 캔버스 중앙에 이미지를 배치하기 위한 좌표 계산
	                    const x = (canvas.width - scaledWidth) / 2;
	                    const y = (canvas.height - scaledHeight) / 2;

	                    // 캔버스를 지우고 새 이미지 그리기
	                    ctx.clearRect(0, 0, canvas.width, canvas.height);
	                    ctx.drawImage(img, x, y, scaledWidth, scaledHeight);

	                    // 'has-file' 클래스를 추가하여 CSS로 힌트를 숨기고 캔버스를 표시
	                    //dropzone.classList.add('has-file');
	                };
	                img.src = e.target.result; // FileReader가 읽은 데이터(Data URL)를 이미지 소스로 설정
	            };
	            
	            reader.readAsDataURL(file); // 파일을 Data URL로 읽기 시작
	        }
	        if(dropper!=null){
	        	if(dropper.parentNode!=null)
	        		dropper.parentElement.removeChild(dropper);
	        }
	        document.getElementById("captureCanvas").style.display = "block";
	    }
		*/
		function handleFile(file) {
			        if (file && file.type.startsWith('image/')) {
			            const reader = new FileReader();

			            reader.onload = (e) => {
			                const img = new Image();
			                img.onload = () => {
			                    
			                    // --- 로직 수정 ---
			                    // 1. dropzone의 현재(최대) 너비를 가져옴 (레이아웃을 깨지 않기 위해)
			                    const maxWidth = dropzone.offsetWidth;
			                    
			                    const naturalWidth = img.naturalWidth;
			                    const naturalHeight = img.naturalHeight;

			                    let displayWidth = naturalWidth;
			                    let displayHeight = naturalHeight;

			                    // 2. 이미지가 dropzone의 최대 너비와 다르면, 비율에 맞게 조정
			                    if (naturalWidth != maxWidth) {
			                        const scaleRatio = maxWidth / naturalWidth;
			                        displayWidth = maxWidth;
			                        displayHeight = naturalHeight * scaleRatio;
			                    }

			                    // 3. 캔버스의 크기를 계산된 표시 크기로 설정
			                    canvas.width = displayWidth;
			                    canvas.height = displayHeight;
			                    
			                    // 4. 캔버스에 이미지를 (0,0)부터 계산된 크기까지 그림
			                    ctx.clearRect(0, 0, canvas.width, canvas.height);
			                    ctx.drawImage(img, 0, 0, displayWidth, displayHeight);

			                    // 5. [핵심] dropzone div의 높이를 캔버스(이미지) 높이에 딱 맞게 조절
			                    //    (너비는 CSS에 의해 100%로 이미 맞춰져 있음)
			                    dropzone.style.height = displayHeight + 'px';
			                    
			                    // 6. 'has-file' 클래스 추가 (CSS가 힌트 숨기고 캔버스 표시)
			                    dropzone.classList.add('has-file');
			                    // --- 로직 수정 끝 ---
			                };
			                img.src = e.target.result; 
			            };
			            
			            reader.readAsDataURL(file);
			        }
			    }
	    
	    // --- 3. 파일 입력창에서 파일 선택 시 ---
	    fileInput.addEventListener('change', () => {
	    	if(dropper!=null){
	    		if(dropper.parentNode!=null)
	        		dropper.parentElement.removeChild(dropper);
	        }
	        document.getElementById("captureCanvas").style.display = "block";
	        
	        if (fileInput.files.length > 0) {
	            handleFile(fileInput.files[0]);
	        }
	    });

	    // --- 4. 드래그 앤 드롭 이벤트 처리 ---

	    // 드래그 오버: 기본 동작(파일 열기) 방지 및 시각적 피드백
	    dropzone.addEventListener('dragover', (e) => {
	        e.preventDefault(); 
	        dropzone.classList.add('dragover');
	    });

	    // 드래그 리브: 시각적 피드백 제거
	    dropzone.addEventListener('dragleave', (e) => {
	        e.preventDefault();
	        dropzone.classList.remove('dragover');
	    });

	    // 드롭: 기본 동작 방지, 파일 처리
	    dropzone.addEventListener('drop', (e) => {
	        e.preventDefault();
	        dropzone.classList.remove('dragover');

	        const files = e.dataTransfer.files;
	        if (files.length > 0) {
	        	if(dropper!=null){
	        		if(dropper.parentNode!=null)
		        		dropper.parentElement.removeChild(dropper);
		        }
		        document.getElementById("captureCanvas").style.display = "block";
	        	
	            // 중요: 드롭된 파일을 file input의 files 리스트에 할당
	            // 이렇게 해야 form을 submit할 때 파일이 함께 전송됩니다.
	            fileInput.files = files;
	            handleFile(files[0]); // 첫 번째 파일만 캔버스에 표시
	        }
	    });
	});