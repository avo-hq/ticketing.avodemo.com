class Avo::Scopes::LowPriority < Avo::Pro::Scopes::BaseScope
  self.name = "Low priority"
  self.description = "Low priority"
  self.scope = -> { query.low }
  self.visible = -> { true }
end
