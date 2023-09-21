class Avo::Scopes::HighPriority < Avo::Pro::Scopes::BaseScope
  self.name = "High priority"
  self.description = "High priority"
  self.scope = -> { query.high }
  self.visible = -> { true }
end
