# NeoGame
A Ruby game Framework - based on Gosu<br />

# What's NeoGame ?
NeoGame is a (not yet) powerful Ruby game framework built on Gosu multimedia library. <br />
The framework make the game developpement easy, fast and robust. <br />
It's entierly writed in Ruby for Ruby ! <br />
<br />Pong sample (Neogame 0.2) :<br />
![alt text](https://github.com/D3nX/NeoGame/blob/master/pong_screenshot.png)

# Cool ! But how I use it ?
How to use it ? No more simple, Just go on https://niobean-generation.000webhostapp.com/tutorials.html -> Tutorials ! <br />
You l'ill discover all about the game library : <br />

The basics :
- Create a window
- Draw a image
- ...

And the API :
- Make collision
- Manipulate audio
- ... 

Briefly, you l'ill discover all you need to make a powerful game using the Ruby programming language.

# What look like NeoGame ?

For creating a sample window in example, NeoGame look like this :

```ruby
# Neogame 0.3 - Sample Window

require "./neogame.rb" # We import Neogame

include Neogame # We include it

# We define a global variable "$window" to access the window attributes
$window = nil

# Now, we create the window
class Game < Window

	def initialize
		super Settings.new(640, 480, false, "Sample window") # We send the properties in order to create the window
		$window = self # Define the window as self
	end

	def update
		# Game logic here
	end

	def draw
		# Render everything here
	end

end

Game.new.run
```

# Changelogs
## 24 / 09 / 2017 :
Currently, NeoGame is in version 0.1 -> Early alpha

## 06 / 10 / 2017 :
NeoGame is in version 0.2 -> Early Alpha<br />
Changelog :
- Fixed square collision bug
- Added Audio class (for music and sound)
- Fixed bugs about Sprite and SpriteSheet class
- Sprite class is not extended anymore from Gosu::Image, but it has his own image
- Better flexibility (for Sprite and SpriteSheet)
- Sprite and SpriteSheet getPixel method return a Gosu::Color instance instead of an array
- Added circle shape, but not collision with yet...
- You can change the sprite color using the color attribute
- Refactored a bit the code

## 06 / 12 / 2017
Neogame is in version 0.2.1 -> Early alpha<br />
NOTE: This version is a minor update<br />
Changelog :
- Added getWidth and getHeight method for Text class

## 16 / 01 / 2018
Neogame is in version 0.3 -> Early alpha<br />
NOTE: This version is a MAJOR update<br />
Changelog :
- Converted all the library to ruby convention
- Fixed Sprite class bugs
- Fixed SpriteSheet class bugs
- Fixed Media class bugs
- Added structure "Position"
- Added Input class
  - Added input methods for when key / mouse is down / pressed / released
- Deleted every module except Shapes and Neogame
- Added collision between rectangle and circle and between circle and circle
- Spritesheet attribute :anim_time has moved to :frame_time
- Camera class has now render, scale, rotate and record method
- Camera class has now a ":render_order" attribute (who is an array) for render method (for tell to Neogame what to do in order : scale ?, translate ?, ...)
- Added StateManager class for manage game state
- Added GameState class for use with state manager
- Added "options = {}" argument for sprite and spritesheet. These options are the same in Gosu when you create an image.
- Added some examples

## 03 / 07 / 2018
Neogame is in version 0.4 -> Early alpha<br />
NOTE: This version is a MAJOR update<br />
Changelog :
- Added path variable to Sprite & SpriteSheet class
- Added an ObjectsManager class
- Modified a bit the code of the "StateManager"
- "GameState" class name changed to "State"
- Added GUI::Button class
- Added GUI::Panel class
- Added GUI::ProgressBar class
- Text class 'get_width' and 'get_height' method are now 'width' & 'height'
- Added 'size' and 'position' getter & setter (used with Vector2) in GUI::Panel class
- For Input::mouse_down is now a static function
- For every movable object, added a "position" and "position=" method / accessor
- Now read image pixel is way faster
- "Position" struct deleted
- Neogame module now include all Gosu methods
- Added "resize" method to the window class
- Use "run" method instead of "start" to launch a new window
