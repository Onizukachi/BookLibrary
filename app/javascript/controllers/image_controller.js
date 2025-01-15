import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image"
export default class extends Controller {
  static targets = ["currentImages", "removeInput", "newImages"];

  remove(event) {
    event.currentTarget.parentElement.remove()

    const imageId = event.currentTarget.dataset.id

    if (imageId) {
      const removeInput = this.removeInputTarget
      const currentIds = removeInput.value ? removeInput.value.split(",") : []
      if (!currentIds.includes(imageId)) {
        currentIds.push(imageId)
        removeInput.value = currentIds.join(",")
      }
    }
  }

  preview(event) {
    const files = Array.from(event.target.files)
    const newImagesContainer = this.newImagesTarget
    newImagesContainer.innerHTML = ""

    files.forEach((file) => {
      const reader = new FileReader()

      reader.onload = (e) => {
        const imageElement = document.createElement("div")
        imageElement.className = "flex"
        imageElement.innerHTML = `<img src="${e.target.result}" alt="Изображение" class="w-36 h-28 object-cover rounded-md" />`;

        newImagesContainer.appendChild(imageElement)
      };

      reader.readAsDataURL(file)
    });
  }
}
