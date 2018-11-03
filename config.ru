# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# use OmniAuth::Builder do
#       provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], :scope => 'email,read_stream'
#     end

run Rails.application
