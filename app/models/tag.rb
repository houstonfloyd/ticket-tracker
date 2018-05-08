class Tag < ApplicationRecord
  has_many :ticket_tags
  has_many :tickets, through: :ticket_tags

  scope :with_counts, -> {
    left_outer_joins(:ticket_tags).select("tags.*, COUNT(ticket_tags.id)").
      group("tags.id")
  }

  scope :alphabetical, -> { order("tags.name ASC") }

  validates :name, presence: true, uniqueness: true
end
