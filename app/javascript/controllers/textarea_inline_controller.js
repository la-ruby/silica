import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    form: String
  }

  connect() {
    $(this.element).editable(
      function(value, settings) {
	$(this).next().val( value )
	$( '#'+ $(this).data('form') )[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
	return(value)
      },
      {
        type : "textarea",
        cancel : 'Cancel',
        cssclass : 'border-bottom-dashed',
        cancelcssclass : 'btn btn-danger',
        submitcssclass : 'btn btn-success',
        maxlength : 200,
        select : true,
        submit : 'Save',
        submitdata : {},
        tooltip : "Click to edit...",
        width : 160
    });
  }
}
