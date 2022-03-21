import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var that = this
    $('.flatpickr1633014621-trigger').on('click', function() {
      window.flatpickr1633014621 = $(".flatpickr1633014621").flatpickr(
	{
	  onClose: function() {
            that.serialize_to_hidden_input()
            if ($(".flatpickr1633014621").val().length > 0) {
            	$('#offer_sent-dropdown').removeClass('btn-outline-brandprimary').addClass('btn-brandprimary')
            } else {
            	$('#offer_sent-dropdown').removeClass('btn-brandprimary').addClass('btn-outline-brandprimary')
            }
            $('#projects-bar-form')[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
	  },
	  mode: "range",
	}
      )
      window.flatpickr1633014621.open()
    })
    $('.apollo-clear-1633015412').on('click', function() {
      window.flatpickr1633014621.open()
      window.flatpickr1633014621.clear()
      window.flatpickr1633014621.close()
    })
  }

  serialize_to_hidden_input() {
    $('#projects-bar-form > input[name="offer_sent"]').val( $(".flatpickr1633014621").val() )    
  }

}
