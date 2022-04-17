const path    = require("path")
const webpack = require("webpack")

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js",
    silica_actiontext: "./app/javascript/silica_actiontext.js",
    examplereactcomponent: "./app/javascript/examplereactcomponent.js",
    examplealternativereactcomponent: "./app/javascript/examplealternativereactcomponent.js",
    my_file_browser_entry: "./app/javascript/my_file_browser_entry.js"
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[name].js.map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ],
  module: {
    rules: [
      {
        test: /\.(js|jsx|ts|tsx|)$/,
        exclude: /node_modules/,
        use: ['babel-loader'],
      }
    ]
  }
}
