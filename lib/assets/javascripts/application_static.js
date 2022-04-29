$(function(){
  body = document.querySelector('body')
  if(body.dataset.flashMessage.length > 0){
    setTimeout(function() {
      toastr.info(body.dataset.flashMessage)
    }, 1000)
  }
})

function fadeInSpinner(msg = '', time = 500){
  if(msg.length > 0){
    $("#spinner-message").text(msg)
  }
  $('.spinner-wrapper').fadeIn(time)
}

document.addEventListener('cable-ready:after-set-dataset-property', function(){
  message = document.getElementById("message").dataset.message
  toastr.info(`Os gastos do deputado(a) ${message} foram cadastrados!`)
})
