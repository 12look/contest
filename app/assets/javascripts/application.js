// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require materialize-sprockets
//= require_tree .


function update_works_div(category_id) {
  var $loader = "<div class='loading-wrap'><div id='loading'></div></div>";

  $(document).ajaxStart(function() {
    $(".loading-wrap").show();
  });

  $(document).ajaxStop(function() {
    $(".loading-wrap").hide();
  });
    $.ajax({
      url: (category_id != '' ? "/cat/"+category_id : "/works"),
      type: "GET",
      data: {},
      dataType: "html",
      success: function(data) {
        $("#works").html($loader + data);
    }
    });
};

$(document).ready(function(){

  $('select').material_select();
  $('.button-collapse').sideNav();

  $('#scroll').on('click', function(e){
    $('html,body').stop().animate({ scrollTop: $('#news').offset().top }, 1000);
    e.preventDefault();
  });

  $('.modal-trigger').leanModal();

  //$(window).scroll(function() {
  //  if ($(document).scrollTop() > 50) {
  //    $('.fixed').addClass('container');
  //  } else {
  //    $('.fixed').removeClass('container');
  //  }
  //});
  $('.dial').each(function () {

    var elm = $(this);
    var color = elm.attr("data-fgColor");
    var perc = elm.attr("value");

    elm.knob({
      'value': 0,
      'min':0,
      'max':10,
      "skin":"tron",
      "readOnly":true,
      "thickness":.3,                 'dynamicDraw': true,                "displayInput":false
    });

    $({value: 0}).animate({ value: perc }, {
      duration: 1000,
      easing: 'swing',
      progress: function () {                  elm.val(this.value).trigger('change')
      }
    });

    //circular progress bar color
    $(this).append(function() {
      elm.parent().parent().find('.circular-bar-content').css('color',color);
      elm.parent().parent().find('.circular-bar-content strong').text(perc);
    });

  });
}); // end of document ready

//= require turbolinks

//$('.body-works').ready(function() {
//	var selected = $("#work_category_id").find("option:selected");
//	var video = $('#video');
//	if(selected.data('type') == true)
//		video.removeClass('hide');
//	else
//		!video.hasClass('hide') ? video.addClass('hide') : '' ;
//
//	$(document).on('change', 'select#work_category_id', function() {
//	  var optionSelected = $("option:selected", this);
//	  if(optionSelected.data('type') == true)
//	  video.removeClass('hide');
//	  else
//	  	!video.hasClass('hide') ? video.addClass('hide') : '' ;
//	});
//});