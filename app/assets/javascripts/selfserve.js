// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery

$(document).ready(function(){
  
  //Welcome Screen
  $("#check_in").click(function() {
    $("#welcome").hide();
    $("#scanner").show();
    $("#direction").val("onsite");
    $("#wristband").focus();
  });
  
  $("#check_out").click(function() {
    $("#welcome").hide();
    $("#fleeing").show();
    $("#direction").val("offsite");
  });
  
  $("#fleeing_forever").click(function() {
    $("#fleeing").hide();
    $("#scanner").show();
    $("#returning").val("true");
    $("#wristband").focus();
  });
  
  $("#coming_back").click(function() {
    $("#fleeing").hide();
    $("#scanner").show();
    $("#returning").val("false");
    $("#wristband").focus();
  });  
  
});