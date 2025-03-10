
// 獲取所有 rating 元素
const ratingElements = document.querySelectorAll('.rating');
ratingElements.forEach(element => {
    const rating = parseInt(element.getAttribute('data-rating')); // 從 data-rating 獲取評分值
    let stars = '';
    for (let i = 0; i < rating; i++) {
        stars += '<i class="fas fa-star" style="color: gold; margin-left: 2px; font-size: 15px;"></i>'; // 動態生成星星
    }
    element.innerHTML = stars; // 將星星插入到 span 中
});