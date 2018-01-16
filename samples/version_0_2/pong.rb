# Compatible with NeoGame 0.2

require "./neogame.rb" # Import the library

# Include all library
include Neogame
include Neogame::Graphics
include Neogame::System
include Neogame::Audio

# Global score variable
$score = [0, 0]

# Initialize $game to nil before set it as an object
$game = nil

# Here, our game !
class Game < Window

  def initialize(settings) # Constructor who get settings

    super settings # Send settings to super class

    $game = self # Set the game equal to self for other classes can use it

    @use_cursor = true # Use the cursor

    @text = Text.new(Text::DEFAULT_FONT, 25) # Make a text object for drawing score
    @text.x = (settings.width - @text.getWidth) / 2 # Make text center (Font.gettext.getWidth)

    @ball = Ball.new # Make a ball object

    @padle = [] # Make an array of padle

    2.times { |i| @padle << Padle.new(i) } # Put two padle inside the array

  end

  def update # Update the game

    @text.text = "#{$score[0]} : #{$score[1]}" # Set the score text

    @ball.update # Update the ball

    @padle.each { |padle| padle.update(@ball) } # Update each padle

  end

  def draw # Draw everything about the game

    @ball.draw # Draw the ball

    @padle.each { |padle| padle.draw } # Draw each padle

    @text.draw # Draw the score

  end

end

# The padle
class Padle

  def initialize(isIa)

    @isIa = (isIa == 1) ? true : false # Set "isIa" as an instance variable

    if !@isIa
      @shape = Shapes::Rectangle.new(0, 0, 24, 128) # Make a new shape at x:0 and y:0 (for player)
    else
      @shape = Shapes::Rectangle.new($game.settings.width - 24,
                                     0,
                                     24,
                                     128) # Make a new shape at x:$game.settings.width - 24 and y:0 (for Ia)
    end

    @speed = 4.0 # Set the padle speed

  end

  def update(ball) # Get the ball for make collision

    if !@isIa # If this is the player, then you control the padle
      @shape.y += @speed if Input::isKeyDown?(Input::KB_DOWN) && @shape.y + @shape.height < $game.settings.height # Go down
      @shape.y -= @speed if Input::isKeyDown?(Input::KB_UP) && @shape.y > 0 # Go down
    else # Else, Ia control it
      @shape.y += @speed if ball.shape.y > @shape.y + @shape.height / 2 && @shape.y + @shape.height < $game.settings.height # Go down
      @shape.y -= @speed if ball.shape.y < @shape.y + @shape.height / 2 && @shape.y > 0 # Go down
    end

    # Check if ball collides with the padle
    ball.bounce(@shape)


  end

  def draw

    @shape.draw() # Draw the padle on the screen

  end

end

# The ball class
class Ball

  attr_accessor :shape, :collisionShape # Make collision shape and collisionShape public

  def initialize

    @shape = Shapes::Circle.new(0, 0, 25) # Make a circle
    @collisionShape = Shapes::Rectangle.new(0, 0, @shape.radius * 2, @shape.radius * 2) # Make a collision rectangle shape (because v0.2 doesn't support circle collision yet)

    # Set ball at center when start
    @shape.x = $game.settings.width / 2
    @shape.y = $game.settings.height / 2

    # Some variable
    @addX = rand(2) # If rand() == 1 -> true or if rand() == 0 -> false
    @addY = rand(2) # Same as upper

    @vspeed = 3.0 # Set the vertical speed
    @hspeed = 3.0 # Set the horizontal speed

  end

  def update

    # Here, we'll checking if ball bounce border

    # Right border
    if @shape.x - @shape.radius <= 0
      $score[1] += 1
      @addX = true

      setRandomSpeed()
    end

    # Left border
    if @shape.x + @shape.radius >= $game.settings.width
      $score[0] += 1
      @addX = false

      setRandomSpeed()
    end

    # Up border
    @addY = true if @shape.y - @shape.radius <= 0

    # Down border
    @addY = false if @shape.y + @shape.radius >= $game.settings.height

    # Now move him
    @shape.x = (@addX) ? @shape.x + @hspeed : @shape.x - @hspeed
    @shape.y = (@addY) ? @shape.y + @vspeed : @shape.y - @vspeed

    # Set the collision shape to the same position
    @collisionShape.x = @shape.x - @shape.radius
    @collisionShape.y = @shape.y - @shape.radius
  end

  def draw

    # Draw the ball
    @shape.draw()

  end

  def bounce(shape) # Bounce when needed
    if @collisionShape.collides?(shape)
      @addX = (@addX) ? false : true
      @addY = (@addY) ? false : true

      if @addX
        @shape.x = shape.x + shape.width + @shape.radius # Thats for Player padle -> for avoid the ball is locked inside the padle
      else
        @shape.x = shape.x - @shape.radius # Thats for Ia padle -> for avoid the ball is locked inside the padle
      end

      setRandomSpeed() # Set the speed random
    end

    # And a final case, if the ball is to fast and go out of the scene, reset it just behind the padle
    if @shape.x < 0 or @shape.x > $game.settings.width
      # Avoid the ball is locked inside the padle
      if !@addX
        @shape.x = shape.x + shape.width + @shape.radius
      else
        @shape.x = shape.x - @shape.radius
      end
    end 
  end

  # This method will set a random vertical and horizontal speed between 4 and 8 (included)
  def setRandomSpeed
    @vspeed = rand(4..8)
    @hspeed = rand(4..8)
  end

end

# ===============
# = LAUNCH ZONE =
# ===============

# Here, we'll launch game

settings = Settings.new(
  640,
  480,
  false,
  "NeoGame v0.2 - Pong"
)

$game = Game.new(settings) # Create the window and send settings to him
$game.start # Start the game !
