import { Controller } from "stimulus"
import "form-request-submit-polyfill"

export default class extends Controller {
  static targets = [ "form", "submit" ]

  connect() {
    // Hide submit button
    this.submitTarget.classList.add("hidden")
  }

  submit() {
    // Submit the form via ajax
    this.formTarget.requestSubmit()
  }
}
