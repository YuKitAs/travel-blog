// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import App from './App';
import Router from 'vue-router';
import Vue from 'vue';
import routes from './routes';

Vue.use(Router);

Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router: new Router(routes),
  components: { App },
  template: '<App/>',
});
