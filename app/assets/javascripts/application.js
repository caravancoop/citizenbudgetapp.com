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
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/dist/jquery
//= require jquery-ujs/src/rails
//= require bootstrap-sass/assets/javascripts/bootstrap-sprockets
//= require_tree ./libs
//= require_tree ./plugins
//= require i18n
//= require ./simulators/simulator_helper
//= require ./simulators/simulator
//= require reports/graphs
//= require scripts

$(document).ready(function() {
  $('.js-criteria-select').on('change', function(e) {
    var table = $(e.target.closest('table'));

    var inactive = table.find("tbody tr:not([data-criteria='" + e.target.value + "'])")
    inactive.find('input').prop('disabled', true)
    inactive.addClass('hidden');

    var active = table.find("tbody tr[data-criteria='" + e.target.value + "']")
    active.find('input').prop('disabled', false)
    active.removeClass('hidden');
  })
});
