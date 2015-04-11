$(function() {
  frest = frest || {}
  function showOptions(target) {
    $.ajax({
      url: window.location,
      dataType: 'script',
      accept: 'application/javascript',
      method: 'OPTIONS',
      data: {
        id: target.id}
    })
  }

  function handleClick(evt) {
    $('.fa-cog').toggle()
    $('body > .fa-cog').show()

    showOptions(evt.target)
  }

  $('body').click(handleClick)

  $.ajax({
    url: window.location,
    dataType: 'script',
    accept: 'application/javascript'}
  )

  function linkListPresenter() {

  }

  frest.typePresenters = {

  }



  frest.showOptions = function showOptions(opt) {
    //top level is a hash of type of thing to its presenter
  }
})