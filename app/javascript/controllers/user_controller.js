import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["firstName", "lastName", "email", "password", "confirmPassword"]

  async signIn(event) {
    // Prevents redirecting on form submission
    event.preventDefault();

    // Update button state
    const button = event.currentTarget
    button.classList.add("disabled-button")
    button.innerText = "Submitting..."

    // Sends post request for user sign in
    const response = await this.#signInUser()
    const { result } = await response.json()

    // Update button state
    button.classList.remove("disabled-button")
    button.innerText = "Sign In"

    // Handle result state
    if(result.success) {
      window.successNotifier("Sign In Successful!")
      setTimeout(function () {
        window.location.href = "/home";
      }, 2000);
    } else {
      window.errorNotifier("Invalid email or password")
    }
  }

  #signInUser() {
    const url = "/user/sign_in_user"
    return fetch(url, {
      method: "POST",
      headers: { 
        "Content-Type": "application/json"
      },
      body: JSON.stringify(this.#buildSignInData())
    })
  }

  #buildSignInData() {
    return {
      email: this.emailTarget.value,
      password: this.passwordTarget.value
    }
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
    const { result } = await response.json()

    // Update button state
    button.classList.remove("disabled-button")
    button.innerText = "Sign Up"

    // Handle result state
    if(result.success) {
      window.successNotifier("Account Created!")
      setTimeout(function () {
        window.location.href = "/user/sign_in";
      }, 2000);
    } else {
      window.errorNotifier("Something Went Wrong!", result.errors.toString().replaceAll(",", "\n"))
    }
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
