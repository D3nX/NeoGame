require 'gosu'

# NeoGame
# The next gen Ruby game framework
# By D3nX, ©2017
module Neogame

	module System

		Vector2 = Struct.new(:a, :b)
		Vector3 = Struct.new(:a, :b, :c)
		Vector4 = Struct.new(:a, :b, :c, :d)

		Settings = Struct.new(
			:width,
			:height,
			:fullscreen,
			:title
		)

		class Input

			KB_LEFT = Gosu::KbLeft
			KB_RIGHT = Gosu::KbRight
			KB_UP = Gosu::KbUp
			KB_DOWN = Gosu::KbDown
			KB_SPACE = Gosu::KbSpace
			KB_ESCAPE = Gosu::KbEscape
			# Letters
			KB_A = Gosu::KB_A
			KB_B = Gosu::KB_B
			KB_C = Gosu::KB_C
			KB_D = Gosu::KB_D
			KB_E = Gosu::KB_E
			KB_F = Gosu::KB_F
			KB_G = Gosu::KB_G
			KB_H = Gosu::KB_H
			KB_I = Gosu::KB_I
			KB_J = Gosu::KB_J
			KB_K = Gosu::KB_K
			KB_L = Gosu::KB_L
			KB_M = Gosu::KB_M
			KB_N = Gosu::KB_N
			KB_O = Gosu::KB_O
			KB_P = Gosu::KB_P
			KB_Q = Gosu::KB_Q
			KB_R = Gosu::KB_R
			KB_S = Gosu::KB_S
			KB_T = Gosu::KB_T
			KB_U = Gosu::KB_U
			KB_V = Gosu::KB_V
			KB_W = Gosu::KB_W
			KB_X = Gosu::KB_X
			KB_Y = Gosu::KB_Y
			KB_Z = Gosu::KB_Z
			# Number
			KB_NUMPAD_0 = Gosu::KB_NUMPAD_0
			KB_NUMPAD_1 = Gosu::KB_NUMPAD_1
			KB_NUMPAD_2 = Gosu::KB_NUMPAD_2
			KB_NUMPAD_3 = Gosu::KB_NUMPAD_3
			KB_NUMPAD_4 = Gosu::KB_NUMPAD_4
			KB_NUMPAD_5 = Gosu::KB_NUMPAD_5
			KB_NUMPAD_6 = Gosu::KB_NUMPAD_6
			KB_NUMPAD_7 = Gosu::KB_NUMPAD_7
			KB_NUMPAD_8 = Gosu::KB_NUMPAD_8
			KB_NUMPAD_9 = Gosu::KB_NUMPAD_9
			# Mouse
			MS_LEFT = Gosu::MS_LEFT
			MS_RIGHT = Gosu::MS_RIGHT
			MS_MIDDLE = Gosu::MS_MIDDLE
			MS_WHEEL_UP = Gosu::MS_WHEEL_UP
			MS_WHEEL_DOWN = Gosu::MS_WHEEL_DOWN

			# Return if any key is down
			def self.isKeyDown(key)
				return true if Gosu::button_down?(key)

				return false
			end

		end

		module Shapes

			class Shape
				attr_accessor :x, :y, :width, :height
			end

			class Rectangle < Shape

				def initialize(x, y, width, height)
					@x = x
					@y = y

					@width = width
					@height = height
				end

				def collides?(rectangle)

					if !rectangle.is_a?(Shape)
						raise "NeoGame [ERROR]: This is not a shape."
					end

					points = [
										 [rectangle.x, rectangle.y],
										 [rectangle.x + rectangle.width, rectangle.y],
										 [rectangle.x + rectangle.width, rectangle.y + rectangle.height],
										 [rectangle.x, rectangle.y + rectangle.height]
									 ]

					if (@x > (rectangle.x + rectangle.width)) || ((@x + @width) < rectangle.x)
						return false
					end

					if (@y > (rectangle.y + rectangle.height)) || ((@y + @height) < rectangle.y)
						return false
					end

					return true

				end

				def draw
					Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::WHITE)
				end

			end

		end

	end

	module Graphics

		DEFAULT_FONT = Gosu.default_font_name

		class Window < Gosu::Window

			attr_accessor :settings

			def initialize(settings)
				# Send settings to the window
				super settings.width, settings.height, settings.fullscreen

				# And keep the settings for reading information
				@settings = settings

				# Set the title
				self.caption = settings.title.to_s

				# Here, the class variables
				@use_cursor = false
			end

			def start
				show
			end

			def update; end;

			def draw; end;

			def needs_cursor?
				@use_cursor
			end

			# Setter

			private

			def show
				super
			end

		end

		class Sprite < Gosu::Image

			attr_accessor :x, :y, :z, :speed
			attr_accessor :rotation, :scaleX, :scaleY
			attr_accessor :centerX, :centerY


			def initialize(path)
				super path

				@x = 0
				@y = 0
				@z = 0
				@speed = 0.0
				@rotation = 0.0
				@scaleX = 1.0
				@scaleY = 1.0
				@centerX = 0.0
				@centerY = 0.0
				@color = Gosu::Color::WHITE
			end

			def getPixel(x, y)

				@blob ||= self.to_blob
			  if x < 0 or x >= width or y < 0 or y >= height
		      "\0\0\0\0"
		    else
		      	tmp = @blob[(y * width + x) * 4, 4]

			    r = @blob[(y * width + x) * 4, 4][0].unpack("H*").first.to_i(16)
					g = @blob[(y * width + x) * 4, 4][1].unpack("H*").first.to_i(16)
					b = @blob[(y * width + x) * 4, 4][2].unpack("H*").first.to_i(16)
					a = @blob[(y * width + x) * 4, 4][3].unpack("H*").first.to_i(16)

					color = [r,g,b,a]

					return color
				end

			end

			def draw(x = @x ,y = @y ,z = @z)

				# Update
				update()

				draw_rot(x, y, z, @rotation, @centerX / width, @centerY / height, @scaleX, @scaleY, @color)

			end

			private

			def update
				@centerX = @centerX.to_f
				@centerY = @centerY.to_f

				@scaleX = @scaleX.to_f
				@scaleY = @scaleY.to_f

				@rotation = @rotation.to_f

				@speed = @speed.to_f
			end

		end

		class SpriteSheet

			attr_accessor :anim_time
			attr_accessor :x, :y, :z, :speed
			attr_accessor :width, :height
			attr_accessor :rotation, :scaleX, :scaleY
			attr_accessor :centerX, :centerY

			def initialize(path, width, height)

				@anim = Gosu::Image.load_tiles(path, width, height)

				@anim_time = 1.0

				@nowAnim = 0

				@stop = false

				@startTime = Gosu.milliseconds
				@time = @startTime.to_f

				@isMirrorX = false
				@isMirrorY = false

				@x = 0
				@y = 0
				@z = 0
				@width = width
				@height = height
				@speed = 0.0
				@rotation = 0.0
				@scaleX = 1.0
				@scaleY = 1.0
				@centerX = 0.0
				@centerY = 0.0
				@color = Gosu::Color::WHITE
			end

			def  draw(x = @x ,y = @y ,z = @z)
				# Update
				update() if !@stop


				if @isMirrorY
					@centerY = @centerY
				end

				# Draw
				@anim[@nowAnim].draw_rot(x,
																 y,
																 z,
																 @rotation,
																 (@isMirrorX) ? (@width-@centerX) / width : @centerX / width,
																 (@isMirrorY) ? (@width-@centerY) / height : @centerY / height,
																 (@isMirrorX) ? -@scaleX : @scaleX,
																 (@isMirrorY) ? -@scaleY : @scaleY, @color)
			end

			def stop
				@stop = true
			end

			def start
				@stop = false
			end

			def setFrame(frame)
				frame = 0 if frame > @anim.size
				@nowAnim = frame
			end

			def setMirrorX(bool)
				@isMirrorX = bool
			end

			def setMirrorY(bool)
				@isMirrorY = bool
			end

			def getPixel(frame, x, y)

				@blob ||= @anim[frame].to_blob
				if x < 0 or x >= width or y < 0 or y >= height
					"\0\0\0\0"
				else
					tmp = @blob[(y * width + x) * 4, 4]

					r = @blob[(y * width + x) * 4, 4][0].unpack("H*").first.to_i(16)
					g = @blob[(y * width + x) * 4, 4][1].unpack("H*").first.to_i(16)
					b = @blob[(y * width + x) * 4, 4][2].unpack("H*").first.to_i(16)
					a = @blob[(y * width + x) * 4, 4][3].unpack("H*").first.to_i(16)

					color = [r,g,b,a]

					return color
				end

			end

			private

			def update
				@time = Gosu.milliseconds - @startTime

				if @time >= (@anim_time * 1000)
					@startTime = Gosu.milliseconds
					@time = 0.0

					@nowAnim += 1

					@nowAnim = 0 if @nowAnim == @anim.size
				end

			end

		end

		class Text

			attr_accessor :text
			attr_accessor :x, :y, :z
			attr_accessor :scaleX, :scaleY
			attr_accessor :color

			def initialize(window, font, size)

				if font != DEFAULT_FONT
					if font[0] != "." && font[1] != "/"
						font = ("./" + font).to_s
					end
				end

				@font = Gosu::Font.new(window, font, size)
				@color = Gosu::Color::WHITE

				@scaleX = 1.0
				@scaleY = 1.0

				@x = 0
				@y = 0
				@z = 0

				@text = ""

			end

			def draw(text = @text, x = @x, y = @y, z = @z, scaleX = @scaleX, scaleY = @scaleY, color = @color)
				@font.draw(text, x, y, z, scaleX, scaleY, color)
			end

		end

		class Camera

			attr_accessor :x, :y
			attr_accessor :scaleX, :scaleY
			attr_accessor :rotation
			attr_accessor :speed

			def initialize

				@x = 0
				@y = 0

				@scaleX = 1.0
				@scaleY = 1.0

				@centerX = 0.0
				@centerY = 0.0

				@speed = 0.0

				@rotation = 0.0
			end

			def render

				Gosu.scale(@scaleX, @scaleY, @centerX, @centerY) do
					Gosu.translate(@x, @y) do
						Gosu.rotate(@rotation, @centerX, @centerY) do
							yield
						end
					end
				end

			end

		end

	end

	module Audio

		class Music

			def initialize(path)

			end

			def play

			end

			def stop

			end

			def pause

			end

			def resume

			end

		end


		class Sound

			def initialize(path)

			end

			def play

			end

			def stop

			end

			def pause

			end

			def resume

			end

		end

	end

end
