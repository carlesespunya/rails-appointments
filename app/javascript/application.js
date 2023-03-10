// Dependencies
import { RalixApp } from 'ralix'
import "@hotwired/turbo-rails"

// Controllers
import AppCtrl from './controllers/app'
import UsersCtrl from './controllers/users'

// Components
import RemoteModal  from './components/remote_modal'
import Tooltip      from './components/tooltip'

const App = new RalixApp({
  routes: {
    '/users$': UsersCtrl,
    '/.*': AppCtrl
  },
  components: [
    RemoteModal,
    Tooltip
  ]
})

App.start()
