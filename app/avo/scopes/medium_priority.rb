class Avo::Scopes::MediumPriority < Avo::Advanced::Scopes::BaseScope
  self.name = "Medium priority"
  self.description = "Medium priority"
  self.scope = -> { query.medium }
  self.visible = -> { true }
end
