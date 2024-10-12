import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const checkbox = event.target
    this.element.requestSubmit() // Automatically submit the form when the checkbox is toggled
  }
}
