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

    if ( $(this.element).data('voice') != '0' ) {
      let str = '/audios/' + $(this.element).data('accent') + '_' + $(this.element).data('voice').replace(/ /g,"_") + '.mp3'
      // github.com/search?q=DOMException+play&type=commits
      let promise = new Audio(str).play();
      if (promise !== undefined) {
        promise.then(() => {
          // play started
        }).catch((rejection) => {
          console.log(rejection)
        });
      }
    }
  }
}
