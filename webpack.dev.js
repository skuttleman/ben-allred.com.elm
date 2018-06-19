const merge = require('webpack-merge');
const common = require('./webpack.common');

const proxy = {
  target: 'http://localhost:3000/index.html',
  secure: false,
  ignorePath: true
};

module.exports = merge(common, {
  devtool: 'inline-source-map',
  devServer: {
    inline: true,
    stats: { colors: true },
    proxy : {
      '/bio': proxy,
      '/portfolio': proxy,
      '/music': proxy
    },
  },
});