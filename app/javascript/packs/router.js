// for vue-router
import Vue from 'vue'
import VueRouter from 'vue-router'

// Components for router
import Top from '../components/Top'
import UserDetail from '../components/UserDetail'
import UserEdit from '../components/UserEdit'
import UserImage from '../components/UserImage'
import NotFound from '../components/NotFound'
import HabitNew from '../components/HabitNew'
import HabitDetail from '../components/HabitDetail'
import HabitEdit from '../components/HabitEdit'
import AllBestHabits from '../components/AllBestHabits'
import GoogleMap from '../components/GoogleMap'
import CommentEdit from '../components/CommentEdit'

import LoginForm from '../components/LoginForm'
import SignUpForm from '../components/SignUpForm'

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
      path: '/habit/new',
      name: 'HabitNew',
      component: HabitNew
    },
    {
      path: '/habit/edit',
      name: 'HabitEdit',
      component: HabitEdit
    },
    {
      path: '/habit/detail',
      name: 'HabitDetail',
      component: HabitDetail
    },
    {
      path: '/comment/edit',
      name: 'CommentEdit',
      component: CommentEdit
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
      path: '/habits/all',
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