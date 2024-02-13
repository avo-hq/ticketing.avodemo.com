class TicketPolicy < ApplicationPolicy
  [:index, :show].each do |action|
    define_method("#{action}?") do
      true
    end
  end

  [:new, :create, :edit, :update, :destroy, :act_on].each do |action|
    define_method("#{action}?") do
      user.is_admin?
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
