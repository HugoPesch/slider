var carrouselHor = {
  nbSlide: 0,
  nbCurrent: 1,
  elemCurrent: null,
  elem: null,
  timer: null,

  init: function(elem) {
    this.nbSlide = elem.find(".slide").length;
    //Création de la pagination

    elem.append('<div class="navigation"></div>')

    for (var i = 1; i <= this.nbSlide; i++) {
      elem.find(".navigation").append('<span>' + i + '</span>');
    }
    elem.find(".navigation span").click(function() {
      carrouselHor.gotoSlide($(this).text());
    })
    //Initialisation du carrousel
    this.elem = elem;
    elem.find(".slide").hide();
    elem.find(".slide:first").show();
    this.elemCurrent = elem.find(".slide:first").show();
    this.elem.find(".navigation span:first").addClass("active");

    //Création du timer
    carrouselHor.play();
  },

  gotoSlide: function(num) {
    if (num == this.nbCurrent) {
      return false;
    }
    this.elemCurrent.fadeOut();
    this.elem.find("#slide" + num).fadeIn();
    this.elem.find(".navigation span").removeClass("active");
    this.elem.find(".navigation span:eq(" + (
      num - 1
    ) + ")").addClass("active");
    this.nbCurrent = num;
    this.elemCurrent = this.elem.find("#slide" + num);
  },

  next: function() {
    var num = this.nbCurrent;
    num++;
    if (num > this.nbSlide) {
      num = 1;
    }
    this.gotoSlide(num);
  },

  prev: function() {
    var num = this.nbCurrent - 1;
    if (num < 1) {
      num = this.nbSlide;
    }
    this.gotoSlide(num);
  },

  stop: function() {
    window.clearInterval(carrouselHor.timer);
  },
  play: function() {
    window.clearInterval(carrouselHor.timer);
    this.timer = window.setInterval("carrouselHor.next()", 1500);
  }
}

$(function() {
  $(document).ready(function() {
    carrouselHor.init($("#carrouselHor"));
    $("#carrouselHor").mouseover(function() {
      carrouselHor.stop();
    });
    $("#carrouselHor").mouseout(function() {
      carrouselHor.play();
    });
  });
});
