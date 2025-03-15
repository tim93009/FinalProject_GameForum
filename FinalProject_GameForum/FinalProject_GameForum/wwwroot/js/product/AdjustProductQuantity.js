// 獲取 DOM 元素
const reduceBtn = document.querySelector('.btn-reduce-number');
const addBtn = document.querySelector('.btn-add-number');
const numberDisplay = document.querySelector('.show-products-number');

// 設定初始值和限制
let quantity = 1;
const minQuantity = 1;
const maxQuantity = 99;

// 更新顯示的函數
function updateDisplay() {
    numberDisplay.textContent = quantity;
}

// 減少數量
reduceBtn.addEventListener('click', () => {
    if (quantity > minQuantity) {
        quantity--;
        updateDisplay();
    }
});

// 增加數量
addBtn.addEventListener('click', () => {
    if (quantity < maxQuantity) {
        quantity++;
        updateDisplay();
    }
});

// 可選：如果想讓數字可以直接輸入
numberDisplay.setAttribute('contenteditable', 'true');
numberDisplay.addEventListener('input', (e) => {
    let value = parseInt(e.target.textContent) || minQuantity;
    quantity = Math.max(minQuantity, Math.min(maxQuantity, value));
    updateDisplay();
});

// 失去焦點時確保顯示正確數字
numberDisplay.addEventListener('blur', () => {
    updateDisplay();
});