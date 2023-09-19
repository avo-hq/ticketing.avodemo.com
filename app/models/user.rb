# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string           default(""), not null
#  roles                  :json             not null
#  settings               :json             not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
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

  # ------------------------------ Ransackable ------------------------------ #
  def self.ransackable_attributes(auth_object = nil)
    %w(name email)
  end

  # ------------------------------ Associations ------------------------------ #
  has_many :tickets, dependent: :destroy
  has_many :comments, dependent: :destroy

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
