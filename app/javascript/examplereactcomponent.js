import * as React from 'react'

class ExampleReactComponent extends React.Component {
  render() {
    return (
      <div className="abc">
        <h1>Testing for {this.props.name}</h1>
        <ul>
          <li>Abc</li>
        </ul>
      </div>
    );
  }
}

window.examplereactcomponent = React.createElement(ExampleReactComponent, {name: 'Testing'}, null)
