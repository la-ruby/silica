class ExampleReactComponent extends React.Component {
  render() {
    return (
      <div className="abc">
        <h1>for {this.props.name}</h1>
        <ul>
          <li>Abc</li>
        </ul>
      </div>
    );
  }
}

export default ExampleReactComponent
