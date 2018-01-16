# For neogame 0.3

require "./neogame.rb" # We import Neogame

include Neogame # We include it

# We define a global variable "$window" to access the window attributes
$window = nil

# Now, we create the window
class Game < Window

	def initialize
		super Settings.new(640, 480, false, "Game states example") # We send the properties in order to create the window
		$window = self # Define the window as self
		# And here, we define the game states
		StateManager.initialize(self.input) # Initialize the state manager first send our input object
		StateManager.add_state(:state1, State1.new()) # We add the "State1" game state
		StateManager.add_state(:state2, State2.new()) # We add the "State2" game state
		StateManager.set_state(:state1) # And we set current state to "state1"
	end

	def update
		StateManager.update() # Update the current state
	end

	def draw
		StateManager.draw() # Draw the current state
	end

end

# Here the "State1"
class State1 < GameState

	def initialize
		# We define a text object for know where are we : in "state1" or "state2" ?
		@text = Text.new($window, Text::DEFAULT_FONT, 25)
		@text.text = "Here is \"State1\". Type enter to go in game state \"State2\""
		@text.x = ($window.width - @text.get_width()) / 2
		@text.y = ($window.height - @text.get_height()) / 2
	end

	def update(input)
		# We define that if the user press the return key, it change game state
		StateManager.set_state(:state2) if input.key_pressed?(Input::KB_RETURN)
	end

	def draw
		# Draw the text
		@text.draw
	end

	def reset
		# Here, put what you want
		# This function will be called every time you set the state to this state
	end

end

# And here the "State2"
class State2 < GameState

	def initialize
		# We define a text object for know where are we : in "state1" or "state2" ?
		@text = Text.new($window, Text::DEFAULT_FONT, 25)
		@text.text = "Here is \"State2\". Type enter to go in game state \"State1\""
		@text.x = ($window.width - @text.get_width()) / 2
		@text.y = ($window.height - @text.get_height()) / 2
	end

	def update(input)
		# We define that if the user press the return key, it change game state
		StateManager.set_state(:state1) if input.key_pressed?(Input::KB_RETURN)
	end

	def draw
		# Draw the text
		@text.draw()
	end

	def reset
		# Here, put what you want
		# This function will be called every time you set the state to this state
	end

end

Game.new.start