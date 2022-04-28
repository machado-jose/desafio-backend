$(function(){
  body = document.querySelector('body')
  if(body.dataset.flashMessage.length > 0){
    setTimeout(function() {
      toastr.info(body.dataset.flashMessage)
    }, 1000)
  }
})
