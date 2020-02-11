// for vue-router
import Vue from 'vue'
import VueRouter from 'vue-router'

// Components for router
import Top from '../components/Top'
import UserDetail from '../components/UserDetail.vue'
import UserEdit from '../components/UserEdit.vue'
import UserImage from '../components/UserImage.vue'
import NotFound from '../components/NotFound.vue'
import HabitNew from '../components/HabitNew.vue'
import HabitDetail from '../components/HabitDetail.vue'
import HabitEdit from '../components/HabitEdit.vue'
import AllBestHabits from '../components/AllBestHabits.vue'
import GoogleMap from '../components/GoogleMap.vue'

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
      name: 'UserDetail',
      component: UserDetail
    },
    {
      path: '/user/edit',
      name: 'UserEdit',
      component: UserEdit
    },
    {
      path: '/user/image',
      name: 'UserImage',
      component: UserImage
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
      path: '/habit/edit',
      name: 'HabitEdit',
      component: HabitEdit
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
    },
    {
      path: '/map',
      name: 'GoogleMap',
      component: GoogleMap
    }
  ]
})

Vue.use(VueRouter)

export default router