// Checkout.js
function removeItem(shoppingCartId) {
    if (confirm("確定要移除此商品嗎？")) {
        $.post("/Checkout/RemoveFromCart", { id: shoppingCartId }, function (response) {
            if (response.success) {
                $("#row" + shoppingCartId).remove();
                updateTotal();
                showMessage("商品已移除", true);
            } else {
                showMessage(response.message || "移除失敗", false);
            }
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

function showMessage(message, isSuccess) {
    var $message = $('<div class="checkout-message"></div>')
        .text(message)
        .addClass(isSuccess ? 'message-success' : 'message-danger')
        .appendTo('body')
        .css({
            position: 'fixed',
            top: '20px',
            right: '20px',
            padding: '10px 20px',
            background: isSuccess ? '#d4edda' : '#f8d7da',
            color: isSuccess ? '#155724' : '#721c24',
            border: '1px solid',
            borderColor: isSuccess ? '#c3e6cb' : '#f5c6cb',
            borderRadius: '4px',
            zIndex: 1000
        })
        .delay(3000)
        .fadeOut(function () { $(this).remove(); });
}

$(document).ready(function () {
    // 減少數量按鈕
    $(".btn-reduce-products-number").click(function () {
        const input = $(this).siblings(".product-num");
        const stock = parseInt(input.data("stock"));
        let value = parseInt(input.val());
        if (value > 1) {
            input.val(value - 1);
            updateTotal();
        }
    });

    // 增加數量按鈕
    $(".btn-add-products-number").click(function () {
        const input = $(this).siblings(".product-num");
        const stock = parseInt(input.data("stock"));
        let value = parseInt(input.val());
        if (value < stock) {
            input.val(value + 1);
            updateTotal();
        } else {
            showMessage(`庫存僅剩 ${stock} 件`, false);
        }
    });

    // 手動輸入數量
    $(".product-num").on('change', function () {
        const stock = parseInt($(this).data("stock"));
        let value = parseInt($(this).val());
        if (isNaN(value) || value < 1) {
            $(this).val(1);
        } else if (value > stock) {
            $(this).val(stock);
            showMessage(`庫存僅剩 ${stock} 件`, false);
        }
        updateTotal();
    });

    // 表單提交處理
    $("#checkoutForm").on('submit', function (e) {
        e.preventDefault(); // 阻止表單默認提交
        $.ajax({
            url: $(this).attr('action'), // /Checkout/SubmitOrder
            type: 'POST',
            data: $(this).serialize(), // 序列化表單數據
            success: function (response) {
                if (response.success) {
                    // 使用 replace 跳轉，不保留當前頁面歷史
                    window.location.replace(response.redirectUrl);
                } else {
                    showMessage(response.message || "訂單提交失敗", false);
                }
            },
            error: function () {
                showMessage("發生錯誤，請稍後再試", false);
            }
        });
    });
});