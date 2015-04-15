"use strict"
var uuid = require('node-uuid')
var presenter = require('./function_presenter.js')
var displayOptions = require('./display_options.js')

function showOptions(target) {
  getScript(window.location, {id: target.id})
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
