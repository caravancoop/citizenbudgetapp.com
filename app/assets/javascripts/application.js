//= require jquery-ujs/src/rails
//= require bootstrap-sass/assets/javascripts/bootstrap-sprockets
//= require i18n

// Libs
//= require_tree ./libs

// Plugins
//= require jquery-easing-original/jquery.easing
//= require jquery.scrollTo/jquery.scrollTo
//= require jquery.localScroll/jquery.localScroll
//= require jqueryui-touch-punch/jquery.ui.touch-punch
//= require validationEngine/js/jquery.validationEngine
//= require clippy-jquery/src/jquery.clippy

// Initialize
//= require scripts

// Graphs
//= require reports/graphs

// Simulators
//= require ./simulators/simulator_helper
//= require ./simulators/simulator

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
