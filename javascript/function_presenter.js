/**
 * Created by gisborne on 4/13/15.
 */
var React = require('react')
var dialog = require('rc-dialog')

function definePresenter(name, sourceType, targetType, fn) {
  frest.presenters = frest.presenters ? frest.presenters : {}

  frest.presenters[name] = {
        from: sourceType,
        to: targetType,
        fn: fn
  }
}

module.exports = {
  present: function present(what, sourceType, targetType) {

  },
  definePresenter: definePresenter
}
