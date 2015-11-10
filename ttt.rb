#initialize board
def initialize_board
	board = {}
	(1..9).each { |position| board[position] = ' ' }
	board
end

#draw board
def draw_board(board)
	system 'clear'
	puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
	puts "-----------------"
	puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
	puts "-----------------"
	puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
end

#show empty positions

def empty_positions(board)
	board.keys.select { |position| board[position] == ' ' }
end

def player_picks_square(board)
	begin
		puts 'Pick a square: 1-9:'
		position = gets.chomp.to_i
	end until empty_positions(board).include?(position)
	board[position] = 'X'
end

def computer_picks_square(board)
	defend_this_square = nil
	position = nil
	WINNING_LINES.each do |l|
		defend_this_square = two_in_a_row({l[0] => board[l[0]], l[1] => board[l[1]], l[2] => board[l[2]]} )
		if defend_this_square
			position = defend_this_square
			break
		end
	end
	position = empty_positions(board).sample unless defend_this_square
	board[position] = 'O'
end

def check_winner(board)
	WINNING_LINES.each do |line|
		return 'Player' if board.values_at(*line).count('X') == 3
		return 'Computer' if board.values_at(*line).count('O') == 3
	end
	nil
end

def two_in_a_row(board)
	return false unless board.values.count('X') == 2
	empty_positions(board).first
end

def announce_winner(winner)
	puts "#{winner} is the winner"
end

def nine_positions_are_filled?(board)
	empty_positions(board).empty?
end

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

board = initialize_board
draw_board(board)
begin
	player_picks_square(board)
	two_in_a_row(board)
	draw_board(board)
	winner = check_winner(board)
	
	computer_picks_square(board)
	draw_board(board)
	winner = check_winner(board)
end until winner || nine_positions_are_filled?(board)

if winner
	announce_winner(winner)
else
	puts "It's a tie"
end