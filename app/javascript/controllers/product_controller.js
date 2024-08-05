import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  static targets = ["name", "description", "price", "productId"]

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

  async editProduct(event) {
    // Prevents redirecting on form submission
    event.preventDefault();

    // Update button state
    const button = event.currentTarget
    button.classList.add("disabled-button")
    button.innerText = "Updating..."

    // Sends post request for user creation
    const response = await this.#editProductRequest()
    const { result } = await response.json()

    // Update button state
    button.classList.remove("disabled-button")
    button.innerText = "Edit"

    // Handle result state
    if(result.success) {
      window.successNotifier("Product Updated!")
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
      body: JSON.stringify(this.#buildCreateProductData())
    })
  }

  #editProductRequest() {
    const url = "/product/edit"
    return fetch(url, {
      method: "PUT",
      headers: { 
        "Content-Type": "application/json"
      },
      body: JSON.stringify(this.#buildEditProductData())
    })
  }

  #buildCreateProductData() {
    return {
      name: this.nameTarget.value,
      description: this.descriptionTarget.value,
      price: this.priceTarget.value,
    }
  }

  #buildEditProductData() {
    return {
      name: this.nameTarget.value,
      description: this.descriptionTarget.value,
      price: this.priceTarget.value,
      productId: this.productIdTarget.value
    }
  }


  #clearValues() {
    this.nameTarget.value = ""
    this.descriptionTarget.value = ""
    this.priceTarget.value = 0
  }

  async deleteProduct(event) {
    // Update button state
    const button = event.currentTarget
    button.disabled = true

    // Sends post request for product deletion
    const response = await this.#deleteProductRequest(button.getAttribute("data-product-id"))
    const { result } = await response.json()

    // Handle result state
    if(result.success) {
      window.successNotifier("Product Deleted")
      // Deletes product card on successful delete
      button.parentElement.parentElement.remove()
    } else {
      window.errorNotifier("Something Went Wrong!", result.errors.toString().replaceAll(",", "\n"))
    }
  }

  #deleteProductRequest(productId) {
    const url = "/product/delete"
    return fetch(url, {
      method: "DELETE",
      headers: { 
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ productId })
    })
  }
}
