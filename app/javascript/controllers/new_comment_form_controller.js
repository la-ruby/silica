import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "input", "form" ]
  submission() {
    $( this.element )[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))    

    // clear input
    $(this.inputTarget).val('')

    // disable submit for 10 secs
    $(this.buttonTarget).addClass('disabled')
    $('#silica-new-comment-form').addClass('silica-super-light')
    document.querySelector('#silica-new-comment-form trix-editor').editor.element.setAttribute('contentEditable', false)

    let that = this
    setTimeout(function() {
      $(that.buttonTarget).removeClass('disabled')
      $('#silica-new-comment-form').removeClass('silica-super-light')
      document.querySelector('#silica-new-comment-form trix-editor').editor.element.setAttribute('contentEditable', true)
      $('#silica-new-comment-form trix-editor').removeClass('silica-super-light')
    }, 3000)


  }
}
