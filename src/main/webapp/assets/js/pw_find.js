/*<!-- (선택) 아주 가벼운 클라이언트 검증: 둘 다 비었으면 막기 -->*/

document.getElementById('findForm').addEventListener('submit', function(e) {
	const id = document.getElementById('uid').value.trim();
	const email = document.getElementById('uemail').value.trim();
	if (!id && !email) {
		e.preventDefault();
		alert('아이디 또는 이메일 중 하나를 입력해주세요.');
		document.getElementById('uid').focus();
	}
});
