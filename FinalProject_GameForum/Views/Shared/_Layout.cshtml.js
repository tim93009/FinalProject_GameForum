$(window).scroll(function () {
    if ($(window).scrollTop() > 200) {
        if ($(".goTop").hasClass("hide")) {
            $(".goTop").toggleClass("hide");
        }
    } else {
        $(".goTop").addClass("hide");
    }
});

$(".jq-goTop").click(function (e) {
    e.preventDefault();
    $("html,body").animate({
        scrollTop: 0
    }, 600);
});

// 找到圖片元素
const goTopImage = document.getElementById('goTopImage');

// 設置圖片的正常和懸停狀態圖片路徑
const normalImage = "~/img/Layout/ps_dpad.png"; // 正常狀態圖片路徑
const hoverImage = "~/img/Layout/ps_dpad_up.png"; // 懸停狀態圖片路徑

// 當鼠標懸停時更換圖片
goTopImage.addEventListener('mouseenter', function () {
    goTopImage.src = hoverImage;
});

// 當鼠標移開時恢復正常圖片
goTopImage.addEventListener('mouseleave', function () {
    goTopImage.src = normalImage;
});
