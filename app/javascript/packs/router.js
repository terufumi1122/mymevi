// for vue-router
import Vue from 'vue'
import VueRouter from 'vue-router'

// Components for router
import UsersIndex from '../components/UsersIndex.vue'
import UserDetail from '../components/UserDetail.vue'
import UserNew from '../components/UserNew.vue'
import UserEdit from '../components/UserEdit.vue'
import NotFound from '../components/NotFound.vue'

// Routing
const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
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
  ]
})

Vue.use(VueRouter)

export default router