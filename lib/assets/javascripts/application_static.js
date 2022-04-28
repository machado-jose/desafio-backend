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
