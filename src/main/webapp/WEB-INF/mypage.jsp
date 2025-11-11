<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.pro.model.MemberVO" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" href="${ctx}/assets/css/mypage.css" />
<style>
/* 아이콘 컨테이너 스타일 (Flexbox 사용) */
.icon-grid {
  display: flex; /* 자식 요소들을 가로로 정렬 */
  flex-wrap: wrap; /* 컨테이너를 넘치면 다음 줄로 */
  gap: 15px; /* 이미지들 사이의 간격 */
  padding: 20px;
  border: 1px solid #eee;
  background-color: #f9f9f9;
  border-radius: 8px;
  max-width: 1000px; /* 컨테이너 최대 너비 설정 (선택 사항) */
  margin: 0 auto; /* 가운데 정렬 (선택 사항) */
}

/* 개별 아이콘 이미지 스타일 */
.icon-grid img {
  width: 200px; /* 너비 200px */
  height: 200px; /* 높이 200px */
  object-fit: cover; /* 이미지가 잘리지 않도록 비율 유지 */
  border-radius: 8px; /* 모서리를 둥글게 (아이콘 느낌) */
  box-shadow: 2px 2px 5px rgba(0,0,0,0.1); /* 그림자 효과 (선택 사항) */
  transition: transform 0.2s ease-in-out; /* 호버 효과를 위한 전환 */
  cursor: pointer; /* 클릭 가능한 모양으로 변경 */
}

/* 마우스 오버 시 효과 (선택 사항) */
.icon-grid img:hover {
  transform: scale(1.05); /* 약간 확대 */
}
</style>

<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=396336d1f7971253dd7edc7d3d680240&amp;libraries=services"></script>

<!-- 
<script charset="UTF-8" src="http://t1.daumcdn.net/mapjsapi/js/main/4.4.20/kakao.js"></script>
<script charset="UTF-8" src="http://t1.daumcdn.net/mapjsapi/js/libs/services/1.0.2/services.js"></script>
 -->

</head>
<body>
<c:if test="${empty sessionScope.info}">
	<script>location.href = "Gologin.do"</script>                     
</c:if>
<%

if(session.getAttribute("imageupdate")!=null){
	if(   ( (String)session.getAttribute("imageupdate") ).equals("ok")      ){
%>
		<script>alert("이미지정보 업데이트 성공");</script>
<%
		session.setAttribute("imageupdate", "notok");
	}
}
%>
	<div class="wrap">
		<!-- 상단 브랜드 바 -->
		<div class="brand">
			<img src="${ctx}/img/팀로고.png" alt="FIVE GUYS" />
			<div class="t">FIVE GUYS - Menu Translator</div>
			<div class="spacer"></div>
			
			<a href="${ctx}/Goresult.do" class="mini-nav">홈</a> 
			<a href="${ctx}/logout.do" class="link">로그아웃</a>
		</div>

		<!-- 메인 카드 -->
		<div class="card">
			<!-- 왼쪽: 프로필/보안 -->
			<div class="left">
				<h2>프로필</h2>
				
				<!-- 현재 이메일 표시 -->
				<div class="box">
					<div class="row">
						<label>이름 : <span>${sessionScope.info.name}</span></label>
						<br>
						<label>이메일 : <span>${sessionScope.info.email}</span></label>
					</div>
				</div>
				
					

				

				            <!-- 비밀번호 변경 -->
            <div class="box">
               <h3>비밀번호 변경</h3>
               <form method="post" class="form" autocomplete="off"
                  onsubmit="return false;">
                  <div class="row">
                     <label>현재 비번</label><input name="curPw" id="curPw"
                        type="password" required />
                  </div>
                  <div class="row">
                     <label>새 비번</label><input name="newPw" id="newPw" type="password"
                        minlength="8" required />
                  </div>
                  <div class="row">
                     <label>확인</label><input name="newPw2" id="newPw2" type="password"
                        minlength="8" required />
                  </div>
                  <button class="btn outline" id="Pwbtn">비밀번호 변경</button>
                  <c:if test="${param.pwok=='1'}">
                     <div class="ok">비밀번호가 변경되었습니다.</div>
                  </c:if>
                  <c:if test="${param.pwerr=='1'}">
                     <div class="err">비밀번호 변경에 실패했습니다. 입력값을 확인하세요.</div>
                  </c:if>
                  </form>
            </div>

            <!-- 회원 탈퇴 -->
            <div class="box">
               <h3>회원 탈퇴</h3>
               <form method="post" action="${ctx}/DeleteAccount.do" class="form"
                  onsubmit="return confirm('정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.');"
                  autocomplete="off" id="delbtn">
                  <div class="row">
                     <label>비밀번호</label><input name="pw" type="password" id="delpw"
                        required />
                  </div>
                  <button class="btn outline">탈퇴하기</button>
                  <c:if test="${delErr=='1'}">
                     <div class="err">비밀번호가 올바르지 않거나 탈퇴에 실패했습니다.</div>
                  </c:if>
               </form>
            </div>
         </div>
			
		

			<!-- 오른쪽: 내 활동 -->
			<div class="right">
				<div class="panel">
					<h2>내 활동</h2>
					<!-- 내 사진 목록 -->
					<h3 style="margin-top: 0">내 사진</h3>
					<!-- 
					<input type="button" onclick="getImages()" value="사진가져오기"/>
					 -->
					<div id="iconContainer" class="icon-grid">	
					<p class="muted">아직 업로드한 사진이 없습니다.</p>
					</div>
					

					<!-- 즐겨찾기 목록 -->
					<h3 style="margin-top: 0">즐겨찾기</h3>
					<div id="iconContainer2" class="icon-grid">	
					<p class="muted">즐겨찾기로 등록한 사진이 없습니다.</p>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 다른 페이지처럼 세부기능은 모달창 사용하여 구현  -->
	<div id="infoModal" class="modal">
        <div class="modal-content" 
             style="display: flex; flex-direction: column; 
                    max-width: 900px; max-height: 100vh; 
                    overflow: hidden;
                    position: relative;">
            
            <span class="close-button" 
                  style="position: absolute; top: 12px; right: 15px; 
                         font-size: 28px; font-weight: bold; 
                         cursor: pointer; z-index: 10; 
                         line-height: 1;">&times;</span>

            <div class="top-section" 
                 style="flex: 1; min-height: 0; display: flex; gap: 20px; 
                        padding: 10px; border-bottom: 2px solid #ccc;">

                <div class="modal-image-section" 
                     style="flex: 1.5; position: relative; overflow: auto; 
                            border: 1px solid #ccc; background: #f0f0f0;">
                    
                    <img id="modalImg" style="display: block; width: auto; height: auto; max-width: none;" /> 
                    <div id="modalOverlayContainer" 
                         style="position: absolute; top: 0; left: 0; width: 0; height: 0;">
                    </div>
                </div>

                <div class="modal-right-info" style="flex: 1; overflow-y: auto;">
                    <p class="muted" style="font-size: 13px; margin-top: -10px; margin-bottom: 10px;">
                    <h3 style="margin-top:0;">이미지 위의 번역된 메뉴를 클릭하세요.</h3>
                    </p>
                    
                    <label style="font-size: 12px; color: #555; display: block; margin-bottom: 5px;">
                        메뉴 이름 (원본)
                    </label>
                    <input type="text" id="inputMenuName" readonly 
                           style="width: 100%; box-sizing: border-box; padding: 8px; background: #eee;">
                    <label style="font-size: 12px; color: #555; display: block; margin-top: 10px; margin-bottom: 5px;">
                        메뉴명 번역
                    </label>
                    <input type="text" id="inputMenuTrans" readonly 
                           style="width: 100%; box-sizing: border-box; padding: 8px; background: #eee;">
                    <label style="font-size: 12px; color: #555; display: block; margin-top: 10px; margin-bottom: 5px;">
                        메뉴 설명
                    </label>
                    <textarea id="inputMenuDesc" readonly placeholder="메뉴 설명 데이터가 없습니다."
                           style="width: 100%; box-sizing: border-box; padding: 8px; background: #eee; height: 120px; resize: vertical; font-family: inherit;"></textarea>
                </div>
            </div>

            <div class="bottom-section" 
                 style="flex: 0 0 160px; /* 160px 고정 높이 유지 */
                        padding: 5px 5px 10px 10px;
                        box-sizing: border-box;">

                <table style="width: 100%; height: 100%; border-collapse: collapse;">
                    <tbody>
                        <tr>
                            <td style="width: 60%; vertical-align: top; padding-right: 10px;">
                                <div id="map" 
                                     style="width: 100%; height: 100%; 
                                            background: #e0e0e0; border-radius: 4px; 
                                            display: flex; align-items: center; justify-content: center;">
                                    <p style="color: #888; font-size: 16px;">지도 영역</p>
                                </div>
                            </td>
                            
                            <td style="width: 40%; vertical-align: top; padding-left: 10px;">
                                <div class="store-info" style="width: 100%; height: 100%; display: flex; flex-direction: column; gap: 8px;">
                    
                                    <div style="display: flex; gap: 5px;">
                                        <input type="text" id="storeName" placeholder="상호명" 
                                               style="flex: 3; padding: 5px; box-sizing: border-box; background: #eee; font-size: 12px;">
                                        <div style="flex: 2; padding: 5px; background: #eee; border-radius: 4px; font-size: 12px; color: #555;">
                                        <div style="display: flex; justify-content: space-between; align-items: center; font-size: 12px;">
                                            <input type="radio" id="rate1" name="storeRating" value="1" ><label for="rate1">1</label>
                                            <input type="radio" id="rate2" name="storeRating" value="2" ><label for="rate2">2</label>
                                            <input type="radio" id="rate3" name="storeRating" value="3" ><label for="rate3">3</label>
                                            <input type="radio" id="rate4" name="storeRating" value="4" ><label for="rate4">4</label>
                                            <input type="radio" id="rate5" name="storeRating" value="5" ><label for="rate5">5</label>
                                        </div>
                                        </div>
                                    </div>

                                    <div style="display: flex; gap: 5px;">
                                        <input type="text" id="storeAddress" placeholder="주소" 
                                               style="flex: 1; padding: 5px; box-sizing: border-box; background: #eee; font-size: 12px;">
                                        <button type="button" id="addressSearchBtn" 
                                                style="width: 50px; padding: 5px; box-sizing: border-box; font-size: 12px; cursor: pointer;">검색</button>
                                    </div>
                                    <div style="display: flex; gap: 5px;">
                                        <input type="text" id="storeLon" placeholder="경도" readonly
                                               style="flex: 1; padding: 5px; box-sizing: border-box; background: #eee; font-size: 12px;">
                                        <input type="text" id="storeLat" placeholder="위도" readonly
                                               style="flex: 1; padding: 5px; box-sizing: border-box; background: #eee; font-size: 12px;">
                                    </div>
									<table>
									<tr>
									<td>
									<input type="button" id="reg_menupan" style="width:100%;padding: 5px; box-sizing: border-box; font-size: 12px;" onclick="regInfo()" value="정보 등록/갱신" />
									</td>
									<td>
									<select name="sel_fav"  style="width:100%;padding: 5px; box-sizing: border-box; font-size: 12px;">
										<option value="Y">즐겨찾기 등록</option>
                                    	<option value="N">즐겨찾기 해제</option>
                                    </select>
									</td>
									</tr>
									</table>
                                    <input id="hiddenImgId" type="hidden"/>
                                    
                                    	
                                </div>
                                </td>
                        </tr>
                    </tbody>
                </table>
                
            </div> </div>
    </div>
</body>
<script>
	
	let Pwbtn = document.getElementById("Pwbtn");
	let url = "ChangePw.do";
	Pwbtn.addEventListener("click", () => {
		let curPw = document.getElementById("curPw").value;
		let newPw  = document.getElementById("newPw").value;
		let newPw2 = document.getElementById("newPw2").value;
		fetch("ChangePw.do",{
			method: "POST",
			headers:{ "Content-Type": "application/x-www-form-urlencoded"},
			body :new URLSearchParams({curPw,newPw,newPw2})
		})
		.then(function(res) {
				// console.log("받아온 데이터 >> ", res);
				return res.json();
		})
		.then(function(result) {
            if (result.result == "false") {
               alert("다시 확인해주세요");
            }else if(result.result =="false2"){
               alert("기존비번안맞음요");
            }else {
               alert("비밀번호가 변경되었습니다!");
               location.href = "Gologin.do";
            }

         })
         .catch(function(err) {
            console.error(err);
         })
    });
	
</script>


<script>

//(첫 번째 스크립트 - Pwbtn 이벤트 - 는 그대로 둡니다)

let modal = document.getElementById("infoModal");
let closeBtn = document.querySelector(".close-button");
let modalImg = document.getElementById("modalImg");

let overlayContainer = document.getElementById("modalOverlayContainer");
let inputMenuName = document.getElementById("inputMenuName");
let inputMenuTrans = document.getElementById("inputMenuTrans");
let inputMenuDesc = document.getElementById("inputMenuDesc"); // textarea

// 지도 변수 전역 선언
var map; 
var geocoder;

function getImages(){
 let userId = '<%= (   (MemberVO)session.getAttribute("info")   ).getId() %>';
 let patchurl = 'GetImages.do?userId='+userId;
 let fav_delete_once = true;
 let iconContainer = document.getElementById("iconContainer");
 let iconContainer2 = document.getElementById("iconContainer2");
 
 fetch(patchurl)
 .then(function(res){
     return res.json();
 })
 .then(function(data){
     iconContainer.innerText = ""; // 컨테이너 비우기
     
     
     
     
     var str = "";
     var dataUrl = [];
     
     if (data.myImages.length === 0) {
          iconContainer.innerHTML = '<p class="muted">아직 업로드한 사진이 없습니다.</p>';
          return;
     }
     
     // 맛집정보, 즐겨찾기 기능 위한 formdata 사용
     let formdata = new FormData();
     //전달할 정보는 imgId, res_name, addr, lat, lon, ratings, img_check
     //전달받은 정보는 imgName, imgFileBase64, imgCheck, imgId,ratings,
     // uploadDt, lan, lon, id
     // resName, addr은 null일 경우 안들어온다
     
     for(let i = 0 ; i<data.myImages.length ;i++){
         /*
    	 var base64Data = data.myImages[i].imgFileBase64
         var imageType = "image/png"; // 마임타입
         var mimetype = 'data:image/png;base64,';
         dataUrl.push(mimetype + base64Data);
			*/
         
         let resName = data.myImages[i].resName;
         //let imgName = data.myImages[i].imgName;
         let addr = data.myImages[i].addr;
         let lat = data.myImages[i].lat;
         let lon = data.myImages[i].lon;
         let imgCheck = data.myImages[i].imgCheck;
         let ratings = Number(data.myImages[i].ratings);
         
         if(imgCheck=="Y" && fav_delete_once == true){
        	 fav_delete_once = false;
        	 iconContainer2.innerText = "";
         }
         
         if(resName==null)resName="";
         if(addr==null)addr="";
         
         var imgId = data.myImages[i].imgId;
         const img = document.createElement("img");
         //img.src = dataUrl[i];
         img.src = "${ctx}/GetImageFile.po?imgId=" + imgId;
         img.alt = data.myImages[i].uploadDt;
         
         img.addEventListener('click', () => {
             
             
             var fetchUrl = "GetTranslations.do?imgId="+imgId;
             
             overlayContainer.innerHTML = "";
             inputMenuName.value = "";
             inputMenuTrans.value = "";
             inputMenuDesc.value = ""; 
             inputMenuDesc.placeholder = "메뉴 설명 데이터가 없습니다.";
             
             // ==================================================
             // (★수정★) 가게 정보 input 초기화
             // ==================================================
             document.getElementById("storeName").value = resName;
             document.getElementById("storeAddress").value = addr;
             document.getElementById("storeLon").value = lon;
             document.getElementById("storeLat").value = lat;
               
             
             // 대신 라디오 버튼을 모두 선택 해제합니다.
             let radios = document.getElementsByName("storeRating");
             for(let k=0; k<radios.length; k++) {
                 radios[k].checked = false;
                 if(k+1 == ratings)radios[k].checked = true;
             }
             document.getElementById("hiddenImgId").value = imgId;
             document.getElementsByName("sel_fav")[0].value = imgCheck;
             // ==================================================

             modalImg.onload = () => {
                 
                 const naturalW = modalImg.naturalWidth; 
                 const naturalH = modalImg.naturalHeight;
                 
                 if (naturalW === 0 || naturalH === 0) {
                     console.error("이미지 원본 크기를 읽을 수 없습니다.");
                     modal.style.display = "flex";
                     return; 
                 }
                 
                 modalImg.style.width = naturalW + "px";
                 modalImg.style.height = naturalH + "px";
                 overlayContainer.style.width = naturalW + "px";
                 overlayContainer.style.height = naturalH + "px";
				 
                 fetch(fetchUrl)
                     .then(function(res){
                         return res.json();
                     })
                     .then(function(data){
                         
                         let itemsize = data.myTranslations.length;

                         for (let j = 0; j < itemsize; j++) {
                             let item = data.myTranslations[j];
                             let x1 = Number(item.x1);
                             let y1 = Number(item.y1);
                             let x2 = Number(item.x2);
                             let y2 = Number(item.y2);

                             let left = x1;
                             let top = y1;
                             let width = x2 - x1;
                             let height = y2 - y1;
                             
                             if (width < 0) width = 0;
                             if (height < 0) height = 0;

                             let overlayBox = document.createElement("div");
                             overlayBox.style.position = "absolute";
                             overlayBox.style.left = left + "px";
                             overlayBox.style.top = top + "px";
                             overlayBox.style.width = width + "px";
                             overlayBox.style.height = height + "px";
                             
                             overlayBox.style.backgroundColor = item.colorBg;
                             overlayBox.style.color = item.colorTxt;
                             overlayBox.innerText = item.transText; 
                             overlayBox.style.border = "1px solid dodgerblue";
                             overlayBox.style.boxSizing = "border-box";
                             overlayBox.style.padding = "2px 4px";
                             overlayBox.style.fontSize = "14px";
                             overlayBox.style.fontWeight = "bold";
                             overlayBox.style.overflow = "hidden";
                             overlayBox.style.cursor = "pointer";
                             overlayBox.style.textShadow = "0 0 3px rgba(0,0,0,0.7)"; 

                             overlayBox.addEventListener('mouseenter', () => {
                                 overlayBox.style.opacity = "0";
                                 overlayBox.style.transition = "opacity 0.2s ease-in-out";
                             });
                             overlayBox.addEventListener('mouseleave', () => {
                                 overlayBox.style.opacity = "1";
                             });
                             
                             overlayBox.addEventListener('click', () => {
                                 inputMenuName.value = item.menuName;
                                 inputMenuTrans.value = item.transText;
                                 inputMenuDesc.value = item.menuDesc || ""; 
                             });
                             
                             overlayContainer.appendChild(overlayBox);
                         } // for loop 끝

                         modal.style.display = "flex";
                         if(lat!="0" && lon!="0")
                         	initMap(Number(lat), Number(lon));
                         else
                        	 initMap(35.1599555, 126.8516494);

                     }) // fetch .then(data)
                     .catch(function(err){
                         console.error("번역 정보 로딩 실패:", err);
                         modal.style.display = "flex";
                     });
                     
             }; // modalImg.onload 끝
			 //modalImg.src = dataUrl[i];
             modalImg.src = "${ctx}/GetImageFile.po?imgId=" + imgId; 
         
         }); // img.addEventListener (썸네일 클릭) 끝

         iconContainer.appendChild(img);
         
		 //즐겨찾기가 하나라도 있으면 container2를 지우고 이미지를 넣을 준비
         if(imgCheck=="Y"){
        	 
         
	         const img2 = document.createElement("img");
	         //img2.src = dataUrl[i];
	         img2.src = "${ctx}/GetImageFile.po?imgId=" + imgId;
	         img2.alt = data.myImages[i].uploadDt;
	         
	         img2.addEventListener('click', () => {
	             
	             var imgId = data.myImages[i].imgId;
	             var fetchUrl = "GetTranslations.do?imgId="+imgId;
	             
	             overlayContainer.innerHTML = "";
	             inputMenuName.value = "";
	             inputMenuTrans.value = "";
	             inputMenuDesc.value = ""; 
	             inputMenuDesc.placeholder = "메뉴 설명 데이터가 없습니다.";
	             
	             // ==================================================
	             // (★수정★) 가게 정보 input 초기화
	             // ==================================================
	             document.getElementById("storeName").value = resName;
	             document.getElementById("storeAddress").value = addr;
	             document.getElementById("storeLon").value = lon;
	             document.getElementById("storeLat").value = lat;
	               
	             
	             // 대신 라디오 버튼을 모두 선택 해제합니다.
	             let radios = document.getElementsByName("storeRating");
	             for(let k=0; k<radios.length; k++) {
	                 radios[k].checked = false;
	                 if(k+1 == ratings)radios[k].checked = true;
	             }
	             document.getElementById("hiddenImgId").value = imgId;
	             document.getElementsByName("sel_fav")[0].value = imgCheck;
	             // ==================================================
	
	             modalImg.onload = () => {
	                 
	                 const naturalW = modalImg.naturalWidth; 
	                 const naturalH = modalImg.naturalHeight;
	                 
	                 if (naturalW === 0 || naturalH === 0) {
	                     console.error("이미지 원본 크기를 읽을 수 없습니다.");
	                     modal.style.display = "flex";
	                     return; 
	                 }
	                 
	                 modalImg.style.width = naturalW + "px";
	                 modalImg.style.height = naturalH + "px";
	                 overlayContainer.style.width = naturalW + "px";
	                 overlayContainer.style.height = naturalH + "px";
					 
	                 fetch(fetchUrl)
	                     .then(function(res){
	                         return res.json();
	                     })
	                     .then(function(data){
	                         
	                         let itemsize = data.myTranslations.length;
	
	                         for (let j = 0; j < itemsize; j++) {
	                             let item = data.myTranslations[j];
	                             let x1 = Number(item.x1);
	                             let y1 = Number(item.y1);
	                             let x2 = Number(item.x2);
	                             let y2 = Number(item.y2);
	
	                             let left = x1;
	                             let top = y1;
	                             let width = x2 - x1;
	                             let height = y2 - y1;
	                             
	                             if (width < 0) width = 0;
	                             if (height < 0) height = 0;
	
	                             let overlayBox = document.createElement("div");
	                             overlayBox.style.position = "absolute";
	                             overlayBox.style.left = left + "px";
	                             overlayBox.style.top = top + "px";
	                             overlayBox.style.width = width + "px";
	                             overlayBox.style.height = height + "px";
	                             
	                             overlayBox.style.backgroundColor = item.colorBg;
	                             overlayBox.style.color = item.colorTxt;
	                             overlayBox.innerText = item.transText; 
	                             overlayBox.style.border = "1px solid dodgerblue";
	                             overlayBox.style.boxSizing = "border-box";
	                             overlayBox.style.padding = "2px 4px";
	                             overlayBox.style.fontSize = "14px";
	                             overlayBox.style.fontWeight = "bold";
	                             overlayBox.style.overflow = "hidden";
	                             overlayBox.style.cursor = "pointer";
	                             overlayBox.style.textShadow = "0 0 3px rgba(0,0,0,0.7)"; 
	
	                             overlayBox.addEventListener('mouseenter', () => {
	                                 overlayBox.style.opacity = "0";
	                                 overlayBox.style.transition = "opacity 0.2s ease-in-out";
	                             });
	                             overlayBox.addEventListener('mouseleave', () => {
	                                 overlayBox.style.opacity = "1";
	                             });
	                             
	                             overlayBox.addEventListener('click', () => {
	                                 inputMenuName.value = item.menuName;
	                                 inputMenuTrans.value = item.transText;
	                                 inputMenuDesc.value = item.menuDesc || ""; 
	                             });
	                             
	                             overlayContainer.appendChild(overlayBox);
	                         } // for loop 끝
	
	                         modal.style.display = "flex";
	                         if(lat!="0" && lon!="0")
	                         	initMap(Number(lat), Number(lon));
	                         else
	                        	 initMap(35.1599555, 126.8516494);
	
	                     }) // fetch .then(data)
	                     .catch(function(err){
	                         console.error("번역 정보 로딩 실패:", err);
	                         modal.style.display = "flex";
	                     });
	                     
	             }; // modalImg.onload 끝
	
	             //modalImg.src = dataUrl[i]; 
	             modalImg.src = "${ctx}/GetImageFile.po?imgId=" + imgId; 
	         
	         }); // img.addEventListener (썸네일 클릭) 끝
	
	         iconContainer2.appendChild(img2);
         }// img2 즐겨찾기
         
     } // getImages for loop 끝
     
 })
 .catch(function(err){
     console.error("이미지 목록 로딩 실패:", err);
     iconContainer.innerHTML = '<p class="err">사진을 가져오는 데 실패했습니다.</p>';
 });
}

closeBtn.onclick = function() {
 modal.style.display = "none"; 
 modalImg.src = "";
 overlayContainer.innerHTML = "";
}

function initMap(lat, lon) {
    let mapContainer = document.getElementById('map');
    let centerCoord = new daum.maps.LatLng(lat, lon);
    
    if (!map) { 
        let mapOption = {
            center: centerCoord,
            mapTypeId: daum.maps.MapTypeId.HYBRID,
            level: 1
        };  
        map = new daum.maps.Map(mapContainer, mapOption); 
        geocoder = new daum.maps.services.Geocoder();
        
        daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
            searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                if (status === daum.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
                    document.getElementById("storeLat").value = mouseEvent.latLng.getLat();
                    document.getElementById("storeLon").value = mouseEvent.latLng.getLng();
                    document.getElementById("storeAddress").value = detailAddr;
                }   
            });
        });
    }

    setTimeout(function() {
        map.relayout();
        map.setCenter(centerCoord); 
    }, 100); 
}

function searchAddrFromCoords(coords, callback) {
    if (geocoder) geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    if (geocoder) geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

document.getElementById("addressSearchBtn").onclick = () =>{
	let addr = document.getElementById("storeAddress").value;
	let storename = document.getElementById("storeName").value;
	if(addr!=null && addr!= ""){
		geocoder.addressSearch(addr, function(result, status) {
	
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
	
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+storename+'</div>'
		        });
		        infowindow.open(map, marker);
	
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		}); 
	}
}
</script>
<script>
function regInfo(){
	
	let storeName = document.getElementById("storeName");
	let storeAddress = document.getElementById("storeAddress");
	let ratings = document.getElementsByName("storeRating");
	let rating = 0;
	for(let i =0; i <ratings.length ; i++){
		if(ratings[i].checked)rating=ratings[i].value;
	}
	let lat = document.getElementById("storeLat");
	let lon = document.getElementById("storeLon");
	let sel_fav = document.getElementsByName("sel_fav");
	
	let formData = new FormData();
	let imgId = document.getElementById("hiddenImgId");
	
	
	
	//let values = formData.values();
	//for (const pair of values) {}
	modal.style.display = "none"; 
 	modalImg.src = "";
 	overlayContainer.innerHTML = "";
 
	location.replace("UpdateImage.do?"
			+ "imgId="+imgId.value
			+ "&storeName="+storeName.value
			+ "&storeAddress="+storeAddress.value
			+ "&ratings="+rating
			+ "&lat="+lat.value
			+ "&lon="+lon.value
			+ "&imgCheck="+sel_fav[0].value);
	
	
}
</script>

<script>
window.onload = getImages();
</script>

</html>
