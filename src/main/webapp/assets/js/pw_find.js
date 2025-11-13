/*<!-- (선택) 아주 가벼운 클라이언트 검증: 둘 다 비었으면 막기 -->*/
/*
document.getElementById('findForm').addEventListener('submit', function(e) {
	const id = document.getElementById('uid').value.trim();
	const email = document.getElementById('uemail').value.trim();
	if (!id && !email) {
		e.preventDefault();
		alert('아이디 또는 이메일 중 하나를 입력해주세요.');
		document.getElementById('uid').focus();
	}
});
*/

let num1;
let num2;

let uid;
let uemail;
let send;



window.onload=function(){
	num1 = 0;
	num2 = 0;
	
	uid = document.getElementById("uid");
	uemail = document.getElementById("uemail");
	send = document.getElementById("send");

	uid.addEventListener("input", ()=>{
		let ue = uemail.value;
		if(uemail.value==null)ue="dummy";
		fetch("CheckEmail.do?id="+uid.value+"&email="+ue)
		.then(function(res){
			//console.log(res);
			return res.json();
			
		})
		.then(function(data){
			console.log(data);
			let check = document.getElementById("humancheck");
			if(document.getElementById("pid")!=null)
				check.removeChild(document.getElementById("pid"));
			let p = document.createElement("p");
			p.setAttribute("id", "pid");
			//if(data.email !=null){
			if(data.checkok == "ok"){
				//console.log("ok");
				p.innerText = "문제의 정답을 입력시 비밀번호 보내기 버튼이 활성화됩니다.";
				p.style.color = "#00ff00";
				num1 = Math.floor(Math.random()*10);
				num2 = Math.floor(Math.random()*10);
				
				let checkquestion = document.getElementById("checkquestion");
				let checkanswer = document.getElementById("checkanswer");
				checkquestion.innerText = "";
				checkanswer.value = "";
				checkquestion.style.visibility = "visible";
				checkanswer.style.visibility = "visible";
				checkquestion.innerText = "" + num1 + "+" + num2 + " = ?";
				//send.innerText = "임시 비밀번호 보내기";
				//send.disabled = false;
			}else{
				//console.log("not ok");
				p.innerText = "해당하는 email을 찾을 수 없습니다.";
				p.style.color = "#ff0000";
				send.innerText = "임시 비밀번호 보내기(비활성)";
				send.disabled = true;
				checkquestion.innerText = "";
				checkanswer.value = "";
				checkquestion.style.visibility = "hidden";
				checkanswer.style.visibility = "hidden";
			}
			
			check.appendChild(p);
		})
		.catch(function(err){
			console.error(err);
		});
		
	});

	uemail.addEventListener("input", ()=>{
		fetch("CheckEmail.do?id="+uid.value+"&email="+uemail.value)
		.then(function(res){
			//console.log(res);
			return res.json();
			
		})
		.then(function(data){
			console.log(data);
			let check = document.getElementById("humancheck");
			if(document.getElementById("pid")!=null)
				check.removeChild(document.getElementById("pid"));
			let p = document.createElement("p");
			p.setAttribute("id", "pid");
			//if(data.email !=null){
			if(data.checkok == "ok"){
				//console.log("ok");
				p.innerText = "문제의 정답을 입력시 비밀번호 보내기 버튼이 활성화됩니다.";
				p.style.color = "#00ff00";
				num1 = Math.floor(Math.random()*10);
				num2 = Math.floor(Math.random()*10);
				
				let checkquestion = document.getElementById("checkquestion");
				let checkanswer = document.getElementById("checkanswer");
				checkquestion.innerText = "";
				checkanswer.value = "";
				checkquestion.style.visibility = "visible";
				checkanswer.style.visibility = "visible";
				checkquestion.innerText = "" + num1 + "+" + num2 + " = ?";
				//send.innerText = "임시 비밀번호 보내기";
				//send.disabled = false;
			}else{
				//console.log("not ok");
				p.innerText = "해당하는 email을 찾을 수 없습니다.";
				p.style.color = "#ff0000";
				send.innerText = "임시 비밀번호 보내기(비활성)";
				send.disabled = true;
				checkquestion.innerText = "";
				checkanswer.value = "";
				checkquestion.style.visibility = "hidden";
				checkanswer.style.visibility = "hidden";
			}
			
			check.appendChild(p);
		})
		.catch(function(err){
			console.error(err);
		});
		
	});
}

function calc_check(){
	let checkanswer = document.getElementById("checkanswer");
	if(checkanswer.value!="")
		if(!isNaN(checkanswer.value))
			if(parseInt(checkanswer.value) == num1 + num2){
				let send = document.getElementById("send");
				send.innerText = "임시 비밀번호 보내기";
				send.disabled = false;
			}else{
				let send = document.getElementById("send");
				send.innerText = "임시 비밀번호 보내기(비활성)";
				send.disabled = true;
			}
				
}