import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var submitdata = {}
    $(this.element).editable(
      function(value, settings) {
	$(this).next().val( value )
	$( '#'+ $(this).data('form') )[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
	return(value)
      },
      {			       
        type : "select",
        data: $(this.element).data('selectdata'),
        cancel : 'Cancel',
        cssclass : 'custom-class',
        cancelcssclass : 'btn btn-danger',
        submitcssclass : 'btn btn-success',
        maxlength : 200,
        select : true,
        submit : 'Save',
        submitdata : submitdata,
        tooltip : "Click to edit...",
        width : 160
    });
  }
}


