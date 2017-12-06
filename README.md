# NeoGame
A Ruby game Framework - based on Gosu<br />

# What's NeoGame ?
NeoGame is a powerful Ruby game framework built on Gosu multimedia library. <br />
The framework make the game developpement easy, fast and robust. <br />
It's entierly writed in Ruby for Ruby ! <br />
<br />Pong sample :<br />
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

# Version
24 / 09 / 2017 :
Currently, NeoGame is in version 0.1 -> Early alpha

06 / 10 / 2017 :
NeoGame is in version 0.2 -> Early Alpha<br />
Changelog :
- Fixed square collision bug
- Added Audio class (for music and sound)
- Fixed bugs about Sprite and SpriteSheet class
- Sprite class is not extended anymore from Gosu::Image, but it has his own image
- Better flexibility (for Sprite and SpriteSheet)
- Sprite and SpriteSheet getPixel method return a Gosu::Color instance instead of a board
- Added circle shape, but not collision with yet...
- You can change the sprite color using the color attribute
- Refactored a bit the code

06 / 12 / 2016
Neogame is in version 0.2.1 -> Early alpha<br />
NOTE: This version is a minor update<br />
Changelog :
- Added getWidth and getHeight method for Text class
