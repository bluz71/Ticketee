class Comment < ActiveRecord::Base
  belongs_to :state
  belongs_to :ticket
  belongs_to :author, class_name: "User"

  validates :text, presence: true

  scope :persisted, lambda { where.not(id: nil) }
  
  delegate :project, to: :ticket

  after_create :set_ticket_state

  private

    def set_ticket_state
      ticket.state = state
      ticket.save!
    end
end
