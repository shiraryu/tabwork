$(document).on('change', 'input#checked_clear', function(e) {
  if(this.checked){
    $("#attendance_closing_datetime").val("");
    $("#attendance_closing_datetime").attr("disabled", "true");
    $("form input[type=number]").val("");
    $("form input[type=number]").attr("disabled", "true");
    $("select").val(0);
    $("select").attr("disabled", "disabled");
  }
  else{
    $("#attendance_closing_datetime").removeAttr("disabled", "false");
    $("form input[type=number]").removeAttr("disabled", "false");
    $("select").removeAttr("disabled");
  }
});
