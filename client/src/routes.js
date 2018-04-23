import About from '@/pages/About';
import Articles from '@/pages/Articles';

export default {
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
};
