var playlist = [
	{
		"song"    : "Não é Conselho, é Visão",
		"album"   : "Single",
		"artist"  : "Kayblack",
		"artwork" : "imagens/nao-e-conselho-e-visao.jpg",
		"mp3"     : "musicas/nao-e-conselho-e-visao.mp3"
    },
    {
		"song"    : "Freio da Blazer",
		"album"   : "Single",
		"artist"  : "L7NNON",
		"artwork" : "imagens/freio-da-blazer.jpg",
		"mp3"     : "musicas/freio-da-blazer.mp3"
    },
    {
		"song"    : "CELEBRIDADE",
		"album"   : "Single",
		"artist"  : "Orochi",
		"artwork" : "imagens/celebridade.jpg",
		"mp3"     : "musicas/celebridade.mp3"
	},
	{
		"song"    : "Anota Placa",
		"album"   : "Single",
		"artist"  : "TZ DA CORONEL",
		"artwork" : "imagens/anota-placa.jpg",
		"mp3"     : "musicas/anota-placa.mp3"
	},
	{
		"song"    : "Assault - ANGRA",
		"album"   : "Single",
		"artist"  : "Borges",
		"artwork" : "imagens/angra.jpg",
		"mp3"     : "musicas/angra.mp3"
	},
	{
		"song"    : "Mira Laser",
		"album"   : "Single",
		"artist"  : "BIN",
		"artwork" : "imagens/mira-laser.jpg",
		"mp3"     : "musicas/mira-laser.mp3"
	},
	{
		"song"    : "Lágrimas de crocodilo",
		"album"   : "Single",
		"artist"  : "wiu",
		"artwork" : "imagens/lagrimas-de-crocodilo.jpg",
		"mp3"     : "musicas/lagrimas-de-crocodilo.mp3"
	},
	{
		"song"    : "FIQUEI RICO CEDO",
		"album"   : "Single",
		"artist"  : "PK",
		"artwork" : "imagens/fiquei-rico-cedo.jpg",
		"mp3"     : "musicas/fiquei-rico-cedo.mp3"
	},
	{ 
		"song"    : "Preto e Dinheiro",
		"album"   : "Single",
		"artist"  : "Kyan e Dfideliz",
		"artwork" : "imagens/pretodinheiro.jpg",
		"mp3"     : "musicas/pretodinheiro.mp3"
	},
	{
		"song"    : "F F M",
		"album"   : "Single",
		"artist"  : "Filipe Ret",
		"artwork" : "imagens/felipe.jpg",
		"mp3"     : "musicas/felipe.mp3"	
	},
];

var rot = 0;
var duration;
var playPercent;
var bufferPercent;
var min = 1;
var max = playlist.length;
var currentSong = (Math.floor(Math.random() * (max - min + 1) + min)) - 1;
// var currentSong = 0;
var arm_rotate_timer;
var arm = document.getElementById("arm");
var next = document.getElementById("next");
var song = document.getElementById("song");
var timer = document.getElementById("timer");
var music = document.getElementById("music");
var album = document.getElementById("album");
var artist = document.getElementById("artist");
var volume = document.getElementById("volume");
var playButton = document.getElementById("play");
var timeline = document.getElementById("slider");
var playhead = document.getElementById("elapsed");
var previous = document.getElementById("previous");
var pauseButton = document.getElementById("pause");
var bufferhead = document.getElementById("buffered");
var artwork = document.getElementsByClassName("artwork")[0];
var timelineWidth = timeline.offsetWidth - playhead.offsetWidth;
var visablevolume = document.getElementsByClassName("volume")[0];

music.addEventListener("ended", _next, false);
music.addEventListener("timeupdate", timeUpdate, false);
music.addEventListener("progress", 	bufferUpdate, false);
load();

function load(){
	pauseButton.style.visibility = "hidden";
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	album.innerHTML = playlist[currentSong]['album'];
	album.title = playlist[currentSong]['album'];
	artist.innerHTML = playlist[currentSong]['artist'];
	artist.title = playlist[currentSong]['artist'];
	artwork.setAttribute("style", "background: url('"+playlist[currentSong]['artwork']+"') center no-repeat;");
	music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	music.load();
	music.play();
}

function reset(){ 
	rotate_reset = setInterval(function(){
		if(rot == 0){
			clearTimeout(rotate_reset);
		}
	}, 1);
	fireEvent(pauseButton, 'click');
	playhead.style.width = "0px";
	bufferhead.style.width = "0px";
	timer.innerHTML = "0:00";
	music.innerHTML = "";
	currentSong = 0; // set to first song, to stay on last song: currentSong = playlist.length - 1;
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	album.innerHTML = playlist[currentSong]['album'];
	album.title = playlist[currentSong]['album'];
	artist.innerHTML = playlist[currentSong]['artist'];
	artist.title = playlist[currentSong]['artist'];
	artwork.setAttribute("style", "background: url('"+playlist[currentSong]['artwork']+"') center no-repeat;");
	music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	music.load();
}

function formatSecondsAsTime(secs, format) {
  var hr  = Math.floor(secs / 3600);
  var min = Math.floor((secs - (hr * 3600))/60);
  var sec = Math.floor(secs - (hr * 3600) -  (min * 60));
  if (sec < 10){ 
    sec  = "0" + sec;
  }
  return min + ':' + sec;
}

function timeUpdate() {
	bufferUpdate();
	playPercent = timelineWidth * (music.currentTime / duration);
	playhead.style.width = playPercent + "px";
	timer.innerHTML = formatSecondsAsTime(music.currentTime.toString());
}

function bufferUpdate() {
	bufferPercent = timelineWidth * (music.buffered.end(0) / duration);
	bufferhead.style.width = bufferPercent + "px";
}

function RotateArm(){
	if(armrot > -12){
		arm.style.transform = 'rotate(-38deg)';
		armrot = -45;
	} else {
		arm.style.transform = 'rotate('+armrot+'deg)';
		armrot = armrot + (26 / duration);
	}
}

function fireEvent(el, etype){
	if (el.fireEvent) {
		el.fireEvent('on' + etype);
	} else {
		var evObj = document.createEvent('Events');
		evObj.initEvent(etype, true, false);
		el.dispatchEvent(evObj);
	}
}

function _next(){
	if(currentSong == playlist.length - 1){
		reset();
	} else {
		fireEvent(next, 'click');
	}
}

playButton.onclick = function() {
	music.play();
}

pauseButton.onclick = function() {
	music.pause();
}

music.addEventListener("play", function () {
	playButton.style.visibility = "hidden";
	pause.style.visibility = "visible";
	rotate_timer = setInterval(function(){ 
		if(!music.paused && !music.ended && 0 < music.currentTime){
			
		}
	}, 10);	
	if(armrot != -45){
		arm.setAttribute("style", "transition: transform 800ms;");
		arm.style.transform = 'rotate('+armrot+'deg)';
	}
	arm_rotate_timer = setInterval(function(){ 
		if(!music.paused && !music.ended && 0 < music.currentTime){
			if(armrot == -45){
				arm.setAttribute("style", "transition: transform 800ms;");
				arm.style.transform = 'rotate(-38deg)';
				armrot = -38;
			}
			if(arm.style.transition != ""){
				setTimeout(function(){
					arm.style.transition = "";
				}, 1000);
			}
			RotateArm();
		}
	}, 1000);
}, false);

music.addEventListener("pause", function () {
	arm.setAttribute("style", "transition: transform 800ms;");
	arm.style.transform = 'rotate(-45deg)';
	playButton.style.visibility = "visible";
	pause.style.visibility = "hidden";
	clearTimeout(rotate_timer);
	clearTimeout(arm_rotate_timer);
}, false);

next.onclick = function(){
	arm.setAttribute("style", "transition: transform 800ms;");
	arm.style.transform = 'rotate(-45deg)';
	clearTimeout(rotate_timer);
	clearTimeout(arm_rotate_timer);
	playhead.style.width = "0px";
	bufferhead.style.width = "0px";
	timer.innerHTML = "0:00";
	music.innerHTML = "";
	arm.style.transform = 'rotate(-45deg)';
	armrot = -45;
	if((currentSong + 1) == playlist.length){
		currentSong = 0;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	} else {
		currentSong++;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	}
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	album.innerHTML = playlist[currentSong]['album'];
	album.title = playlist[currentSong]['album'];
	artist.innerHTML = playlist[currentSong]['artist'];
	artist.title = playlist[currentSong]['artist'];
	artwork.setAttribute("style", "background: url('"+playlist[currentSong]['artwork']+"') center no-repeat;");
	music.load();
	duration = music.duration;
	music.play();
}

previous.onclick = function(){
	arm.setAttribute("style", "transition: transform 800ms;");
	arm.style.transform = 'rotate(-45deg)';
	clearTimeout(rotate_timer);
	clearTimeout(arm_rotate_timer);
	playhead.style.width = "0px";
	bufferhead.style.width = "0px";
	timer.innerHTML = "0:00";
	music.innerHTML = "";
	arm.style.transform = 'rotate(-45deg)';
	armrot = -45;
	if((currentSong - 1) == -1){
		currentSong = playlist.length - 1;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	} else {
		currentSong--;
		music.innerHTML = '<source src="'+playlist[currentSong]['mp3']+'" type="audio/mp3">';
	}
	song.innerHTML = playlist[currentSong]['song'];
	song.title = playlist[currentSong]['song'];
	album.innerHTML = playlist[currentSong]['album'];
	album.title = playlist[currentSong]['album'];
	artist.innerHTML = playlist[currentSong]['artist'];
	artist.title = playlist[currentSong]['artist'];
	artwork.setAttribute("style", "background: url('"+playlist[currentSong]['artwork']+"') center no-repeat;");
	music.load();
	duration = music.duration;
	music.play();
}

volume.oninput = function(){
	music.volume = volume.value;
	visablevolume.style.width = (80 - 11) * volume.value + "px";
}

music.addEventListener("canplay", function () {
	duration = music.duration;
}, false);

const bd = document.body, cur = document.getElementById("fare");
bd.addEventListener("mousemove", function(n) {
    (cur.style.left = n.clientX + "px"), (cur.style.top = n.clientY + "px")
})
