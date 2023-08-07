require 'rails'
require './config/environment'

bind 'tcp://0.0.0.0:3000' if Rails.env.development?
