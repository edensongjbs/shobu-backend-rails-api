class Piece < ApplicationRecord
    belongs_to :player
    has_many :moves
end
  