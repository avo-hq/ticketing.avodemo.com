class Avo::Scopes::InProgress < Avo::Scopes::BaseScope
  self.name = "In progress"
  self.description = "In progress"
  self.scope = -> { query.in_progress }
  self.visible = -> { true }
end
