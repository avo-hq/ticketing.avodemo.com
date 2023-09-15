# frozen_string_literal: true

class Avo::TutorialComponent < ViewComponent::Base
  def initialize(message: nil, user: nil)
    @message = message
    @user = user
  end

  def render?
    return false if @user.blank? || @message.blank?
    @user.settings["tutorial"]
  end
end
