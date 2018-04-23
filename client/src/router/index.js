import Vue from 'vue';
import Router from 'vue-router';
import Articles from '@/pages/Articles';
import About from '@/pages/About';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      redirect: { name: 'Articles' },
    },
    {
      path: '/articles',
      name: 'Articles',
      component: Articles,
    },
    {
      path: '/about',
      name: 'About',
      component: About,
    },
  ],
});
