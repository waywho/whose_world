import Vue from 'vue'
import VueRouter from 'vue-router'
import Registration from '../components/registration'
import signIn from '../components/signIn'
import adminDashboard from '../components/admin_dashboard'
import { store } from '../store/store'
import landingPage from '../components/landing_page'

const ifNotAuthenticated = (to, from, next) => {
	if (!store.getters.authenticated) {
		next()
		return
	}
	next('/admin/dashboard')
}

const ifAuthenticated = (to, from, next) => {
	if (store.getters.authenticated) {
		next()
		return
	}
	next({ path: '/admin' })
}

Vue.use(VueRouter)
const router = new VueRouter({
	mode: 'history',
	routes: [
		{ path: '/', component: landingPage },
		{ path: '/admin/sign_up', name: 'registraton', component: Registration, beforeEnter: ifNotAuthenticated},
		{ path: '/admin', name: 'signIn', component: signIn, beforeEnter: ifNotAuthenticated }, 
		{ path: '/admin/dashboard', name: 'dashboard', component: adminDashboard, beforeEnter: ifAuthenticated }
	]
})

export default router