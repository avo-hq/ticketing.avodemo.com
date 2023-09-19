class Avo::Resources::User < Avo::BaseResource
  self.includes = [:tickets]
  self.record_selector = false
  self.search = {
    query: -> { query.ransack(name_cont: params[:q], email_cont: params[:q]).result(distinct: false) }
  }

  def fields
    with_options as: :text, link_to_record: true, filterable: true, sortable: true do
      field :name
      field :email
    end
    field :roles, as: :boolean_group, options: User::ROLES, only_on: :forms

    field :roles, as: :tags do
      record.roles.map do |role, active|
        role if active
      end.compact
    end

    sidebar do
      field :settings, as: :code, format_using: -> { JSON.pretty_generate(value) }, only_on: :show
    end
    
    field :tickets, as: :has_many, show_on: :edit, discreet_pagination: true
  end
end
