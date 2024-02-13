# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/2.0/controllers.html
class Avo::UsersController < Avo::TicketingController
  def tutorial_message
    "This page will show you all the users registered in the application. You can search for users, filter them, and even edit them."
  end

  def get_users
    render json: User.all.map do |user|
      {
        label: user.name
        value: user.id,
      }
    end
  end
end
