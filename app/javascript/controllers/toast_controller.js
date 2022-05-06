import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    new bootstrap.Toast(this.element, {}).show()
    if ( $(this.element).data('audible') ) {
      // github.com/search?q=DOMException+play&type=commits
      let promise = new Audio('/audios/'+  $(this.element).data('audible') + '.mp3').play();
      if (promise !== undefined) {
        promise.then(() => {
          // play started
        }).catch((rejection) => {
          console.log(rejection)
        });
      }
    }
    if ( $(this.element).data('confetti') == true ) {
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
