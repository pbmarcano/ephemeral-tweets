import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form", "submit" ]

  connect() {
    // Hide submit button if it shows up for some reason
    if (this.hasSubmitTarget) {
      this.submitTarget.classList.add("hidden")
    }
  }

  submit() {
    // Submit the form via ajax
    this.formTarget.requestSubmit()
  }
}
