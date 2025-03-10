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
    $("html,body").animate(
        {
            scrollTop: 0
        },

        600);

});