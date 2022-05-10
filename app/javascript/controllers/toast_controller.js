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
    this.confetti(this.element)
    this.voice(this.element)
  }

  confetti(element) {
    if ( $(this.element).data('confetti') == '0' ) { return }

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

  voice(element) {
    if ( $(this.element).data('voice') == '0' ) { return }
    if ( Math.floor(Math.random()*100) > parseInt($(this.element).data('voice-strength')) ) { return }

    let accent = undefined

    let all_accents = [
      "it_IT_Alice",
      "sv_SE_Alva",
      "fr_CA_Amelie",
      "de_DE_Anna",
      "en_GB_Daniel",
      "nl_BE_Ellen",
      "en-scotland_Fiona",
      "pt_PT_Joana",
      "en_AU_Karen",
      "ja_JP_Kyoko",
      "it_IT_Luca",
      "ru_RU_Milena",
      "en_IE_Moira",
      "en_US_Samantha",
      "fi_FI_Satu",
      "fr_FR_Thomas",
      "en_US_Victoria"      
    ]
    
    let accents = $(this.element).data('accent').split(",")
    if (accents[0] == 'random') {
      accent = all_accents[Math.floor(Math.random()*all_accents.length)]
    } else {
      accent = accents[Math.floor(Math.random()*accents.length)]
    }
    console.log(accent)
    let str = $(this.element).data('bucket') + '/audios/' + accent + '_' + $(this.element).data('voice').replace(/ /g,"_") + '.mp3'
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
