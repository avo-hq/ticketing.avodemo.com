class Avo::Resources::Ticket < Avo::BaseResource
  self.includes = [:user]
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  }

  def fields
    field :title, as: :text
    field :description, as: :textarea
    field :status, as: :select, enum: ::Ticket.statuses
    field :priority, as: :select, enum: ::Ticket.priorities
    field :user_id, as: :number
    field :user, as: :belongs_to
  end
end
