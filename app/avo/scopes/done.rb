class Avo::Scopes::Done < Avo::Pro::Scopes::BaseScope
  self.name = "Done"
  self.description = "Done"
  self.scope = -> { query.done }
  self.visible = -> { true }
end
