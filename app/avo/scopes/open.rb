class Avo::Scopes::Open < Avo::Advanced::Scopes::BaseScope
  self.name = "Open"
  self.description = "Open"
  self.scope = -> { query.open }
  self.visible = -> { true }
end
