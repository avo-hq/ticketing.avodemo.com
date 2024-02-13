class Avo::Scopes::LowPriority < Avo::Advanced::Scopes::BaseScope
  self.name = "Low priority"
  self.description = "Low priority"
  self.scope = -> { query.low }
  self.visible = -> { true }
end
