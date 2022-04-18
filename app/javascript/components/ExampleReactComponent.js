import React from 'react';
import { FullFileBrowser } from 'chonky';


class ExampleReactComponent extends React.Component {
  render() {
    return (
      <div className="experiment1650288360">
	<div>{this.props.exampleprop}</div>
	<FullFileBrowser files={[]} folderChain={[]} />
      </div>
    );
  }
}

export default ExampleReactComponent
