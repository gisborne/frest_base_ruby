"use strict"
var uuid = require('node-uuid')
var presenter = require('./function_presenter.js')
var displayOptions = require('./display_options.js')

function showOptions(target) {
  var req = $.ajax({
      url: window.location,
      dataType: 'json',
      accept: 'text/json',
      method: 'OPTIONS',
      data: {id: target.id}
    })

  req.success(displayOptions.displayOptions)
  req.fail(function(j, status, err) {
    console.log("ERROR: " + status + "     " + err)})
}

function getScript(url, data) {
  $.ajax({
    url: url,
    dataType: 'script',
    accept: 'application/javascript',
    method: 'OPTIONS',
    data: data
  })
}

function handleClick(evt) {
  if ($(evt.target).hasClass('fa-cog')) {
    $('.fa-cog').toggle()
    $('body > .fa-cog').show()

    showOptions(evt.target)
  }
}

$(function() {

  $('body').click(handleClick)

  function linkListPresenter() {

  }

  var typePresenters = {

  }
})

module.exports = {
  displayOptions: displayOptions.displayOptions,
  present: presenter.present,
  definePresenter: presenter.definePresenter
}
