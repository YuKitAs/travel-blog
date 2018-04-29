import Router from 'vue-router'
import Vue from 'vue'
import VueTestComponentWrapper from 'vue-test-component-wrapper'
import initialize from '@/initialize'
import routes from '@/routes'

initialize(Vue)

// require all test files (files that ends with .spec.js)
const testsContext = require.context('./specs', true, /\.spec$/)
testsContext.keys().forEach(testsContext)

// require all src files except main.js for coverage.
// you can also change this to match only the subset of files that
// you want coverage for.
const srcContext = require.context('../../src', true, /^\.\/(?!main(\.js)?$)/)
srcContext.keys().forEach(srcContext)

VueTestComponentWrapper.setSpyOnMethod(sinon.stub)
VueTestComponentWrapper.setCreateSpyMethod(sinon.stub)
VueTestComponentWrapper.setCreateRouterMethod(() => new Router(routes))
