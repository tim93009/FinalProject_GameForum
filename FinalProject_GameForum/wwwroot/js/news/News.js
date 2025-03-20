document.getElementById("commentForm").addEventListener("submit", function (e) {
	var isAuthenticated = this.dataset.authenticated === "True";
	if (!isAuthenticated) {
		e.preventDefault(); // 阻止表單提交
		alert("請先登入！");
	}
});