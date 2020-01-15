// for vue-router
import Vue from 'vue'
import VueRouter from 'vue-router'

// Components for router
import Top from '../components/Top'
import UserDetail from '../components/UserDetail.vue'
import UserEdit from '../components/UserEdit.vue'
import NotFound from '../components/NotFound.vue'
import HabitNew from '../components/HabitNew.vue'
import HabitDetail from '../components/HabitDetail.vue'
import AllBestHabits from '../components/AllBestHabits.vue'

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
      path: '/user',
      // path: '/users/:id(\\d+)',
      name: 'UserDetail',
      component: UserDetail
    },
    {
      path: '/user/edit',
      name: 'UserEdit',
      component: UserEdit
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    },
    {
      path: '/newhabit',
      name: 'HabitNew',
      component: HabitNew
    },
    {
      path: '/habitdetail',
      name: 'HabitDetail',
      component: HabitDetail
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
    {
      path: '/allhabits',
      name: 'AllBestHabits',
      component: AllBestHabits
    }
  ]
})

Vue.use(VueRouter)

export default router