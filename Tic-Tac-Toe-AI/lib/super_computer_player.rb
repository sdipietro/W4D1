require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark) #game is a board instance?
    @node = TicTacToeNode.new(game.board, mark) #CHANGED HERE game to game.board
    non_losing_nodes = []
    @node.children.each do |child_node| #this is getting an error due to the @rows getter method
      non_losing_nodes << child_node if !child_node.losing_node?(mark) && !child_node.winning_node?(mark)
      return child_node.prev_move_pos if child_node.winning_node?(mark)
    end
    if non_losing_nodes.empty?
      raise puts "all your node choices are losing nodes"
    else
      non_losing_nodes.sample.prev_move_pos
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
