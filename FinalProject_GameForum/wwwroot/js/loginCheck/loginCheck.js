$(document).ready(function () {
    // 當帶有 data-check-login 屬性的按鈕被點擊時執行
    $("button[data-check-login]").on("click", function (e) {
        e.preventDefault(); // 阻止原本按鈕的預設行為
        var targetUrl = $(this).attr("data-target-url"); // 取得原本應該導向的網址

        // 呼叫後端的檢查登入狀態（請確保你有相對應的 Action 並綁定 LoginCheckFilter）
        $.ajax({
            url: "/Login/CheckLoginStatus", // 請在 Controller 中設定一個對應的 Action
            type: "GET",
            dataType: "json",
            success: function (response) {
                if (response.loggedIn === false) {
                    // 未登入，顯示 Bootstrap Modal
                    $("#loginModal").modal("show");

                    // 當使用者點擊 Modal 的「確定」按鈕後，跳轉至登入頁面
                    $("#loginModalConfirm").one("click", function () {
                        window.location.href = "/Login/Login"; // 可依需求修改為正確的登入路徑
                    });
                } else {
                    // 已登入，繼續原本的操作，導向指定網址（若有設定）
                    if (targetUrl) {
                        window.location.href = targetUrl;
                    }
                }
            },
            error: function () {
                console.error("檢查登入狀態失敗！");
            }
        });
    });
});