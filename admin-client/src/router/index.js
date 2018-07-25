import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import Home from '@/components/AdminHome'
import Articles from '@/components/Articles'
import Places from '@/components/Places'
import Tags from '@/components/Tags'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/home',
      name: 'AdminHome',
      component: Home
    },
    {
      path: '/articles',
      name: 'Articles',
      component: Articles
    },
    {
      path: '/places',
      name: 'Places',
      component: Places
    },
    {
      path: '/tags',
      name: 'Tags',
      component: Tags
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
