# == Schema Information
#
# Table name: tickets
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  status      :integer
#  priority    :integer
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Ticket < ApplicationRecord
  # --------------------------------- Enums ---------------------------------- #
  enum :status, { open: 0, in_progress: 1, closed: 2, done: 3 }
  enum :priority, { high: 0, medium: 1, low: 2 }

  # ------------------------------ Ransackable ------------------------------ #
  def self.ransackable_attributes(auth_object = nil)
    %w(title)
  end

  # ------------------------------ Associations ------------------------------ #
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  # ------------------------------ Validations ------------------------------- #
  validates :title, :user, presence: true
end
