class TicTacToe
    attr_accessor :board
    WIN_COMBINATIONS = [
        [0, 1, 2], #Top Row
        [3, 4, 5], #Middle Row
        [6, 7, 8], #Bottom Row
        [0, 3, 6], #Left Column
        [1, 4, 7], #Middle Column
        [2, 5, 8], #Right Column
        [0, 4, 8], #Top Left to Bottom Right Diagonal
        [2, 4, 6] #Top Right to Bottom Left Diagonal
    ]
    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "------------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "------------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        self.board[index] = token
    end

    def position_taken?(position)
        self.board[position] != " "
    end

    def valid_move?(position)
        !position_taken?(position) && (0..8).to_a.include?(position)
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        self.turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        input = gets
        token = self.current_player
        index = self.input_to_index(input)
        if valid_move?(index)
            self.move(index, token)
            self.display_board
        else 
            self.turn 
        end       
    end

    def won?
        WIN_COMBINATIONS.each do |combination|
            board_combination = combination.map {|index| @board[index]}

            if board_combination.include?(" ") || board_combination.uniq.size != 1
                next
            else 
                return combination
            end
        end
        false
    end

    #If there have been 9 turns, game is full
    def full?
        self.turn_count == 9
    end

    #If self.won is false or the game isn't full, return false
    def draw?
        !(self.won? || !self.full?)
    end

    def over?
        self.draw? || self.won?
    end 

    def winner
        #Since X goes first, X only wins if X took more turns 
        if self.won?
            @board.count {|token| token == "X"} > @board.count {|token| token == "O"} ? "X" : "O"
        else 
            nil
        end
    end

    def play 
        while !self.over?
            self.turn 
        end
        #puts must be in parentheses here, not sure why
        self.won? ? puts("Congratulations #{self.winner}!") : puts("Cat's Game!")
    end

end

# game1 = TicTacToe.new
# game1.play


# game1.board[0] = "X"
# puts game1.position_taken?(0)

# game = TicTacToe.new
# game.board = ["X", "O", "X", "O", "X", "O", "O", "X", "X"]

# print game.board
# puts ""
# puts game.play
# puts ""
# game.won?
