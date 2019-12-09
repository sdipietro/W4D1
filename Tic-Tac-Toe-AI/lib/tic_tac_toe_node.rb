require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
      #base case
      if @board.over? 
        if @board.winner == evaluator || @board.winner.nil?
          return false
        elsif @board.winner != evaluator
          return true
        end
      end

      if @next_mover_mark == evaluator #player's turn        @assumption: next_mover_mark represents opponent's mark?
        self.children.all? { |node| node.losing_node?(evaluator) }
      elsif @next_mover_mark != evaluator #opponent's turn
        self.children.any? { |node| node.losing_node?(evaluator) }
      end
       
  end

  def winning_node?(evaluator)
    if @board.over? 
        if @board.winner == evaluator
          return true
        elsif @board.winner != evaluator || @board.winner.nil?
          return false
        end
      end

      if @next_mover_mark == evaluator #player's turn        @assumption: next_mover_mark represents opponent's mark?
        self.children.any? { |node| node.winning_node?(evaluator) }
      elsif @next_mover_mark != evaluator #opponent's turn
        self.children.all? { |node| node.winning_node?(evaluator) }
      end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []
    if @next_mover_mark == :x
      mover = :o
    else  
      mover = :x
    end
    @board.rows.each_with_index do |row, r_idx| 
      row.each_with_index do |col, c_idx|
        pos = [r_idx, c_idx]
        if @board.empty?(pos) 
          current_board = @board.dup
          current_board[pos] = @next_mover_mark
          @prev_move_pos = pos 
          arr << TicTacToeNode.new(current_board, mover, @prev_move_pos) #this line is executed nine times
        end
      end
    end
    arr
  end
  #[[X,nil,nil],
  # [O,nil,nil],
  # [nil,X,nil]]
end
