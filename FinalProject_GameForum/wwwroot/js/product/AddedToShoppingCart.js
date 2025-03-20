// 當文件載入完成時執行
$(document).ready(function () {
    // 為所有有 'btn-add-to-cart' 類別的按鈕綁定點擊事件
    $('.btn-add-to-cart').click(function () {
        // 從按鈕的 data-product-id 屬性獲取產品ID
        var productId = $(this).data('product-id');
        // 從顯示產品數量的元素中獲取數量並轉為整數
        var quantity = parseInt($('.show-products-number').text());

        // 發送 AJAX 請求
        $.ajax({
            // 請求的目標 URL
            url: '/Product/AddToCart',
            // 使用 POST 方法
            type: 'POST',
            // 發送的資料，包含產品ID和數量
            data: { productId: productId, quantity: quantity },

            // 請求成功時的回調函數
            success: function (response) {
                // 獲取顯示訊息的元素
                var $cartMessage = $('#cart-message');

                // 檢查回應是否成功
                if (response.success) {
                    $cartMessage
                        // 移除失敗樣式
                        .removeClass('cart-message-danger')
                        // 添加成功樣式
                        .addClass('cart-message-success')
                        // 設置成功訊息
                        .text('加入購物車成功！')
                        // 顯示訊息
                        .show()
                        // 延遲3秒
                        .delay(3000)
                        // 淡出效果
                        .fadeOut();
                } else {
                    $cartMessage
                        // 移除成功樣式
                        .removeClass('cart-message-success')
                        // 添加失敗樣式
                        .addClass('cart-message-danger')
                        // 設置失敗訊息，若 response.message 無值則使用預設訊息
                        .text(response.message || '加入購物車失敗，請稍後再試。')
                        // 顯示訊息
                        .show()
                        // 延遲5秒
                        .delay(5000)
                        // 淡出效果
                        .fadeOut();
                }
            },

            // 請求失敗時的回調函數
            error: function () {
                // 當發生錯誤（例如未登入）時顯示的訊息
                $('#cart-message')
                    // 移除成功樣式
                    .removeClass('cart-message-success')
                    // 添加失敗樣式
                    .addClass('cart-message-danger')
                    // 設置未登入的錯誤訊息
                    .text('您尚未登入，加入購物車失敗，請登入後再試。')
                    // 顯示訊息
                    .show()
                    // 延遲10秒
                    .delay(10000)
                    // 淡出效果
                    .fadeOut();
            }
        });
    });
});