/* 置頂功能 */
$(document).ready(function () {
    const $goTopButton = $(".goTop");
    const $jqGoTopButton = $(".jq-goTop");

    // 滾動事件處理
    $(window).on('scroll', _.throttle(function () {
        requestAnimationFrame(function () {
            const scrollTop = $(window).scrollTop();
            $goTopButton.toggleClass("hide", scrollTop <= 200);
        });
    }, 100));

    // 點擊返回頂部
    $jqGoTopButton.click(function (e) {
        e.preventDefault();

        const scrollToTop = function () {
            const currentScroll = window.scrollY;
            if (currentScroll > 0) {
                window.scrollTo(0, currentScroll - currentScroll / 8);
                requestAnimationFrame(scrollToTop);
            } else {
                window.scrollTo(0, 0);
            }
        };

        requestAnimationFrame(scrollToTop);
    });
});

/* 漢堡選單 */
document.addEventListener('DOMContentLoaded', function () {
    const hamburgerMenu = document.getElementById('hamburgerMenu');
    const popup = document.getElementById('popup');

    // 點擊漢堡選單顯示提示框
    hamburgerMenu.addEventListener('click', function () {
        popup.classList.toggle('active'); // 顯示或隱藏提示框
        hamburgerMenu.classList.toggle('active'); // 漢堡選單切換為"X"
    });
});