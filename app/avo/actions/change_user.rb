class Avo::Actions::ChangeUser < Avo::BaseAction
  self.name = "Change User"
  # self.visible = -> do
  #   true
  # end

  def fields
    field "user",
      as: :tags,
      mode: :select,
      close_on_select: true,
      fetch_values_from: -> { "/admin/resources/users/get_users" },
      stacked: true,
      suggestions: -> { User.all.map { |user| { label: user.name , value: user.id } } } 
  end

  def handle(query:, fields:, current_user:, resource:, **args)
    query.each do |record|
      record.update!(user_id: fields[:user])
    end
  end
end
