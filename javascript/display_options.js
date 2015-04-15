/**
 * Created by gisborne on 4/14/15.
 */
var React = require('react')
var presenter = require('./function_presenter.js')
var Dialog = require('rc-dialog');
require('rc-dialog/assets/bootstrap.css');

function displayOptions(opts) {
  function close() {
    console.log('close');
  }

  function show() {
    console.log('show');
  }


  var dialog = React.render(
        (<Dialog title='Options' onClose={close} onShow={show} style={{width: 500}}>
          <p>first dialog</p>
        </Dialog>),
        document.getElementById('body-options')
    );

  dialog.show()
}

module.exports = {displayOptions: displayOptions};
