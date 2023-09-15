class User < ApplicationRecord
  # ------------------------------- Constants -------------------------------- #
  ROLES = {
    admin: "Administrator",
    developer: "Developer",
    customer: "Customer",
  }

  # --------------------------------- Devise --------------------------------- #
  devise :database_authenticatable,
    :registerable,
    :recoverable, 
    :rememberable, 
    :validatable

  # ------------------------------ Associations ------------------------------ #
  has_many :tickets, dependent: :destroy

  # ------------------------------ Validations ------------------------------- #
  validates :email, :roles, :name, presence: true

  # ----------------------------- SCOPES ----------------------------------- #
  scope :customers, -> { where "(roles->>'customer')::boolean is true" }

  # ---------------------------- Instance methods ---------------------------- #
  ROLES.keys.each do |role|
    define_method "is_#{role}?" do
      roles.with_indifferent_access[role]
    end
  end
end
