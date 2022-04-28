// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import './src/application.scss'
import "bootstrap"
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
global.$ = jQuery
import toastr from 'toastr'
window.toastr = toastr

const images = require.context('../images', true)

document.addEventListener('turbolinks:load', () => {
  var preloaderFadeOutTime = 500
  function hidePreloader() {
    var preloader = $('.spinner-wrapper')
    setTimeout(function() {
      preloader.fadeOut(preloaderFadeOutTime)
    }, 500)
  }

  hidePreloader()

  $(".custom-file-input").on("change", function() {
    var fileName = $(this).val().split("\\").pop()
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName)
  })
})
