$(document).ready(function () {
    $('.btn-increase').click(function () {
        updateQuantity($(this).data('cart-id'), 1);
    });

    $('.btn-reduce').click(function () {
        updateQuantity($(this).data('cart-id'), -1);
    });

    $('.btn-remove').click(function () {
        updateQuantity($(this).data('cart-id'), 0);
    });

    $('.btn-clear-cart').click(function () {
        if (confirm('確定要清空購物車嗎？')) {
            $.ajax({
                url: '/ShoppingCart/ClearCart',
                type: 'POST',
                headers: {
                    "RequestVerificationToken": $('input[name="__RequestVerificationToken"]').val()
                },
                success: function (response) {
                    if (response.success) {
                        $('tbody').empty();
                        showMessage('購物車已清空', true);
                        if ($('.table').length && !$('tbody tr').length) {
                            $('.cart-container').html('<p>您的購物車是空的。</p>');
                        }
                    } else {
                        showMessage(response.message || '清空失敗', false);
                    }
                },
                error: function () {
                    showMessage('發生錯誤，請稍後再試。', false);
                }
            });
        }
    });

    function updateQuantity(cartId, change) {
        var $row = $('tr[data-cart-id="' + cartId + '"]');
        var $quantity = $row.find('.quantity');
        var currentQuantity = parseInt($quantity.text());
        var newQuantity = change === 0 ? 0 : currentQuantity + change;
        var price = parseInt($row.data('price')); // 從 data-price 獲取

        $.ajax({
            url: '/ShoppingCart/UpdateCartQuantity',
            type: 'POST',
            data: { shoppingCartId: cartId, quantity: newQuantity },
            headers: {
                "RequestVerificationToken": $('input[name="__RequestVerificationToken"]').val()
            },
            success: function (response) {
                if (response.success) {
                    if (newQuantity <= 0) {
                        $row.remove();
                        showMessage('已移除商品', true);
                    } else {
                        $quantity.text(response.newQuantity);
                        $row.find('.subtotal').text('NT$' + (response.newQuantity * price));
                        showMessage('數量更新成功', true);
                    }
                } else {
                    showMessage(response.message || '操作失敗', false);
                }
            },
            error: function () {
                showMessage('發生錯誤，請稍後再試。', false);
            }
        });
    }

    function showMessage(message, isSuccess) {
        var $cartMessage = $('#cart-message');
        $cartMessage
            .text(message)
            .removeClass('cart-message-success cart-message-danger')
            .addClass(isSuccess ? 'cart-message-success' : 'cart-message-danger')
            .show()
            .delay(3000)
            .fadeOut();
    }
});