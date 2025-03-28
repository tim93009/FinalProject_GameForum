$(document).ready(function () {
    // 綁定增加數量按鈕的事件
    $('.btn-increase').on('click', function () {
        updateQuantity($(this).data('cart-id'), 1);
    });

    // 綁定減少數量按鈕的事件
    $('.btn-reduce').on('click', function () {
        updateQuantity($(this).data('cart-id'), -1);
    });

    // 綁定移除按鈕的事件，將數量設為 0
    $('.btn-remove').on('click', function () {
        updateQuantity($(this).data('cart-id'), 0);
    });

    // 綁定手動輸入數量的事件
    $('.quantity-input').on('change', function () {
        var cartId = $(this).data('cart-id');
        var newQuantity = parseInt($(this).val());
        var stock = parseInt($('tr[data-cart-id="' + cartId + '"]').data('stock')); // 從 data-stock 獲取庫存

        // 驗證輸入值
        if (isNaN(newQuantity) || newQuantity < 0) {
            $(this).val(1);
            newQuantity = 1;
        } else if (newQuantity > stock) {
            $(this).val(stock); // 限制為庫存數量
            newQuantity = stock;
            showMessage(`庫存僅剩 ${stock} 件`, false);
        }
        updateQuantity(cartId, newQuantity, true);
    });

    // 清空購物車按鈕的事件
    $('.btn-clear-cart').on('click', function () {
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
                            $('.cart-actions').hide();
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

    // 更新購物車數量的核心函數
    function updateQuantity(cartId, change, isManual = false) {
        var $row = $('tr[data-cart-id="' + cartId + '"]');
        var $quantityInput = $row.find('.quantity-input');
        var currentQuantity = parseInt($quantityInput.val());
        var stock = parseInt($row.data('stock')); // 從 data-stock 獲取庫存
        var newQuantity;

        if (isManual) {
            newQuantity = change; // 手動輸入直接使用輸入值
        } else {
            newQuantity = change === 0 ? 0 : currentQuantity + change; // 按鈕操作則增減
        }

        // 前端檢查庫存限制
        if (newQuantity > stock) {
            newQuantity = stock;
            $quantityInput.val(stock);
            showMessage(`庫存僅剩 ${stock} 件`, false);
            return; // 不發送請求，直接返回
        } else if (newQuantity < 0) {
            newQuantity = 0;
        }

        $.ajax({
            url: '/ShoppingCart/UpdateCartQuantity',
            type: 'POST',
            data: { shoppingCartId: cartId, quantity: newQuantity },
            headers: {
                "RequestVerificationToken": $('input[name="__RequestVerificationToken"]').val()
            },
            success: function (response) {
                if (response.success) {
                    if (response.removed || newQuantity <= 0) {
                        $row.remove();
                        //showMessage('已移除商品', true);
                        if (!$('tbody tr').length) {
                            $('.cart-container').html('<p>您的購物車是空的。</p>');
                            $('.cart-actions').hide();
                        }
                    } else {
                        $quantityInput.val(response.newQuantity);
                        var subtotal = response.newQuantity * response.price;
                        $row.find('.subtotal').text('NT$' + subtotal);
                        //showMessage('數量更新成功', true);
                        // 更新前端庫存（若後端庫存可能動態變化）
                        $row.data('stock', response.stock);
                    }
                } else {
                    showMessage(response.message || '操作失敗', false);
                    // 若失敗，恢復到當前庫存或後端返回的數量
                    if (response.stock !== undefined) {
                        $quantityInput.val(Math.min(currentQuantity, response.stock));
                    }
                }
            },
            error: function () {
                showMessage('發生錯誤，請稍後再試。', false);
            }
        });
    }

    // 顯示提示訊息的函數
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