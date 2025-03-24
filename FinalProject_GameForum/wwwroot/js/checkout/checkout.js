// Checkout.js
function removeItem(shoppingCartId) {
    if (confirm("確定要移除此商品嗎？")) {
        $.post("/Checkout/RemoveFromCart", { id: shoppingCartId }, function () {
            $("#row" + shoppingCartId).remove();
            updateTotal();
        });
    }
}

function updateTotal() {
    let total = 0;
    $(".products-info-list").each(function () {
        const sn = $(this).data("sn");
        const price = parseInt($(`#row${sn} .product-num`).data("price"));
        const quantity = parseInt($(`#row${sn} .product-num`).val());
        const subtotal = price * quantity;
        $(`#subtotal${sn}`).text(subtotal + "元");
        total += subtotal;
    });
    $("#amountpaid").text(total).data("grandtotal", total);
}

$(document).ready(function () {
    $(".btn-reduce-products-number").click(function () {
        const input = $(this).siblings(".product-num");
        let value = parseInt(input.val());
        if (value > 1) {
            input.val(value - 1);
            updateTotal();
        }
    });

    $(".btn-add-products-number").click(function () {
        const input = $(this).siblings(".product-num");
        let value = parseInt(input.val());
        if (value < 999) {
            input.val(value + 1);
            updateTotal();
        }
    });

    $(".product-num").change(function () {
        updateTotal();
    });
});