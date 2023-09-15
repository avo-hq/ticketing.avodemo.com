class Ticket < ApplicationRecord
  # --------------------------------- Enums ---------------------------------- #
  enum status: { open: 0, in_progress: 1, closed: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  # ------------------------------ Associations ------------------------------ #
  belongs_to :user
  
  # ------------------------------ Validations ------------------------------- #
  validates :title, :user, presence: true
end
