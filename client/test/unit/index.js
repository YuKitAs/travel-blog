import _ from 'lodash'
import Vue from 'vue'
import Router from 'vue-router'
import VueTestComponentWrapper from 'vue-test-component-wrapper'
import initialize from '@/initialize'
import routes from '@/routes'

initialize(Vue)

VueTestComponentWrapper.config.set({
  router: {
    enabled: true,
    createRouterMethod: () => new Router(routes)
  },
  extraMixins: [
    {
      getProp(propName) {
        return _.get(this.vm.$props, propName)
      },

      async untilAsyncTasksDone(timeout = 0) {
        await this.untilPromisesResolved(timeout)
      }
    }
  ]
})

// require all test files (files that ends with .spec.js)
const testsContext = require.context('./specs', true, /\.spec$/)
testsContext.keys().forEach(testsContext)

// require all src files except main.js for coverage.
// you can also change this to match only the subset of files that
// you want coverage for.
const srcContext = require.context('../../src', true, /^\.\/(?!main(\.js)?$)/)
srcContext.keys().forEach(srcContext)
