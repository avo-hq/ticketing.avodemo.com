# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/2.0/controllers.html
class Avo::CommentsController < Avo::ResourcesController
  def new_from_tool
    Comment.create!(
      ticket_id: params[:ticket_id],
      user: current_user,
      **tool_comment_params
    )

    # This would update the form turbo frame on the ticket page
    # It's slower than the comment broadcast so we're not using it
    # We're cleaning the form with JS instead
    # redirect_to resources_ticket_path(params[:ticket_id])

    head :no_content
  end

  private
  
  def tool_comment_params
    params.require(:comment).permit(:content)
  end
end
