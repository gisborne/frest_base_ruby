/**
 * Created by gisborne on 4/14/15.
 */
var React = require('react')
var presenter = require('./function_presenter.js')
var Dialog = require('rc-dialog');
require('rc-dialog/assets/bootstrap.css');

function displayOptions(opts) {
  function close() {
  }

  function show() {
  }

  var CategoryTitle = React.createClass({
      render: function() {
          return (<span className="category-title">{this.props.category}</span>);
      }
  });

  var Link = React.createClass({
    render: function() {
      return (<a href={this.props.href}>{this.props.text}</a>)
    }
  })
  var Links = React.createClass({
    render:function() {
      var rows = []
      var targets = this.props.targets
      for (var index in targets) {
        var title = targets[index].title
        rows.push(<Link href={'/' + index} key={index} text={title} />)
      }
      return (<div>{rows}</div>)
    }
  })

  var dialog = React.render(
        (<Dialog title='Possible actions' onClose={close} onShow={show} style={{width: 500}}>
          <Links targets={opts.functions} />
        </Dialog>),
        document.getElementById('body-options')
    );

  dialog.show()
}

module.exports = {displayOptions: displayOptions};
