class Avo::Scopes::Closed < Avo::Advanced::Scopes::BaseScope
  self.name = "Closed"
  self.description = "Closed"
  self.scope = -> { query.closed }
  self.visible = -> { true }
end
