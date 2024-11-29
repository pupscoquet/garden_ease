import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hideable"]

  hide() {
    this.hideableTarget.display = none
  }
}
