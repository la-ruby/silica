import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var that = this
    $('.flatpickr1633008361-trigger').on('click', function() {
      window.flatpickr1633008361 = $(".flatpickr1633008361").flatpickr(
	{
	  onClose: function() {
            that.serialize_to_hidden_input()
            if ($(".flatpickr1633008361").val().length > 0) {
            	$('#req_date-dropdown').removeClass('btn-outline-brandprimary').addClass('btn-brandprimary')
            } else {
            	$('#req_date-dropdown').removeClass('btn-brandprimary').addClass('btn-outline-brandprimary')
            }


            $('#projects-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
	  },
	  mode: "range",
	}
      )
      window.flatpickr1633008361.open()
    })
    $('.apollo-clear-1633013473').on('click', function() {
      window.flatpickr1633008361.open()
      window.flatpickr1633008361.clear()
      window.flatpickr1633008361.close()
    })
  }

  serialize_to_hidden_input() {
    $('#projects-bar-form > input[name="req_date"]').val( $(".flatpickr1633008361").val() )
  }
}
