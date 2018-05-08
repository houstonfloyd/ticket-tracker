class Comment < ApplicationRecord

  belongs_to :ticket
  belongs_to :creator, class_name: "User"

  validates :body, length: {minimum: 5}
end
