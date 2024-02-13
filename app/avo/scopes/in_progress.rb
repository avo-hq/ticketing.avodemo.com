class Avo::Scopes::InProgress < Avo::Advanced::Scopes::BaseScope
  self.name = "In progress"
  self.description = "In progress"
  self.scope = -> { query.in_progress }
  self.visible = -> { true }
end
