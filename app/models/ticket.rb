class Ticket < ApplicationRecord
  has_many :ticket_tags
  has_many :tags, through: :ticket_tags
  has_many :comments, dependent: :destroy
  
  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  STATUSES = [
    "new",
    "blocked",
    "in_progress",
    "fixed"
  ]

  validates :name, presence: true, uniqueness: true
  validates :status, inclusion: { in: STATUSES }
end
