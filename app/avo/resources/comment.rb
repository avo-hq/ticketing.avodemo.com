class Avo::Resources::Comment < Avo::BaseResource
  self.includes = [:user, :ticket]

  def fields
    field :content, as: :textarea
    field :user, as: :belongs_to
    field :ticket, as: :belongs_to
  end
end
