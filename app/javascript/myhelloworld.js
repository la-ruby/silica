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

// ################################################################################

import {FullFileBrowser} from 'chonky';

export const MyFileBrowser = () => {
        const files = [
            {
                id: '1',
                name: 'andyc_med.txt',
            },
            {
                id: '2',
                name: 'brevallf_med.txt',
            },
            {
                id: '3',
                name: 'mathisg_med.txt',
            },
        ];
        const folderChain = [
            {id: 'xcv', name: 'Fiches médicales', isDir: true},
        ];
        return (
            <div style={{height: 600}}>
                <FullFileBrowser files={files} folderChain={folderChain}/>
            </div>
        );
    }
;

// window.silica_chonky = React.createElement(MyFileBrowser, {name: 'Rails 7'}, null)
