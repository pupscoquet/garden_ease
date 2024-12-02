import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

const savedBtn = document.querySelector("#saved-btn")
savedBtn.addEventListener("click", () => {
  savedBtn.style.display = "none";
  savedBtn.classList.remove = "button-purple";
})


export { application }
