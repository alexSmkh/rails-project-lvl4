import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'

import '@fortawesome/fontawesome-free/css/all'

import 'bootstrap'
import 'stylesheets/application'


Rails.start()
Turbolinks.start()
ActiveStorage.start()
