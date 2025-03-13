//調整商品購買數量與計算付款金額
//判斷有多少可用的紅利點數，並讓使用者選擇輸入

document.addEventListener('DOMContentLoaded', function () {
    // 獲取所有增減按鈕和數量元素
    const reduceButtons = document.querySelectorAll('.btn-reduce-products-number');
    const addButtons = document.querySelectorAll('.btn-add-products-number');
    const subtotalElements = document.querySelectorAll('.list-note');
    const grandTotalElement = document.getElementById('amountpaid');
    const bonusTotal = document.getElementById('bonusTotal');
    const bonusInput = document.getElementById('bonus');

    // 設置紅利初始狀態
    const availableBonus = parseInt(bonusTotal.getAttribute('data-bonus')) || 0;
    bonusTotal.textContent = `您有 ${availableBonus} 點紅利，本次抵用`;
    bonusInput.value = "0"; // 預設值設為0
    if (availableBonus > 0) {
        bonusInput.removeAttribute('disabled');
    } else {
        bonusInput.setAttribute('disabled', 'true');
    }

    // 減少數量
    reduceButtons.forEach(button => {
        button.addEventListener('click', function () {
            const numberContainer = this.parentElement;
            const numElement = numberContainer.querySelector('.product-num');
            let currentNum = parseInt(numElement.textContent);
            const minLimit = parseInt(numElement.dataset.limited) || 1;
            const price = parseInt(numElement.dataset.price);
            const sn = numElement.dataset.sn;

            if (currentNum > minLimit) {
                currentNum--;
                numElement.textContent = currentNum;
                updateSubtotal(sn, currentNum, price);
                updateGrandTotal();
            }
        });
    });

    // 增加數量
    addButtons.forEach(button => {
        button.addEventListener('click', function () {
            const numberContainer = this.parentElement;
            const numElement = numberContainer.querySelector('.product-num');
            let currentNum = parseInt(numElement.textContent);
            const price = parseInt(numElement.dataset.price);
            const sn = numElement.dataset.sn;

            currentNum++;
            numElement.textContent = currentNum;
            updateSubtotal(sn, currentNum, price);
            updateGrandTotal();
        });
    });

    // 在輸入前攔截，處理 "0" 後輸入的情況
    bonusInput.addEventListener('beforeinput', function (e) {
        if (e.data && /[0-9]/.test(e.data)) {
            // 如果輸入的是數字，且當前值為 "0"，直接替換
            if (this.value === "0") {
                e.preventDefault();
                this.value = e.data;                
                updateGrandTotal();
            }
            // 其他情況交給 input 事件處理
        }
    });

    // 處理一般輸入
    bonusInput.addEventListener('input', function (e) {
        let value = this.value.replace(/[^0-9]/g, ''); // 只保留數字

        // 如果值為空，設為 "0"
        if (value === '') {
            value = "0";
        }

        // 轉為數字並檢查範圍
        let bonusValue = parseInt(value);
        if (bonusValue > availableBonus) {
            value = availableBonus.toString();
        }

        this.value = value;
        updateGrandTotal();
    });

    // 處理輸入法結束（中文輸入等）
    bonusInput.addEventListener('compositionend', function (e) {
        let value = this.value.replace(/[^0-9]/g, '');
        if (value === '') {
            value = "0";
        }
        let bonusValue = parseInt(value);
        if (bonusValue > availableBonus) {
            value = availableBonus.toString();
        }
        this.value = value;
        updateGrandTotal();
    });

    // 防止貼上非數字內容
    bonusInput.addEventListener('paste', function (e) {
        e.preventDefault();
        const pastedText = (e.clipboardData || window.clipboardData).getData('text');
        let value = pastedText.replace(/[^0-9]/g, '');
        let bonusValue = parseInt(value) || 0;
        if (bonusValue > availableBonus) {
            value = availableBonus.toString();
        }
        this.value = value;
        updateGrandTotal();
    });

    // 更新小計
    function updateSubtotal(sn, quantity, price) {
        const subtotalElement = document.getElementById(`subtotal${sn}`);
        const subtotal = quantity * price;
        subtotalElement.textContent = `${subtotal}元`;
    }

    // 更新總計（減去紅利）
    function updateGrandTotal() {
        let grandTotal = 0;
        subtotalElements.forEach(element => {
            const subtotal = parseInt(element.textContent.replace('元', '')) || 0;
            grandTotal += subtotal;
        });
        const bonusUsed = parseInt(bonusInput.value) || 0;
        grandTotal = Math.max(0, grandTotal - bonusUsed); // 確保總計不為負數
        grandTotalElement.textContent = grandTotal;
        grandTotalElement.dataset.grandtotal = grandTotal;
    }

    // 初始化總計
    updateGrandTotal();
});