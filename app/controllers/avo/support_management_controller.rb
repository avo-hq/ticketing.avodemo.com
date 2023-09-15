class Avo::SupportManagementController < Avo::ResourcesController
  before_action :set_tutorial, only: [:index]

  def index
    super
    render :index_with_tutorial
  end

  def set_tutorial
    @tutorial_message = tutorial_message
  end

  def tutorial_message; end
end