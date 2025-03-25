document.addEventListener('DOMContentLoaded', function () {
    const ads = document.querySelectorAll('.ad');
    if (ads.length > 0) {
        const intervals = [2000, 3000];
        let timer = [];

        ads.forEach(( ad, retime ) =>{
            const intervalTime = intervals[retime % intervals.length];

            timer[retime] = setInterval(() => {
                refreshAD(ad);
            }, intervalTime);

            ad.addEventListener('mouseenter', () => {
                clearInterval(timer[retime]);
            });

            ad.addEventListener('mouseleave', () => {
                timer[retime] = setInterval(() => {
                    refreshAD(ad);
                }, intervalTime);
            });
        });
    
        function refreshAD(adElement) {
            fetch(window.getRandomAdUrl, { cache: 'no-store' })
            .then(response => response.json())
            .then(data => {
                if (data && data.mainImageUrl) {
                    const img = adElement.querySelector('img');
                    const link = adElement.querySelector('a');
                    img.src = data.mainImageUrl;
                    link.href = window.productIndexUrl + '?productId=' + data.ProductId;
                }
                else {
                    console.error("Returned data is invalid:", data);
                }
            })
            .catch(error => {
                console.log('Error', error);
            });
        }
    }
});