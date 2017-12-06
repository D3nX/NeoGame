require 'gosu'

# NeoGame
# The next gen Ruby game framework
# By D3nX, ©2017
# Version pre-alpha 0.2.1
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
			def self.isKeyDown?(key)
				return true if Gosu::button_down?(key)

				return false
			end

		end

		module Shapes

			class Shape
				attr_accessor :x, :y, :width, :height, :type
			end

			class Rectangle < Shape

				def initialize(x, y, width, height)
					@x = x
					@y = y
					@type = "Rectangle"

					@width = width
					@height = height
				end

				def collides?(shape)

					if !shape.is_a?(Shape)
						raise "NeoGame [ERROR]: This is not a shape."
					end

					if shape.width * shape.height > @width * @height

						if @x >= shape.x && @x <= shape.x + shape.width
							if @y >= shape.y && @y <= shape.y + shape.height
								return true
							end
						end

						if @x + @width >= shape.x && @x + @width<= shape.x + shape.width
							if @y >= shape.y && @y <= shape.y + shape.height
								return true
							end
						end

						if @x + @width >= shape.x && @x + @width <= shape.x + shape.width
							if @y + @height >= shape.y && @y + @height <= shape.y + shape.height
								return true
							end
						end

						if @x >= shape.x && @x <= shape.x + shape.width
							if @y + @height >= shape.y && @y + @height <= shape.y + shape.height
								return true
							end
						end

					else

						if shape.x >= @x && shape.x <= @x + @width
							if shape.y >= @y && shape.y <= @y + @height
								return true
							end
						end

						if shape.x  + shape.width >= @x && shape.x + shape.width <= @x + @width
							if shape.y >= @y && shape.y <= @y + @height
								return true
							end
						end

						if shape.x + shape.width >= @x && shape.x + shape.width <= @x + @width
							if shape.y + shape.height >= @y && shape.y + shape.height <= @y + @height
								return true
							end
						end

						if shape.x >= @x && shape.x <= @x + @width
							if shape.y + shape.height >= @y && shape.y + shape.height <= @y + @height
								return true
							end
						end

						return false

					end

					return false

				end

				def draw
					Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::WHITE)
				end

			end

			class Circle < Shape

				attr_accessor :radius

				def initialize(x, y, radius)
					@x = x
					@y = y
					@type = "Circle"
					@radius = radius

					@points = []

					resize(radius)
				end

				def draw
					@points.each do |points|
						x = @x + points.a
						y = @y + points.b
						Gosu.draw_line(x,y, Gosu::Color::WHITE, x+1, y + 1, Gosu::Color::WHITE, 0)
					end
				end

				def resize(radius)

					@radius = radius
					@points = []

					for i in 0...(360 * (radius / 10))

						lengthX = Math.cos(i * 3.14 / 180) * radius;
						lengthY = Math.sin(i * 3.14 / 180) * radius;

						@points << Vector2.new(x + lengthX, y + lengthY)

					end

				end

				def collides?(shape)
					if !shape.is_a?(Shape)
						raise "NeoGame [ERROR]: This is not a shape."
					end


				end

			end

		end

		class TiledMap

			def initialize(path)

			end

			def draw(layer = nil)
				if layer == nil
					# Draw everything
				else
					# Draw specified layer
				end
			end

			# Getter
			def getWidth

			end

			def getWidthInPixel

			end

			def getHeight

			end

			def getHeightInPixel

			end

		end

	end

	module Graphics

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

				# And here a special variable, that he is himself
				@@window = self
			end

			def start
				show
			end

			def update; end;

			def draw; end;

			def needs_cursor?
				@use_cursor
			end

			def self.window
				return @@window
			end

			# Setter

			private

			def show
				super
			end

		end

		class Sprite

			attr_accessor :x, :y, :z, :speed
			attr_accessor :width, :height
			attr_accessor :angle, :scaleX, :scaleY
			attr_accessor :centerX, :centerY
			attr_accessor :isMirrorX, :isMirrorY

			def initialize(path)

				@img = Gosu::Image.new(path)

				@width = @img.width
				@height = @img.height
				@x = 0
				@y = 0
				@z = 0
				@speed = 0.0
				@angle = 0.0
				@scaleX = 1.0
				@scaleY = 1.0
				@centerX = 0.0
				@centerY = 0.0
				@color = Gosu::Color::WHITE
			end

			def getPixel(x, y)

				width = @img.width
				height = @img.height

				@blob ||= @img.to_blob
				if x < 0 or x >= width or y < 0 or y >= height
					return nil
				else
					tmp = @blob[(y * width + x) * 4, 4]

					r = @blob[(y * width + x) * 4, 4][0].unpack("H*").first.to_i(16)
					g = @blob[(y * width + x) * 4, 4][1].unpack("H*").first.to_i(16)
					b = @blob[(y * width + x) * 4, 4][2].unpack("H*").first.to_i(16)
					a = @blob[(y * width + x) * 4, 4][3].unpack("H*").first.to_i(16)

					return Gosu::Color.new(a, r, g, b)
				end

			end

			def draw(x = @x ,y = @y ,z = @z)

				# Update
				update()

				@img.draw_rot(x, y, z,
											@angle,
											(@isMirrorX) ? (@width-@centerX) / @width : @centerX / @width,
											(@isMirrorY) ? (@height-@centerY) / @height : @centerY / @height,
											(@isMirrorX) ? -@scaleX : @scaleX,
											(@isMirrorY) ? -@scaleY : @scaleY, @color)

			end

			private

			def update
				@centerX = (@centerX * @scaleX).to_f
				@centerY = (@centerY * @scaleY).to_f

				@scaleX = @scaleX.to_f
				@scaleY = @scaleY.to_f

				@angle = @angle.to_f

				@speed = @speed.to_f

				@width = @img.width * @scaleX
				@height = @img.height * @scaleY
			end

		end

		class SpriteSheet

			attr_accessor :anim_time
			attr_accessor :x, :y, :z, :speed
			attr_accessor :width, :height
			attr_accessor :angle, :scaleX, :scaleY
			attr_accessor :centerX, :centerY
			attr_accessor :isMirrorX, :isMirrorY

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
				@angle = 0.0
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
																 @angle,
																 (@isMirrorX) ? (@width-@centerX) / @width : @centerX / @width,
																 (@isMirrorY) ? (@height-@centerY) / @height : @centerY / @height,
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

			def getPixel(x, y, frame = @nowAnim)

				width = @anim[frame].width
				height = @anim[frame].height

				@blob ||= @anim[frame].to_blob
				if x < 0 or x >= width or y < 0 or y >= height
					return nil
				else
					tmp = @blob[(y * width + x) * 4, 4]

					r = @blob[(y * width + x) * 4, 4][0].unpack("H*").first.to_i(16)
					g = @blob[(y * width + x) * 4, 4][1].unpack("H*").first.to_i(16)
					b = @blob[(y * width + x) * 4, 4][2].unpack("H*").first.to_i(16)
					a = @blob[(y * width + x) * 4, 4][3].unpack("H*").first.to_i(16)

					return Gosu::Color.new(a, r, g, b)

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

			DEFAULT_FONT = Gosu.default_font_name

			attr_accessor :text
			attr_accessor :x, :y, :z
			attr_accessor :scaleX, :scaleY
			attr_accessor :angle, :centerX, :centerY
			attr_accessor :color

			def initialize(font, size)

				if font != DEFAULT_FONT
					if font[0] != "." && font[1] != "/"
						font = ("./" + font).to_s
					end
				end

				@font = Gosu::Font.new(Window.window, font, size)
				@color = Gosu::Color::WHITE

				@scaleX = 1.0
				@scaleY = 1.0

				@x = 0
				@y = 0
				@z = 0

				@text = ""

				@angle = 0.0
				@centerX = 0.0
				@centerY = 0.0

			end

			def draw(text = @text, x = @x, y = @y, z = @z, scaleX = @scaleX, scaleY = @scaleY, color = @color)
				Gosu.rotate(@angle, @centerX, @centerY) do
					@font.draw(text, x, y, z, scaleX, scaleY, color)
				end
			end

			def getWidth(text = @text, scaleX = @scaleX)
				return @font.text_width(text, scaleX)
			end

			def getHeight
				return @font.height
			end

		end

		class Camera

			attr_accessor :x, :y
			attr_accessor :scaleX, :scaleY
			attr_accessor :angle
			attr_accessor :speed

			def initialize

				@x = 0
				@y = 0

				@scaleX = 1.0
				@scaleY = 1.0

				@centerX = 0.0
				@centerY = 0.0

				@speed = 0.0

				@angle = 0.0
			end

			def render

				Gosu.scale(@scaleX, @scaleY, @centerX, @centerY) do
					Gosu.translate(@x, @y) do
						Gosu.rotate(@angle, @centerX, @centerY) do
							yield
						end
					end
				end

			end

		end

	end

	module Audio

		class Media

			attr_reader :looping, :volume, :speed, :panning

			def initialize(path)

				@sample = Gosu::Sample.new(path)
				@sampleInstance = nil

				@looping = false
				@volume = 1.0
				@speed = 1.0
				@panning = 1.0

				@playing = false

			end

			def play(looping = false, volume = 1.0, speed = 1.0, panning = 1.0)

				raise "NeoGame [ERROR]: The media is already playing." if @sampleInstance != nil

				@looping = looping
				@volume = volume
				@speed = speed
				@panning = panning

				@sampleInstance = @sample.play_pan(panning, volume, speed, looping)

				@playing = true
			end

			def stop

				raise "NeoGame [ERROR]: The media is already stopped." if @sampleInstance == nil

				@sampleInstance.stop
				@sampleInstance = nil

				@playing = false

			end

			def pause

				raise "NeoGame [ERROR]: Cannot pause if it was stopped or not started." if @sampleInstance == nil

				@sampleInstance.pause

			end

			def resume

				raise "NeoGame [ERROR]: Cannot resume if it was stopped or not started." if @sampleInstance == nil

				@sampleInstance.resume

			end

			def isPlaying?

				@playing = @sampleInstance.playing? if @sampleInstance != nil

				return @playing

			end

			def isPaused?

				raise "NeoGame [ERROR]: Cannot return if the media is paused if it was stopped or not played." if @sampleInstance == nil

				return @sampleInstance.paused?

			end

		end

	end

end
