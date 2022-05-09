import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    new bootstrap.Toast(this.element, {}).show()
    if ( $(this.element).data('confetti') == '1' ) {
      setTimeout(function() {
        confetti({
          angle: 180,
          spread: randomInRange(50, 70),
          particleCount: randomInRange(50, 100),
          origin: { y: 0, x: 1 },
          zIndex: 6000
        });
      }, 200)
    }
  }
}
