// for vue-router
import Vue from 'vue'
import VueRouter from 'vue-router'

// Components for router
import Top from '../components/Top'
import UsersIndex from '../components/UsersIndex.vue'
import UserDetail from '../components/UserDetail.vue'
import UserNew from '../components/UserNew.vue'
import UserEdit from '../components/UserEdit.vue'
import NotFound from '../components/NotFound.vue'

import LoginForm from '../components/LoginForm.vue'
import SignUpForm from '../components/SignUpForm.vue'

// Routing
const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Top',
      component: Top
    },
    {
      path: '/users',
      name: 'UsersIndex',
      component: UsersIndex
    },
    {
      path: '/users/:id(\\d+)',
      name: 'UserDetail',
      component: UserDetail
    },
    {
      path: '/users/new',
      name: 'UserNew',
      component: UserNew
    },
    {
      path: '/users/:id(\\d+)/edit',
      name: 'UserEdit',
      component: UserEdit
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    },
    {
      path: '/login',
      name: 'LoginForm',
      component: LoginForm
    },
    {
      path: '/signup',
      name: 'SignUpForm',
      component: SignUpForm
    },
  ]
})

Vue.use(VueRouter)

export default router