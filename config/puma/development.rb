require 'rails'
require './config/environment.rb'

if Rails.env.development?
  bind 'tcp://0.0.0.0:3000'
end
