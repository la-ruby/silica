import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    $('input[type=radio][name="repc\[offer_terms\]"]').change(function() {
      if ( $(this).val() == "yes" ) {
	$(".togglable-1636247473").removeClass('invisible')
      } else {
	$(".togglable-1636247473").addClass('invisible')
      }
    })
  }
}
