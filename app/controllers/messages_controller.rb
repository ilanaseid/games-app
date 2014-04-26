class MessagesController < ApplicationController
  def index
  	@messages = Message.all
  	@message = Message.new
  end

  def create
  	@message = Message.create!(params[:message])
  end
end
