module.exports = {
  devServer: {
    host: '0.0.0.0',
    port: 9000,
    watchOptions: {
      ignored: [/node_modules/, /public/],
      aggregateTimeout: 300,
      poll: 1500
    }
  },
  chainWebpack: config => {
  }
}
