import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  serialize_to_hidden_input() {
    var allVals = [];
    $(".set1647920102:checked").each(function() {
      allVals.push($(this).val());
    })
    if (allVals.length > 0) {
    	$('#statusfilter-dropdown').removeClass('btn-outline-brandprimary').addClass('btn-brandprimary')
    } else {
    	$('#statusfilter-dropdown').removeClass('btn-brandprimary').addClass('btn-outline-brandprimary')
    }
    $('#projects-bar-form > input[name="statusfilter"]').val( allVals.join('__') )    
  }

  connect() {
    var that = this
    $(document).on("change", ".set1647920102", function(event) {
      that.serialize_to_hidden_input()
      $('#projects-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
    })
  }
}
