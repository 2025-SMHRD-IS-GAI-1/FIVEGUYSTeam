/**
 * 
 */
 

		(function() {
			const form = document.querySelector('form');
			form.addEventListener('submit', function(e) {
				const pw = document.getElementById('pw').value;
				const pw2 = document.getElementById('pw2').value;
				if (pw !== pw2) {
					e.preventDefault();
					alert('비밀번호가 일치하지 않습니다.');
				}
			});
		})();