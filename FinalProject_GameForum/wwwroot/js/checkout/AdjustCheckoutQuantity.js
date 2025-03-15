//調整商品購買數量與計算付款金額
//判斷有多少可用的紅利點數，並讓使用者選擇輸入

// 在 DOM 載入完成後執行所有邏輯
document.addEventListener('DOMContentLoaded', function () {
    // 獲取所有相關的 DOM 元素
    const reduceButtons = document.querySelectorAll('.btn-reduce-products-number'); // 減少數量的按鈕
    const addButtons = document.querySelectorAll('.btn-add-products-number');     // 增加數量的按鈕
    const subtotalElements = document.querySelectorAll('.list-note');             // 所有小計顯示元素
    const grandTotalElement = document.getElementById('amountpaid');              // 總計顯示元素
    const bonusTotal = document.getElementById('bonusTotal');                     // 紅利點數顯示元素
    const bonusInput = document.getElementById('bonus');                          // 紅利輸入框

    // 初始化紅利點數狀態
    const availableBonus = parseInt(bonusTotal.getAttribute('data-bonus')) || 0;  // 從 data-bonus 獲取可用紅利，預設為 0
    bonusTotal.textContent = `您有 ${availableBonus} 點紅利，本次抵用`;           // 顯示可用紅利點數
    bonusInput.value = "0";                                                       // 紅利輸入框預設為 0
    if (availableBonus > 0) {
        bonusInput.removeAttribute('disabled');                                   // 如果有紅利，啟用輸入框
    } else {
        bonusInput.setAttribute('disabled', 'true');                              // 無紅利時禁用輸入框
    }

    // 減少數量按鈕的事件監聽器
    // 減少數量
    reduceButtons.forEach(button => {
        button.addEventListener('click', function () {
            const numberContainer = this.parentElement;                           // 獲取包含按鈕和數量輸入框的父容器
            const numElement = numberContainer.querySelector('.product-num');     // 獲取數量輸入框
            let currentNum = parseInt(numElement.value);                          // 當前數量值
            const minLimit = parseInt(numElement.dataset.limited) || 1;           // 最小數量限制，預設為 1
            const price = parseInt(numElement.dataset.price);                     // 商品單價
            const sn = numElement.dataset.sn;                                     // 商品序號

            if (currentNum > minLimit) {                                          // 如果數量大於最小限制
                currentNum--;                                                     // 減少數量
                numElement.value = currentNum;                                    // 更新輸入框顯示
                updateSubtotal(sn, currentNum, price);                            // 更新該商品小計
                updateGrandTotal();                                               // 更新總計
            }
        });
    });

    // 增加數量按鈕的事件監聽器
    // 增加數量
    addButtons.forEach(button => {
        button.addEventListener('click', function () {
            const numberContainer = this.parentElement;                           // 獲取包含按鈕和數量輸入框的父容器
            const numElement = numberContainer.querySelector('.product-num');     // 獲取數量輸入框
            let currentNum = parseInt(numElement.value);                          // 當前數量值
            const price = parseInt(numElement.dataset.price);                     // 商品單價
            const sn = numElement.dataset.sn;                                     // 商品序號

            if (currentNum < 999) {                                               // 如果數量小於最大值 999
                currentNum++;                                                     // 增加數量
                numElement.value = currentNum;                                    // 更新輸入框顯示
                updateSubtotal(sn, currentNum, price);                            // 更新該商品小計
                updateGrandTotal();                                               // 更新總計
            }
        });
    });

    // 處理數量欄位的手動輸入
    const productNumInputs = document.querySelectorAll('.product-num');           // 獲取所有數量輸入框
    productNumInputs.forEach(input => {
        input.addEventListener('input', function () {                             // 監聽輸入事件
            let value = this.value.replace(/[^0-9]/g, '');                        // 移除非數字字符
            let num = parseInt(value) || 1;                                       // 轉為數字，若無效則設為 1
            const minLimit = parseInt(this.dataset.limited) || 1;                 // 最小數量限制
            const price = parseInt(this.dataset.price);                           // 商品單價
            const sn = this.dataset.sn;                                           // 商品序號

            // 限制數量範圍
            if (num < minLimit) {
                num = minLimit;                                                   // 小於最小值時設為最小值
            }
            if (num > 999) {
                num = 999;                                                        // 大於 999 時設為 999
            }

            this.value = num;                                                     // 更新輸入框顯示
            updateSubtotal(sn, num, price);                                       // 更新小計
            updateGrandTotal();                                                   // 更新總計
        });

        // 在輸入前檢查，防止超過 999 的視覺問題
        input.addEventListener('beforeinput', function (e) {
            if (e.data && /[0-9]/.test(e.data) && this.value.length >= 3 && parseInt(this.value) >= 999) {
                e.preventDefault();                                               // 若已達 999，阻止進一步輸入
            }
        });
    });

    // 紅利輸入前處理，處理從 "0" 開始輸入的情況
    // 在輸入前攔截，處理 "0" 後輸入的情況
    bonusInput.addEventListener('beforeinput', function (e) {
        if (e.data && /[0-9]/.test(e.data)) {                                 // 如果輸入的是數字
            if (this.value === "0") {                                         // 當前值為 "0"
                e.preventDefault();                                           // 阻止默認行為
                this.value = e.data;                                          // 直接替換為新輸入的數字
                updateGrandTotal();                                           // 更新總計
            }
        }
    });

    // 紅利欄位一般輸入處理
    bonusInput.addEventListener('input', function () {
        let value = this.value.replace(/[^0-9]/g, '');                        // 移除非數字字符
        if (value === '') {
            value = "0";                                                      // 若輸入為空，設為 "0"
        }

        let bonusValue = parseInt(value);                                     // 轉為數字
        if (bonusValue > availableBonus) {                                    // 若超過可用紅利
            value = availableBonus.toString();                                // 限制為可用紅利
        }
        this.value = value;                                                   // 更新輸入框顯示
        updateGrandTotal();                                                   // 更新總計
    });

    // 處理輸入法結束（例如中文輸入）
    bonusInput.addEventListener('compositionend', function () {
        let value = this.value.replace(/[^0-9]/g, '');                        // 移除非數字字符
        if (value === '') {
            value = "0";                                                      // 若輸入為空，設為 "0"
        }
        let bonusValue = parseInt(value);                                     // 轉為數字
        if (bonusValue > availableBonus) {                                    // 若超過可用紅利
            value = availableBonus.toString();                                // 限制為可用紅利
        }
        this.value = value;                                                   // 更新輸入框顯示
        updateGrandTotal();                                                   // 更新總計
    });

    // 防止紅利欄位貼上非數字內容
    bonusInput.addEventListener('paste', function (e) {
        e.preventDefault();                                                   // 阻止默認貼上行為
        const pastedText = (e.clipboardData || window.clipboardData).getData('text'); // 獲取貼上內容
        let value = pastedText.replace(/[^0-9]/g, '');                        // 移除非數字字符
        let bonusValue = parseInt(value) || 0;                                // 轉為數字，若無效則設為 0
        if (bonusValue > availableBonus) {                                    // 若超過可用紅利
            value = availableBonus.toString();                                // 限制為可用紅利
        }
        this.value = value;                                                   // 更新輸入框顯示
        updateGrandTotal();                                                   // 更新總計
    });

    // 更新單項商品小計
    function updateSubtotal(sn, quantity, price) {
        const subtotalElement = document.getElementById(`subtotal${sn}`);     // 根據序號獲取小計元素
        const subtotal = quantity * price;                                    // 計算小計
        subtotalElement.textContent = `${subtotal}元`;                        // 更新小計顯示
    }

    // 更新總計（減去紅利）
    function updateGrandTotal() {
        let grandTotal = 0;                                                   // 初始化總計
        subtotalElements.forEach(element => {                                 // 遍歷所有小計
            const subtotal = parseInt(element.textContent.replace('元', '')) || 0; // 提取小計數值
            grandTotal += subtotal;                                           // 累加到總計
        });
        const bonusUsed = parseInt(bonusInput.value) || 0;                    // 獲取使用的紅利點數
        grandTotal = Math.max(0, grandTotal - bonusUsed);                     // 減去紅利，確保不為負數
        grandTotalElement.textContent = grandTotal;                           // 更新總計顯示
        grandTotalElement.dataset.grandtotal = grandTotal;                    // 更新總計的 data 屬性
    }

    // 初始化總計
    updateGrandTotal();                                                       // 頁面載入時計算一次總計
});