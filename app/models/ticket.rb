class Ticket < ApplicationRecord
  # --------------------------------- Enums ---------------------------------- #
  enum status: { open: 0, in_progress: 1, closed: 2, done: 3 }
  enum priority: { high: 0, medium: 1, low: 2 }

  # ------------------------------ Associations ------------------------------ #
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  # ------------------------------ Validations ------------------------------- #
  validates :title, :user, presence: true
end
