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
//= require twitter/bootstrap
//= require nested_form_fields
//= require moment
//= require moment/ja.js
//= require bootstrap-datetimepicker
//= require turbolinks
//= require_tree .


$(document).on('change', 'select.input-sm', function(e) {
// タグ番号取得
  let category = e.target.id[42]
  let id = $(this).val()
return $.ajax({
  type: 'GET',
  url: '/workplaces/' + id + '/constructions/:construction_id/get_construction',
  data: {
    workplace_id: $(this).val(),
    select_id: id,
    category_id: category
  }
})
});

var dateNow = new Date();
$(document).on('turbolinks:load',(function(){
  $('.datetimepicker_opening').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    sideBySide: true,
    stepping: 30,
    defaultDate:moment(dateNow).hours(8).minutes(0),
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right",
    }
  })
}));

$(document).on('turbolinks:load',(function(){
  $('.datetimepicker_closing').datetimepicker({
    format : "YYYY/MM/DD HH:mm",
    sideBySide: true,
    stepping: 30,
    defaultDate:moment(dateNow).hours(17).minutes(0),
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right",
    }
  })
}));
