class Game < ApplicationRecord
    has_many :boards
    has_many :players
    has_many :pieces, through: :players
    has_many :moves, through: :pieces
    has_many :squares, through: :boards
    after_create :generate_game

    def shobu_matrix
        [
            [
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
            ],
            [
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
            ],
            [
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
            ],
            [
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
                [nil, nil, nil, nil],
            ],
        ]
    end

    def generate_current_board
        current_board = self.shobu_matrix
        self.pieces.each do |piece|
            if !piece.dead?
                coords = piece.current_square.coordinates.split('')
                current_board[piece.current_square.board.quadrant][coords[0].to_i][coords[1].to_i]=piece.id
            end
        end
        self.update_attributes(current_board_json: current_board.to_json)
        return current_board
    end

    def dead_square
        self.squares.find_by(dead_square:true)
    end

    def generate_game
        GameGenerator.generate_game(self)
    end
end
  