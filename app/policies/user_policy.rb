class UserPolicy < ApplicationPolicy
  [:index, :show].each do |action|
    define_method("#{action}?") do
      true
    end
  end

  [:new, :create, :edit, :update, :destroy, :create_tickets, :destroy_tickets, :edit_tickets].each do |action|
    define_method("#{action}?") do
      user.is_admin?
    end
  end

  def attach_tickets?
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
