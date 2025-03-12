/* 置頂功能 */
$(document).ready(function () {
    const $goTopButton = $(".goTop");
    const $jqGoTopButton = $(".jq-goTop");
    const $goTopImage = $('#goTopImage'); 
    const normalImage = "/img/Layout/tile_0272.png";
    const hoverImage = "/img/Layout/tile_0273.png";

    // 滾動事件處理
    $(window).scroll(function () {
        $goTopButton.toggleClass("hide", $(window).scrollTop() <= 200);
    });

    // 點擊返回頂部
    $jqGoTopButton.click(function (e) {
        e.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, 600);
    });
        
});

/* 漢堡選單 */
document.addEventListener('DOMContentLoaded', function () { 
    const hamburgerMenu = document.getElementById('hamburgerMenu');
    const popup = document.getElementById('popup');
    const closeBtn = document.getElementById('closeBtn');

    // 點擊漢堡選單顯示提示框
    hamburgerMenu.addEventListener('click', function () {
        popup.classList.toggle('active'); // 顯示或隱藏提示框
        hamburgerMenu.classList.toggle('active'); // 漢堡選單切換為"X"
    });

    // 點擊關閉按鈕關閉提示框
    closeBtn.addEventListener('click', function () {
        popup.classList.remove('active'); // 隱藏提示框
        hamburgerMenu.classList.remove('active'); // 恢復漢堡選單為三條線
    });
})