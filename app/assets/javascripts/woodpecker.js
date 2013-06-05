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
  $("#is_attending").click(function() {
    $("#welcome").hide();
    $("#badge").show();
    $("#attending").val("true");
  });
  
  $("#not_attending").click(function() {
    $("#welcome").hide();
    $("#cancel").show();
  });
  
  //Cancel Screen
  $("#still_attending").click(function() {
    $("#cancel").hide();
    $("#badge").show();
  });
  
  //Badge Screen
  $("#confirm_badge").click(function() {
    $("#badge").hide();
    $("#days").show();
  });
  
});