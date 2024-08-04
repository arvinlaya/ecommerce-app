import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["firstName", "lastName", "email", "password", "confirmPassword"]
  
  connect() {
    console.log("USER CONTROLLER STIMULUS CONNECTED")
  }

  async signUp(event) {
    // Prevents redirecting on form submission
    event.preventDefault();

    // Update button state
    const button = event.currentTarget
    button.classList.add("disabled-button")
    button.innerText = "Submitting..."

    // Sends post request for user creation
    const response = await this.#createUser()
    const result = await response.json()
    debugger
  }

  #createUser() {
    const url = "/user/create_user"
    return fetch(url, {
      method: "POST",
      headers: { 
        "Content-Type": "application/json"
      },
      body: JSON.stringify(this.#buildUserData())
    })
  }

  #buildUserData() {
    return {
      firstName: this.firstNameTarget.value,
      lastName: this.lastNameTarget.value,
      email: this.emailTarget.value,
      password: this.passwordTarget.value,
      confirmPassword: this.confirmPasswordTarget.value
    }
  }
}
