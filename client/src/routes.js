import About from '@/pages/About'
import Articles from '@/pages/Articles'
import Article from '@/pages/Article'

export default {
  routes: [
    {
      path: '/',
      redirect: { name: 'Articles' }
    },
    {
      path: '/articles',
      name: 'Articles',
      component: Articles
    },
    {
      path: '/articles/:articleId',
      name: 'Articles.Article',
      component: Article,
      props: true
    },
    {
      path: '/about',
      name: 'About',
      component: About
    }
  ]
}
