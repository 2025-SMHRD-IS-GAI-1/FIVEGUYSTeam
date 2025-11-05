

/*<!-- 3. JS: 이름/이메일 간단 검색   수정해야함 !! -->

const searchInput = document.getElementById('searchInput');
const rows = document.querySelectorAll('#memberTable tbody tr');

// 키보드 칠 때마다 실행
searchInput.addEventListener('keyup', function() {
	const keyword = this.value.toLowerCase();

	rows.forEach(row => {
		// 2번째 칸: 이름, 3번째 칸: 이메일
		const name = row.cells[1]?.textContent.toLowerCase();
		const email = row.cells[2]?.textContent.toLowerCase();

		if (name.includes(keyword) || email.includes(keyword)) {
			row.style.display = '';
		} else {
			row.style.display = 'none';
		}
	});
});
*/