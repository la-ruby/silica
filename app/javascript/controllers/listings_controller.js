import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "map", "input" ]

  bedAny() { $("#apollo-listings #beds").val('any'); this.submit() }
  bed1() { $("#apollo-listings #beds").val('1'); this.submit() }
  bed2() { $("#apollo-listings #beds").val('2'); this.submit() }
  bed3() { $("#apollo-listings #beds").val('3'); this.submit() }
  bed4() { $("#apollo-listings #beds").val('4'); this.submit() }
  bed5() { $("#apollo-listings #beds").val('5'); this.submit() }

  bathAny() { $("#apollo-listings #baths").val('any'); this.submit() }
  bath1() { $("#apollo-listings #baths").val('1'); this.submit() }
  bath2() { $("#apollo-listings #baths").val('2'); this.submit() }
  bath3() { $("#apollo-listings #baths").val('3'); this.submit() }
  bath4() { $("#apollo-listings #baths").val('4'); this.submit() }
  bath5() { $("#apollo-listings #baths").val('5'); this.submit() }

  highest() { $("#apollo-listings #sort").val('2'); this.submit() }
  lowest() { $("#apollo-listings #sort").val('1'); this.submit() }

  listView() { $("#apollo-listings #map").val('1'); this.submit() }
  mapView() { $("#apollo-listings #map").val('2'); this.submit() }

  input() {
    $("#apollo-listings #q").val( $(this.inputTarget).val() )
    this.submit()
  }

  submit() {
    let that = this
    var returnedFunction = this.debounce(function() {
      $("#apollo-listings .main-form")[0].dispatchEvent(new CustomEvent('submit', {bubbles: true}))
    }, 750);
    returnedFunction()
  }

  // https://www.educative.io/edpresso/how-to-use-the-debounce-function-in-javascript
  debounce(func, wait, immediate) {
    var timeout;
  
    return function executedFunction() {
      var context = this;
      var args = arguments;
  	    
      var later = function() {
        timeout = null;
        if (!immediate) func.apply(context, args);
      };
  
      var callNow = immediate && !timeout;
  	
      clearTimeout(timeout);
  
      timeout = setTimeout(later, wait);
  	
      if (callNow) func.apply(context, args);
    };
  };

}
