let actionContainer = $("body");
let actionContainer2 = $("#infocar");
let actionContainer3 = $(".loading");
let actionContainer4 = $(".vehicle");

$(document).ready(function() {

            window.addEventListener('message', function(event) {
                let item = event.data;
                switch (item.action) {
                    case 'openNUI':
                        updateGarages();
                        actionContainer.fadeIn(1000);
                        break;

                    case 'closeNUI':
                        actionContainer2.fadeOut(1000);
                        actionContainer.fadeOut(1000);
                        actionContainer3.fadeOut(1000);
                        actionContainer4.fadeOut(1000);
                        break;

                    case 'updateGarages':
                        updateGarages();
                        break;
                }
            });

            document.onkeyup = function(data) {
                if (data.which == 27) {
                    actionContainer.fadeOut(1000);
                    $.post('http://vrp_garages/close', JSON.stringify({}));
                }
            };

            const updateGarages = () => {
                    $.post('http://vrp_garages/myVehicles', JSON.stringify({}), (data) => {
                                const nameList = data.vehicles.sort((a, b) => (a.name2 > b.name2) ? 1 : -1);

                                $('.section_content_itens').html(`
			${nameList.map((item) => (`
				<div class="section_content_item" data-name="${item.name}" data-fuel="${item.fuel}" data-name2="${item.name2}" data-pmalas="${item.pmalas}" data-pmalas2="${item.pmalas2}" data-detido="${item.detido}">
					<p style="font-family: "Bebas Neue";">${item.name2}</p>
					<div class="section_content_info">
						<div>
							<label>Motor</label><br>
							<span>${item.engine}%</span>
						</div>
						<div>
							<label>Lataria</label><br>
							<span>${item.body}%</span>
						</div>
						<div>
							<label>Gasolina</label><br>
							<span>${item.fuel}%</span>
						</div>
					</div>
					<img src="https://raw.githubusercontent.com/Atlanta-RP/RRM/master/images/${item.name}.png" onerror="this.onerror=null;this.src='https://i.imgur.com/acV4tCt.png';">
				</div>
				`)).join('')}
			`);
		});


	}
});

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}
	return r.split('').reverse().join('');
}

const sendData = (name, data) => {
	$.post("http://vrp_garages/" + name, JSON.stringify(data), function (datab) { });
}

var carselect = "nil" 

$(document).on('click', '.section_content_item', function () {
	let $el = $('.section_content_item:hover');
	carselect = $el.attr('data-name');
})

$(document).on('click','.section_content_item',function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.section_content_item').removeClass('active');
	actionContainer2.fadeOut(1000);
	actionContainer3.fadeOut(1000);
	actionContainer4.fadeOut(1000);
	$('#tax').html(`-`);
	$('#namecar').html(`-`);
	$('#lib').html(`-`);
	$('#ipva').html(`-`);
	$('#image').html("src='https://i.imgur.com/acV4tCt.png'");
	if(!isActive) $el.addClass('active');
	actionContainer2.fadeIn(1000);
	actionContainer3.fadeIn(1000);
	setTimeout(function(){
		actionContainer3.fadeOut(1000);
		setTimeout(function(){
		actionContainer4.fadeIn(1000);
			$('#tax').html($el.attr('data-pmalas') + " / " + $el.attr('data-pmalas2'));
			$('#namecar').html($el.attr('data-name2'));
			$('#lib').html($el.attr('data-detido'));
			$('#ipva').html($el.attr('data-fuel') + "%");
			$('.imgcar').html(`<img class="imagemCarro" src="https://raw.githubusercontent.com/Atlanta-RP/RRM/master/images/carros/${$el.attr('data-name')}.jpg" onerror="this.onerror=null;this.src='https://i.imgur.com/acV4tCt.png';" style="width: 80%;">`);
		}, 1500);
	}, 500);
});

$(document).on('click', '#retirar', function () {
	$.post('http://vrp_garages/spawnVehicles', JSON.stringify({
		name: carselect
	}));
})

$(document).on('click', '#guardar', function () {
	$.post('http://vrp_garages/deleteVehicles', JSON.stringify({}));
})

$(".section_content_search > input").on("keyup", function() {
    let search = $(this).val().toLowerCase();
    $("div.section_content_item > p").filter(function() {
        $(this).closest(".section_content_item").toggle($(this).text().toLowerCase().indexOf(search) > -1)
    });
});