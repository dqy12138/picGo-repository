<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="banner">
    <div class="image"><img width="3000" height="250" src="Static/img/underHeadImg/bg.png"> </div>
    <div class="image"><img width="1800" height="165" src="Static/img/underHeadImg/girl1.png"> </div>
    <div class="image"><img width="3000" height="250" src="Static/img/underHeadImg/grassland.png"> </div>
    <div class="image"><img width="1800" height="160" src="Static/img/underHeadImg/mushroom.png"> </div>
    <div class="image"><img width="1800" height="165" src="Static/img/underHeadImg/spirit.png"> </div>
    <div class="image"><img width="1950" height="178" src="Static/img/underHeadImg/leaf.png"> </div>
</div>
<script>
    let x = 0;
    let x_new = 0;
    let x_offset = 0;

    let banner = document.querySelector('.banner');
    let images = document.querySelectorAll('.image');

    let window_width = document.documentElement.clientWidth;
    let step = window_width / 2 / 5;

    let data_images = [
        { x: 0, b: 4 },
        { x: 0, b: 0 },
        { x: 0, b: 1 },
        { x: 0, b: 4 },
        { x: 0, b: 5 },
        { x: 0, b: 6 },
    ]

    let init = () => {
        // images[0].children[0].style = 'transform: translate(0px); filter: blur(4px);';
        // images[1].children[0].style = 'transform: translate(0px); filter: blur(0px);';
        // images[2].children[0].style = 'transform: translate(0px); filter: blur(1px);';
        // images[3].children[0].style = 'transform: translate(0px); filter: blur(4px);';
        // images[4].children[0].style = 'transform: translate(0px); filter: blur(5px);';
        // images[5].children[0].style = 'transform: translate(0px); filter: blur(6px);';
        for (const key in images) {
            if (images.hasOwnProperty(key)) {
                const element = images[key];
                const element_data = data_images[key];
                element.children[0].style = 'transition: .2s linear; transform: translate(' + element_data.x + 'px); filter: blur(' + element_data.b + 'px);';
            }
        }
    }

    banner.addEventListener('mouseover', (e) => {
        x = e.clientX;
        // console.log(x);
    });
    banner.addEventListener("mousemove", (e) => {
        x_new = e.clientX;
        // console.log(x_new);
        x_offset = x - x_new;
        // console.log(x_offset);
        for (const key in images) {
            if (images.hasOwnProperty(key)) {
                let level = (6 - parseInt(key)) * 10;
                const element = images[key];
                const element_data = data_images[key];
                let b_new = Math.abs(element_data.b + (x_offset / step));
                let l_new = 0 - (x_offset / level);
                element.children[0].style = 'transform: translate(' + l_new + 'px); filter: blur(' + b_new + 'px);';
            }
        }

    });


    banner.addEventListener("mouseout", (e) => {
        init();
    });

    blink_index = 0;
    timeout = 4000;
    let blink = () => {

        if (blink_index == 4) {
            blink_index = 1;
            timeout = 4000;
        } else {
            blink_index += 1;
            timeout = 30;
        }

        images[1].children[0].src = 'Static/img/underHeadImg/girl' + blink_index + '.png';
        setTimeout(() => {
            blink();
        }, timeout);
    }

    window.onload = () => {
        init();
        blink();
    }

</script>
