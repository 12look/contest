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