class Avo::Scopes::Closed < Avo::Scopes::BaseScope
  self.name = "Closed"
  self.description = "Closed"
  self.scope = -> { query.closed }
  self.visible = -> { true }
end
