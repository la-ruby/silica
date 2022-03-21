import { Controller } from "@hotwired/stimulus"

export default class extends Controller {  
  connect() {
    var that = this
    $(document).on("change", ".set1632185306", function(event) {
      var allVals = [];
      $(".set1632185306:checked").each(function() {
        allVals.push($(this).val());
      })
      if (allVals.length > 0) {
	$('#statefilter-dropdown').removeClass('btn-outline-brandprimary').addClass('btn-brandprimary')
      } else {
	$('#statefilter-dropdown').removeClass('btn-brandprimary').addClass('btn-outline-brandprimary')
      }
      $('#projects-bar-form > input[name="statefilter"]').val( allVals.join('__') )
      $('#projects-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
    })
  }
}
