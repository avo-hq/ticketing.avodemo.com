class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :roles, :name, presence: true

  [:admin, :manager].each do |role|
    define_method "is_#{role}?" do
      roles.with_indifferent_access[role]
    end
  end
end
