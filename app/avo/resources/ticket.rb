class Avo::Resources::Ticket < Avo::BaseResource
  self.includes = [:user]
  self.record_selector = false
  self.index_query = -> do
    query.order(:priority)
  end
  self.search = {
    query: -> { query.ransack(title_cont: params[:q]).result(distinct: false) }
  }

  def fields
    field :title, as: :text, link_to_record: true, filterable: true, sortable: true
    field :description, as: :textarea
    tiny_description if view&.index?
      
    field :user, as: :belongs_to
    status_priority_fields

    tool Avo::ResourceTools::Comments
  end

  def tiny_description
    field :tiny_description, as: :text, filterable: true, sortable: true do 
      record.description.truncate(50)
    end
  end

  def status_priority_fields
    if view&.form?
      field :status, as: :select, enum: ::Ticket.statuses
      field :priority, as: :select, enum: ::Ticket.priorities
    else
      field :status,
        as: :status,
        success_when: [:done],
        loading_when: [:in_progress],
        failed_when: [:closed]
      
      field :priority, as: :badge, options: {
          success: "low",
          warning: "medium",
          danger: "high",
        }
    end
  end
end
