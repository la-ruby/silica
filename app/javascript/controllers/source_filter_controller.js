import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  serialize_to_hidden_input() {
    var allVals = [];
    $(".set1632190810:checked").each(function() {
      allVals.push($(this).val());
    })
    if (allVals.length > 0) {
    	$('#sourcefilter-dropdown').removeClass('btn-outline-brandprimary').addClass('btn-brandprimary')
    } else {
    	$('#sourcefilter-dropdown').removeClass('btn-brandprimary').addClass('btn-outline-brandprimary')
    }
    $('#projects-bar-form > input[name="sourcefilter"]').val( allVals.join('__') )    
  }

  connect() {
    var that = this
    $(document).on("change", ".set1632190810", function(event) {
      that.serialize_to_hidden_input()
      $('#projects-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
    })
  }
}
