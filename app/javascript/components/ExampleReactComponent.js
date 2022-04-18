import React from 'react';
import { FullFileBrowser } from 'chonky';


class ExampleReactComponent extends React.Component {


  render() {
    const files = [
      { id: 'lht', name: 'Projects', isDir: true },
      {
        id: 'mcd',
        name: 'chonky-sphere-v2.png',
        thumbnailUrl: 'https://chonky.io/chonky-sphere-v2.png',
      },
    ]
    const folderChain = [{ id: 'xcv', name: 'Demo', isDir: true }]

    return (
      <div className="experiment1650288360">
	<div>{this.props.exampleprop}</div>
	<FullFileBrowser files={[]} folderChain={folderChain} />
      </div>
    );
  }
}

export default ExampleReactComponent
