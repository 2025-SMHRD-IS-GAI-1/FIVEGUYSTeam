let id = document.getElementById("id");
let pw = document.getElementById("pw");
let login = document.getElementById("login");
let url = "login.do";
login.addEventListener("click", () => {
	fetch(url + "?id=" + id.value + "&pw=" + pw.value)
		.then(function(res) {
			// console.log("받아온 데이터 >> ", res);
			return res.json();
		})
		.then(function(result) {
			if (result.result == "false") {
				alert("다시 확인해주세요");
			} else {
				location.href = "Goresult.do";
			}

		})
		.catch(function(err) {
			console.error(err);
		})
})
