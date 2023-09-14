class Avo::Resources::User < Avo::BaseResource
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :email, as: :text
    field :roles,
      as: :boolean_group,
      options: {
        admin: "Administrator",
        manager: "Manager",
      }
  end
end
