import * as React from 'react'
import Switch from 'react-ios-switch';

class ShoppingList extends React.Component {
  render() {
    return (
      <div className="shopping-list">
        <h1>Shopping List for {this.props.name}</h1>
        <ul>
          <li>Instagram</li>
          <li>WhatsApp</li>
          <li>Oculus</li>
        </ul>
      </div>
    );
  }
}


window.hello = React.createElement(ShoppingList, {name: 'Rails 7'}, null)


class SilicaSwitch extends React.Component {
  render() {
    return (
      <Switch
        checked={true}
        onChange={checked => {}}
      />
    );
  }
}
window.silica_switch = React.createElement(SilicaSwitch, {name: 'Rails 7'}, null)
