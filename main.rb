require 'pry-byebug'

class GameBoard
  attr_accessor :board, :pieces, :blank_block

  def initialize
    @board = create_board
    @blank_block = GamePiece.new(nil, nil, nil)
    @pieces = GamePieces.new
    place_pieces_to_start_game
    print_board
  end

  def create_number_array # looks good
    current_number = 8
    array = []
    8.times do
      array << current_number
      current_number -= 1
    end
    array
  end

  def create_board # looks good
    array = []
    countdown = create_number_array
    countdown.each do |row_num|
      row = []
      ('a'..'h').each do |column_num|
        row << Cell.new("#{row_num}-#{column_num}")
      end
      array << row
    end
    array
  end

  def place_pieces_to_start_game # looks good
    @board.each do |row|
      row.each do |cell|
        cell.current_piece = @blank_block
      end
    end
    place_black_pieces
    place_white_pieces
  end

  def place_black_pieces # looks good
    8.times do |num|
      board[0][num].current_piece = @pieces.game_pieces_black[num]
    end

    8.times do |num|
      board[1][num].current_piece = @pieces.game_pieces_black[num + 8]
    end
  end

  def place_white_pieces # looks good
    8.times do |num|
      board[6][num].current_piece = @pieces.game_pieces_white[num + 8]
    end

    8.times do |num|
      board[7][num].current_piece = @pieces.game_pieces_white[num]
    end
  end

  def print_board # looks good
    puts
    puts '                       |             |             |             |             |             |             |             |             |'
    puts '                       |      a      |      b      |      c      |      d      |      e      |      f      |      g      |      h      |'
    puts '               ________|_____________|_____________|_____________|_____________|_____________|_____________|_____________|_____________|________'
    row_index = 1
    @board.each do |row|
      5.times do |num|
        current_line = ''
        current_line << if num == 2
                          "                  #{row_index}    |"
                        elsif num == 4
                          '               ________|'
                        else
                          '                       |'
                        end
        current_line << "#{row[0].current_piece.block_to_print[num]}|"
        current_line << "#{row[1].current_piece.block_to_print[num]}|"
        current_line << "#{row[2].current_piece.block_to_print[num]}|"
        current_line << "#{row[3].current_piece.block_to_print[num]}|"
        current_line << "#{row[4].current_piece.block_to_print[num]}|"
        current_line << "#{row[5].current_piece.block_to_print[num]}|"
        current_line << "#{row[6].current_piece.block_to_print[num]}|"
        current_line << "#{row[7].current_piece.block_to_print[num]}|"
        if num == 2
          current_line << "    #{row_index}"
        elsif num == 4
          current_line << '________'
        end
        puts current_line
      end
      row_index += 1
    end
    puts '                       |             |             |             |             |             |             |             |             |'
    puts '                       |      a      |      b      |      c      |      d      |      e      |      f      |      g      |      h      |'
    puts '                       |             |             |             |             |             |             |             |             |'
    puts
  end
end

class Cell
  attr_accessor :position, :current_piece

  def initialize(position)
    @position = position
    @current_piece = nil
  end
end

class GamePieces
  attr_accessor :game_pieces_white, :game_pieces_black

  def initialize
    @game_pieces_white = create_game_pieces('White')
    @game_pieces_black = create_game_pieces('Black')
  end

  def create_game_pieces(colour)
    array = []
    array << GamePiece.new(colour, 'rook 1', 'Rook')
    array << GamePiece.new(colour, 'knight 1', 'Knight')
    array << GamePiece.new(colour, 'bishop 1', 'Bishop')
    array << GamePiece.new(colour, 'queen', 'Queen')
    array << GamePiece.new(colour, 'king', 'King')
    array << GamePiece.new(colour, 'bishop 2', 'Bishop')
    array << GamePiece.new(colour, 'knight 2', 'Knight')
    array << GamePiece.new(colour, 'rook 2', 'Rook')
    8.times do |num|
      current_id_of_piece = "pawn #{num + 1}"
      array << GamePiece.new(colour, current_id_of_piece, 'Pawn')
    end
    array
  end
end

class GamePiece
  attr_reader :colour, :id_of_piece, :name_of_piece, :number_of_moves, :block_to_print

  def initialize(colour, id_of_piece, name_of_piece)
    @colour = colour
    @id_of_piece = id_of_piece
    @name_of_piece = name_of_piece
    @number_of_moves = 0
    @block_to_print = panel_to_print(colour, name_of_piece)
  end

  def panel_to_print(colour, name_of_piece)
    panel = []
    case name_of_piece
    when 'King'
      panel << '             '
      panel << "    #{colour}    "
      panel << '             '
      panel << '    King     '
      panel << '_____________'
    when 'Queen'
      panel << '             '
      panel << "    #{colour}    "
      panel << '             '
      panel << '    Queen    '
      panel << '_____________'
    when 'Bishop'
      panel << '             '
      panel << "    #{colour}    "
      panel << '             '
      panel << '    Bishop   '
      panel << '_____________'
    when 'Knight'
      panel << '             '
      panel << "    #{colour}    "
      panel << '             '
      panel << '    Knight   '
      panel << '_____________'
    when 'Rook'
      panel << '             '
      panel << "    #{colour}    "
      panel << '             '
      panel << '    Rook     '
      panel << '_____________'
    when 'Pawn'
      panel << '             '
      panel << "    #{colour}    "
      panel << '             '
      panel << '    Pawn     '
      panel << '_____________'
    else
      panel << '             '
      panel << '             '
      panel << '             '
      panel << '             '
      panel << '_____________'
    end
  end
end

class Chess
  attr_reader :board

  def initialize
    @board = GameBoard.new
  end
end

if __FILE__ == $PROGRAM_NAME
  Chess.new
end
