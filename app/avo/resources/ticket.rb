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
    field :description, as: :textarea, show_on: :preview
    tiny_description if view&.index?
    field :preview, as: :preview
      
    field :user, as: :belongs_to
    status_priority_fields
    field :created_at, as: :date_time, filterable: true, sortable: true

    tool Avo::ResourceTools::Comments
  end

  def tiny_description
    field :tiny_description, as: :text do 
      record.description.truncate(25)
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

  def scopes
    scope Avo::Scopes::HighPriority
    scope Avo::Scopes::MediumPriority
    scope Avo::Scopes::LowPriority
    scope Avo::Scopes::Open
    scope Avo::Scopes::InProgress
    scope Avo::Scopes::Done
    scope Avo::Scopes::Closed
  end

  def actions
    action Avo::Actions::ChangeUser
  end
end
