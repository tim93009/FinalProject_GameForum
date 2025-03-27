function goToFloor() {
    // 取得輸入的樓層數
    var floorNumber = document.getElementById("floorInput").value;

    // 確保輸入的值有效
    if (!floorNumber || floorNumber < 1) {
        alert("請輸入有效的樓層數！");
        return;
    }

    // 找到對應的樓層 div
    var floorElement = document.getElementById("floor-" + floorNumber);
    if (floorElement) {
        // 滾動到該樓層
        floorElement.scrollIntoView({ behavior: "smooth", block: "start" });

        // 也可以使用網址 hash 變更
        window.location.hash = "floor-" + floorNumber;
    } else {
        alert("找不到該樓層！");
    }
}

// 允許使用 Enter 鍵執行跳轉
document.getElementById("floorInput").addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        goToFloor();
    }
});

$(function () {
    $("#subscribeBtn").on("click", function () {
        var articleGroupId = $(this).data("article-group-id");

        $.post("/Article/Subscribe", { articleGroupId: articleGroupId }, function (response) {
            alert(response.message);

            if (response.isSubscribed) {
                $("#subscribeBtn").text("取消訂閱");
            } else {
                $("#subscribeBtn").text("訂閱");
            }
        });
    });
});
