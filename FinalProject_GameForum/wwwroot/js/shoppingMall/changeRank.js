function changeRank(index) {
    const categories = document.querySelectorAll('.rank-category-area span');
    const lists = document.querySelectorAll('.rank-ranking-list-area');
    const dates = document.querySelectorAll('.rank-date');

    categories.forEach(cat => cat.classList.remove('rank-active'));
    lists.forEach(list => list.style.display = 'none');
    dates.forEach(date => date.style.display = 'none');

    categories[index].classList.add('rank-active');
    lists[index].style.display = 'flex';
    dates[index].style.display = 'block';
}