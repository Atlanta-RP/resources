$('document').ready(function(){
  $gif = $('img').first();
});

window.addEventListener("message", (event) => {
  if (event.data.type === "intro") {
    intro();
  } else if (event.data.type === "success") {
    success();
  } else if (event.data.type == "fail") {
    fail();
  }
});

function intro() {
  $gif.attr("src", "https://i.imgur.com/UutGIti.gif");
  setTimeout(function() {
    $gif.attr('src', "blank.png");
  }, 3500)
};

function success() {
  $gif.attr("src", "https://i.imgur.com/rRHyjKD.gif");
  setTimeout(function() {
    $gif.attr('src', "blank.png");
  }, 3000)
};

function fail() {
  $gif.attr("src", "https://i.imgur.com/n0aupfT.gif");
  setTimeout(function() {
    $gif.attr('src', "blank.png");
  }, 3000)
};