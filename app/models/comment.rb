class Comment < ApplicationRecord
  # ------------------------------ Associations ------------------------------ #
  belongs_to :user
  belongs_to :ticket
 
  # ------------------------------ Validations ------------------------------- #
  validates :user, :ticket, :content, presence: true

  # ------------------------------- Callbacks -------------------------------- #
  after_create :broadcast

  # ---------------------------- Instance methods ---------------------------- #
  def broadcast
    broadcast_append_to(
      "ticket_comments",
      target: "#{ActionView::RecordIdentifier.dom_id ticket}_comments",
      partial: "avo/resource_tools/comment",
      comment: self,
    )
  end
end
