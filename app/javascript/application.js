// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

window.successNotifier = function(header = "", subText = "") {
  const toastNotif = document.querySelector(
    ".toast-notification[data-type=success]"
  );
  toastNotif.classList.add("active");
  toastNotif.querySelector("#header").innerText = header
  toastNotif.querySelector("#subtext").innerText = subText
  setTimeout(function () {
    toastNotif.classList.remove("active");
  }, 5000);
}

window.errorNotifier = function(header = "", subText = "") {
  const toastNotif = document.querySelector(
    ".toast-notification[data-type=error]"
  );
  toastNotif.classList.add("active");
  toastNotif.querySelector("#header").innerText = header
  toastNotif.querySelector("#subtext").innerText = subText
  setTimeout(function () {
    toastNotif.classList.remove("active");
  }, 7000);
}