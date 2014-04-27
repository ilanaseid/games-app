require ::File.expand_path('../config/environment', __FILE__)
require 'faye'
require 'faye/websocket'
Faye::WebSocket.load_adapter('thin')
run Rails.application