import About from '@/pages/About'
import Articles from '@/pages/Articles'
import Article from '@/pages/Article'
import Tags from '@/pages/Tags'
import Error from '@/pages/Error'

export default {
  routes: [
    {
      path: '/',
      redirect: { name: 'Articles' }
    },
    {
      path: '/error',
      name: 'Error',
      component: Error
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
      path: '/tags',
      name: 'Tags',
      component: Tags,
      props: true
    },
    {
      path: '/about',
      name: 'About',
      component: About
    }
  ]
}
