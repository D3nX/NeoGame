# For neogame 0.3

require "./neogame.rb" # We import Neogame

include Neogame # We include it

# We define a global variable "$window" to access the window attributes
$window = nil

# Now, we create the window
class Game < Window

	def initialize
		super Settings.new(640, 480, false, "Sprite manipulation") # We send the properties in order to create the window
		$window = self # Define the window as self

		@sprite = Sprite.new("res/star.png") # We create a sprite
		# We set the sprite to center
		@sprite.x = (self.width - @sprite.width) / 2
		@sprite.y = (self.height - @sprite.height) / 2

		@image = Sprite.new("res/Lighthouse.jpg") # We load an image
		# We could make the image mirror
		@image.mirror_x = true
		@image.mirror_y = true

		@sprite_sheet = SpriteSheet.new("res/bird.png", 182, 117) # And why not a spritesheet ? (animation)
		@sprite_sheet.frame_time = 0.1 # The time to wait in second between each frame

		# Here is some variable for game logic
		@scale_up = true
	end

	def update
		# We could scale it
		if @scale_up
			@sprite.scale_x += 0.1
			@sprite.scale_y += 0.1
			if @sprite.scale_x >= 2.0 and @sprite.scale_y >= 2.0
				@scale_up = false
			end
		else
			@sprite.scale_x -= 0.1
			@sprite.scale_y -= 0.1
			if @sprite.scale_x < 0.1 and @sprite.scale_y < 0.1
				@scale_up = true
			end
		end

		# We can also rotate it with a specified center
		@sprite.center_x = @sprite.width / 2
		@sprite.center_y = @sprite.height / 2
		@sprite.angle += 5.0

		@sprite_sheet.color = (rand(2) == 1) ? Gosu::Color::BLUE : Gosu::Color::RED # Let set the sprite sheet to a random color (red or blue)
	end

	def draw
		@image.draw() # We draw the background
		@sprite.draw() # We draw the sprite
		@sprite_sheet.draw() # We draw the birdd
	end

end

Game.new.start
