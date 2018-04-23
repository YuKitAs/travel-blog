import Vue from 'vue';
import Router from 'vue-router';
import About from '@/pages/About';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      name: 'About',
      component: About,
    },
    {
      path: '/about',
      name: 'About',
      component: About,
    },
  ],
});
