// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import App from '@/App'
import initialize from '@/initialize'
import routes from '@/routes'
import Router from 'vue-router'
import Vue from 'vue'

initialize(Vue)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router: new Router(routes),
  components: { App },
  template: '<App/>'
})
