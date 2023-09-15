class Avo::Resources::User < Avo::BaseResource
  self.includes = [:tickets]
  self.record_selector = false

  def fields
    field :name, as: :text
    field :email, as: :text
    field :roles, as: :boolean_group, options: User::ROLES, only_on: :forms
    field :roles, as: :tags do
      record.roles.map do |role, active|
        role if active
      end.compact
    end
    field :tickets, as: :has_many, show_on: :edit, discreet_pagination: true
  end
end
