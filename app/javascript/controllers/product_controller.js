import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  static targets = ["name", "description", "price"]

  async createProduct(event) {
    // Prevents redirecting on form submission
    event.preventDefault();

    // Update button state
    const button = event.currentTarget
    button.classList.add("disabled-button")
    button.innerText = "Creating..."

    // Sends post request for user creation
    const response = await this.#createProductRequest()
    const { result } = await response.json()

    // Update button state
    button.classList.remove("disabled-button")
    button.innerText = "Create"

    // Handle result state
    if(result.success) {
      window.successNotifier("Product Created!")
      this.#clearValues()
    } else {
      window.errorNotifier("Something Went Wrong!", result.errors.toString().replaceAll(",", "\n"))
    }
  }

  #createProductRequest() {
    const url = "/product/create"
    return fetch(url, {
      method: "POST",
      headers: { 
        "Content-Type": "application/json"
      },
      body: JSON.stringify(this.#buildProductData())
    })
  }

  #buildProductData() {
    return {
      name: this.nameTarget.value,
      description: this.descriptionTarget.value,
      price: this.priceTarget.value
    }
  }

  #clearValues() {
    this.nameTarget.value = ""
    this.descriptionTarget.value = ""
    this.priceTarget.value = 0
  }
}
