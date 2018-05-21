// This is a karma config file. For more details see
//   http://karma-runner.github.io/0.13/config/configuration-file.html
// we are also using it with karma-webpack
//   https://github.com/webpack/karma-webpack

const webpackConfig = require('../../build/webpack.test.conf')
const path = require('path')

module.exports = function karmaConfig(config) {
  config.set({
    // to run in additional browsers:
    // 1. install corresponding karma launcher
    //    http://karma-runner.github.io/0.13/config/browsers.html
    // 2. add it to the `browsers` array below.
    browsers: ['Chrome_test_environment'],
    customLaunchers: {
      Chrome_test_environment: {
        base: 'Chrome',
        flags: [
          '--disable-gpu',
          '--headless',
          '--no-sandbox',
          '--remote-debugging-port=9222'
        ]
      }
    },
    frameworks: ['mocha', 'fixture', 'sinon-chai'],
    reporters: ['spec', 'coverage'],
    files: [
      './index.js',
      '../fixture/**/*.json'
    ],
    preprocessors: {
      './index.js': ['webpack', 'sourcemap'],
      '../fixture/**/*.json': ['json_fixtures']
    },
    jsonFixturesPreprocessor: {
      variableName: '__json__',
      // We have to set stripPrefix, otherwise the key is the absolute path:
      stripPrefix: path.join(__dirname, '../fixture'),
      // This is the default searching path:
      prependPrefix: 'spec/fixtures'
    },
    webpack: webpackConfig,
    webpackMiddleware: {
      noInfo: true
    },
    coverageReporter: {
      dir: './coverage',
      reporters: [
        { type: 'lcov', subdir: '.' },
        { type: 'text-summary' }
      ]
    }
  })
}
