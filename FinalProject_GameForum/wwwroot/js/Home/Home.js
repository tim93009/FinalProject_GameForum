console.log('getRandomAdUrl:', window.getRandomAdUrl);
document.addEventListener('DOMContentLoaded', function () {
    const firstHalfAds = document.querySelectorAll('.ad.first-half');
    const secondHalfAds = document.querySelectorAll('.ad.second-half');

    const intervals = {
        firstHalfAds: 2000,
        secondHalfAds: 3000
    };

    let timers = {};

    firstHalfAds.forEach((ad, index) => {
        timers[`first_${index}`] = setInterval(() => {
            refreshAD(ad);
        }, intervals.firstHalfAds);

        ad.addEventListener('mouseenter', () => {
            clearInterval(timers[`first_${index}`]);
        });

        ad.addEventListener('mouseleave', () => {
            timers[`first_${index}`] = setInterval(() => {
                refreshAD(ad);
            }, intervals.firstHalfAds);
        });
    });

    secondHalfAds.forEach((ad, index) => {
        timers[`second_${index}`] = setInterval(() => {
            refreshAD(ad);
        }, intervals.secondHalfAds);

        ad.addEventListener('mouseenter', () => {
            clearInterval(timers[`second_${index}`]);
        });

        ad.addEventListener('mouseleave', () => {
            timers[`second_${index}`] = setInterval(() => {
                refreshAD(ad);
            }, intervals.secondHalfAds);
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
                    link.href = window.productIndexUrl + '?productId=' + data.productId;  // 注意大小寫
                    link.title = data.productName;
                    adElement.dataset.productId = data.productId;
                } else {
                    console.error("Returned data is invalid:", data);
                }
            })
            .catch(error => {
                console.log('Error', error);
            });
    }
})