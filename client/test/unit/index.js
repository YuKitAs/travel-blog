import Router from 'vue-router'
import Vue from 'vue'
import VueTestComponentWrapper from 'vue-test-component-wrapper'
import routes from '@/routes'

Vue.use(Router)

Vue.config.productionTip = false

// require all test files (files that ends with .spec.js)
const testsContext = require.context('./specs', true, /\.spec$/)
testsContext.keys().forEach(testsContext)

// require all src files except main.js for coverage.
// you can also change this to match only the subset of files that
// you want coverage for.
const srcContext = require.context('../../src', true, /^\.\/(?!main(\.js)?$)/)
srcContext.keys().forEach(srcContext)

VueTestComponentWrapper.setSpyOnMethod(sinon.spy)
VueTestComponentWrapper.setCreateSpyMethod(sinon.spy)
VueTestComponentWrapper.setCreateRouterMethod(() => new Router(routes))
