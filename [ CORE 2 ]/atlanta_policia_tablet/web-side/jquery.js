$(document).ready(function(){
	let actionContainer = $("#actionmenu");
	let actionButton = $("#actionbutton");
	var idPessoaBuscada = 0
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				requestBank();
				actionButton.fadeIn(100);
				actionContainer.fadeIn(100);
			break;

			case "hideMenu":
				actionButton.fadeOut(100);
				actionContainer.fadeOut(100);
			break;

			case "requestBank":
				requestBank();
			break;

			case "requestFines":
				requestBank();
				requestFines();
			break;

			case "requestInvoices":
				requestBank();
				requestInvoices();
			break;

			case "requestMyInvoices":
				requestBank();
				requestMyInvoices();
			break;

			case "requestMySalarys":
				requestBank();
				requestMySalarys();
			break;

			case "requestInicio":
				requestBank();
				requestInicio();
			break;
		}
	});

	$("#bank-right").load("./inicio.html");

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://atlanta_policia_tablet/bankClose");
		}
	};
});

$('#actionbutton').click(function(e){
	$.post("http://atlanta_policia_tablet/bankClose");
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

const carregarMenu = (name) => {
	return new Promise((resolve) => {
		$("#bank-right").load(name+".html",function(){
			resolve();
		});
	});
}

const carregarMenuNovo = (name,dado) => {
	idPessoaBuscada = dado
	return new Promise((resolve) => {
		$("#bank-right").load(name+".html",function(){
			resolve();
		});
	});
}

const requestBank = () => {
	$.post("http://atlanta_policia_tablet/requestUserName",JSON.stringify({}),function(data){
		$("#bank-top").text('Bem-vindo(a) <b>'+ data.resultado + '</b>,');
	});
}

const requestFines = () => {
	$.post("http://atlanta_policia_tablet/requestFines",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">MULTAS</div>
			<div class="multas">PAGAR SELECIONADA</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}" data-price-key="${item.price}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><texto>${item.text}</texto><br><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Aplicado:</b> ${item.nuser_id}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".multas",debounce(function(){
	let $el = $('.format.active');
	$.post("http://atlanta_policia_tablet/finesPayment",JSON.stringify({
		id: $el.attr('data-id-key'),
		price: $el.attr('data-price-key')
	}));
}));

const requestInvoices = () => {
	$.post("http://atlanta_policia_tablet/requestInvoices",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">FATURAS</div>
			<div class="faturas">PAGAR SELECIONADA</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}" data-price-key="${item.price}" data-nuser_id-key="${item.nuser_id}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><texto>${item.text}</texto><br><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Aplicado:</b> ${item.name}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".faturas",debounce(function(){
	let $el = $('.format.active');
	$.post("http://atlanta_policia_tablet/invoicesPayment",JSON.stringify({
		id: $el.attr('data-id-key'),
		price: $el.attr('data-price-key'),
		nuser_id: $el.attr('data-nuser_id-key')
	}));
}));

$(document).on("click",".format",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.format').removeClass('active');
	if(!isActive) $el.addClass('active');
});

const requestMyInvoices = () => {
	$.post("http://atlanta_policia_tablet/requestMyInvoices",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">MINHAS FATURAS</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><texto>${item.text}</texto><br><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Aplicado:</b> ${item.name}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}


const requestMySalarys = () => {
	$.post("http://atlanta_policia_tablet/requestMySalarys",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">SALARIOS</div>
			<div class="salario">RECEBER O SELECIONADO</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}" data-price-key="${item.price}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}


$(document).on("click",".salario",debounce(function(){
	let $el = $('.format.active');
	$.post("http://atlanta_policia_tablet/salaryRecipe",JSON.stringify({
		id: $el.attr('data-id-key'),
		price: $el.attr('data-price-key')
	}));
}));


const requestHistoricoCriminal = () => {
	$.post("http://atlanta_policia_tablet/requestHistoricoCriminal",JSON.stringify({idPessoaBuscada}),(data) => {
		let i = 0;
		const nameList = data.resultado;
		let nomeIndividuo = data.nomeIndividuo;
		$('#bank-right').html(`
			<div class="title">HISTÓRICO CRIMINAL DE <b>${nomeIndividuo}</b></div>
			${nameList.map((item) => (`
				<div class="format">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right">
						<b>Data:</b> ${item.data}<br>
						<b>Motivo:</b> ${item.motivo}<br>
						<b>Serviços:</b> ${item.servicos}<br>
						<b>Policial:</b> ${item.policial}<br>
					</div>
				</div>
			`)).join('')}
		`);
	});
}

const requestHistoricoMultas = () => {
	$.post("http://atlanta_policia_tablet/requestHistoricoMultas",JSON.stringify({idPessoaBuscada}),(data) => {
		let i = 0;
		const nameList = data.resultado;
		let nomeIndividuo = data.nomeIndividuo;
		$('#bank-right').html(`
			<div class="title">HISTÓRICO DE MULTAS DE <b>${nomeIndividuo}</b></div>
			${nameList.map((item) => (`
				<div class="format">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right">
						<b>Data:</b> ${item.data}<br>
						<b>Status:</b> ${item.status}<br>
						<b>Motivo:</b> ${item.motivo}<br>
						<b>Valor:</b> ${item.valor}<br>
						<b>Aplicador:</b> ${item.aplicador}<br>
					</div>
				</div>
			`)).join('')}
		`);
	});
}

const requestInicio = () => {
	$('#bank-right').html(`
		<div class="menu-buscar">
			<div class="title-buscar"><b>HISTÓRICO</b><br>Busque pelo histório de um cidadão.</div>
			<input id="busca" class="busca" maxlength="9" spellcheck="false" value="" placeholder="PASSAPORTE">
			<div class="buscar">BUSCAR</div>
		</div>
		<div class="menu-space">
		</div>
		<div class="menu-multas">
			<div class="title-multas"><b>MULTAS</b><br>Busque pelo histório de multas de um cidadão.</div>
			<input id="multa" class="multa" maxlength="9" spellcheck="false" value="" placeholder="PASSAPORTE">
			<div class="multar">BUSCAR</div>
		</div>`);
}

$(document).on("click",".buscar",debounce(function(){
	let busca = parseInt($('#busca').val());
	if(busca > 0){
		carregarMenuNovo('historico',busca);
	}
}));

$(document).on("click",".multar",debounce(function(){
	let multa = parseInt($('#multa').val());
	if(multa > 0){
		carregarMenuNovo('multas',multa);
	}
}));

/* ----------DEBOUNCE---------- */
function debounce(func,immediate){
	var timeout
	return function(){
		var context = this,args = arguments
		var later = function(){
			timeout = null
			if (!immediate) func.apply(context,args)
		}
		var callNow = immediate && !timeout
		clearTimeout(timeout)
		timeout = setTimeout(later,250)
		if (callNow) func.apply(context,args)
	}
}
