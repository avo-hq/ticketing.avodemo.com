class Avo::Resources::Ticket < Avo::BaseResource
  self.includes = [:user]
  self.record_selector = false
  self.index_query = -> do
    query.order(:priority)
  end

  def fields
    field :title, as: :text
    field :description, as: :textarea
    if view&.form?
      field :status, as: :select, enum: ::Ticket.statuses
      field :priority, as: :select, enum: ::Ticket.priorities
    else
      field :status, as: :status, success_when: [:done], loading_when: [:in_progress], failed_when: [:closed]
      field :priority, as: :badge, sortable: true, options: {
        success: "low",
        warning: "medium",
        danger: "high",
      }
    end
    field :user, as: :belongs_to

    tool Avo::ResourceTools::Comments
  end
end
