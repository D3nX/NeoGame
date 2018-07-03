require 'gosu'

# NeoGame
# The next gen Ruby game framework
# By D3nX, ©2018
# Version pre-alpha 0.4
module Neogame
	include Gosu

	class Input

		KB_LEFT = Gosu::KbLeft
		KB_RIGHT = Gosu::KbRight
		KB_UP = Gosu::KbUp
		KB_DOWN = Gosu::KbDown
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
		# Other touch
		KB_ENTER = Gosu::KB_ENTER
		KB_RETURN = Gosu::KB_RETURN
		KB_ESCAPE = Gosu::KB_ESCAPE
		KB_BACKSPACE = Gosu::KB_BACKSPACE
		KB_SPACE = Gosu::KbSpace
		# Mouse
		MS_LEFT = Gosu::MS_LEFT
		MS_RIGHT = Gosu::MS_RIGHT
		MS_MIDDLE = Gosu::MS_MIDDLE
		MS_WHEEL_UP = Gosu::MS_WHEEL_UP
		MS_WHEEL_DOWN = Gosu::MS_WHEEL_DOWN

		def initialize
			@key_released = {}
			@key_pressed = {}

			@mouse_released = {}
			@mouse_pressed = {}

			@button_released = {}
			@button_pressed = {}
		end

		# Return if any key is down
		def self.key_down?(key)

			if key == MS_LEFT or key == MS_RIGHT or key == MS_MIDDLE or key == MS_WHEEL_UP or key == MS_WHEEL_DOWN
				raise "NeoGame [ERROR]: Waiting for a keyboard input, not mouse input."
			end

			return true if Gosu::button_down?(key)

			return false

		end

		def key_released?(key)

			if key == MS_LEFT or key == MS_RIGHT or key == MS_MIDDLE or key == MS_WHEEL_UP or key == MS_WHEEL_DOWN
				raise "NeoGame [ERROR]: Waiting for a keyboard input, not mouse input."
			end

			if !@key_released.include?(key)
				@key_released[key] = 0
			end

			@key_released[key] = 1 if Gosu::button_down?(key) and @key_released[key] == 0
			@key_released[key] = 2 if !Gosu::button_down?(key) and @key_released[key] == 1

			if @key_released[key] == 2
				return true
			end

			return false

		end

		def key_pressed?(key)

			if key == MS_LEFT or key == MS_RIGHT or key == MS_MIDDLE or key == MS_WHEEL_UP or key == MS_WHEEL_DOWN
				raise "NeoGame [ERROR]: Waiting for a keyboard input, not mouse input."
			end

			if !@key_pressed.include?(key)
				@key_pressed[key] = 0
			end

			@key_pressed[key] = 1 if Gosu::button_down?(key) and @key_pressed[key] == 0
			@key_pressed.delete(key) if !Gosu::button_down?(key) and @key_pressed[key] == 2

			if @key_pressed[key] == 1
				return true
			end

			return false

		end

		def self.mouse_down?(button)

			if button == MS_LEFT or button == MS_RIGHT or button == MS_MIDDLE or button == MS_WHEEL_UP or button == MS_WHEEL_DOWN
				return true if Gosu::button_down?(button)

				return false
			else
				raise "NeoGame [ERROR]: Waiting for a mouse input, not keyboard input."
			end

		end

		def mouse_released?(button)

			if button == MS_LEFT or button == MS_RIGHT or button == MS_MIDDLE or button == MS_WHEEL_UP or button == MS_WHEEL_DOWN

				if !@mouse_released.include?(button)
					@mouse_released[button] = 0
				end

				@mouse_released[button] = 1 if Gosu::button_down?(button) and @mouse_released[button] == 0
				@mouse_released[button] = 2 if !Gosu::button_down?(button) and @mouse_released[button] == 1

				if @mouse_released[button] == 2
					return true
				end

				return false

			else

				raise "NeoGame [ERROR]: Waiting for a mouse input, not keyboard input."

			end

		end

		def mouse_pressed?(button)

			if button == MS_LEFT or button == MS_RIGHT or button == MS_MIDDLE or button == MS_WHEEL_UP or button == MS_WHEEL_DOWN

				if !@mouse_pressed.include?(button)
					@mouse_pressed[button] = 0
				end

				@mouse_pressed[button] = 1 if Gosu::button_down?(button) and @mouse_pressed[button] == 0
				@mouse_pressed.delete(button) if !Gosu::button_down?(button) and @mouse_pressed[button] == 2

				if @mouse_pressed[button] == 1
					return true
				end

				return false

			else

				raise "NeoGame [ERROR]: Waiting for a mouse input, not keyboard input."

			end

		end

		def self.button_down?(button)
			return Gosu::button_down?(button)
		end

		def button_released?(button)

			if !@button_released.include?(button)
				@button_released[button] = 0
			end

			@button_released[button] = 1 if Gosu::button_down?(button) and @button_released[button] == 0
			@button_released[button] = 2 if !Gosu::button_down?(button) and @button_released[button] == 1

			if @button_released[button] == 2
				return true
			end

			return false

		end

		def button_pressed?(button)

			if !@button_pressed.include?(button)
				@button_pressed[button] = 0
			end

			@button_pressed[button] = 1 if Gosu::button_down?(button) and @button_pressed[button] == 0
			@button_pressed.delete(button) if !Gosu::button_down?(button) and @button_pressed[button] == 2

			if @button_pressed[button] == 1
				return true
			end

			return false

		end

		private

		def reset
			# KEY
			@key_released.each do |k, v|
				if v == 2
					@key_released.delete(k)
				end
			end

			@key_pressed.each do |k, v|
				if v == 1
					@key_pressed[k] = 2
				end
			end

			# MOUSE
			@mouse_released.each do |k, v|
				if v == 2
					@mouse_released.delete(k)
				end
			end

			@mouse_pressed.each do |k, v|
				if v == 1
					@mouse_pressed[k] = 2
				end
			end

			# BUTTON
			@button_released.each do |k, v|
				if v == 2
					@button_released.delete(k)
				end
			end

			@button_pressed.each do |k, v|
				if v == 1
					@button_pressed[k] = 2
				end
			end
		end

	end

	module Shapes

		class Shape
			attr_accessor :x, :y, :width, :height, :type, :color
		end

		class Rectangle < Shape

			def initialize(x, y, width, height)
				@x = x
				@y = y
				@type = "Rectangle"

				@width = width
				@height = height

				@color = Gosu::Color::WHITE
			end

			def collides?(shape)

				if !shape.is_a?(Shape)
					raise "NeoGame [ERROR]: This is not a shape."
				end

				if shape.is_a? Rectangle

					if shape.x > @x + @width or
					   shape.y > @y + @height or
					   shape.x + shape.width < @x or
					   shape.y + shape.height < @y then
						return false
					else
						return true
					end

				else
					dist_x = (shape.x - @x - @width / 2).abs
					dist_y = (shape.y - @y - @height / 2).abs

					if (dist_x > (@width/2 + shape.radius))
						return false
    				end

    				if (dist_y > (@height/2 + shape.radius))
    					return false
    				end

    				if (dist_x <= (@width/2))
    					return true
    				end

				    if (dist_y <= (@height/2))
				    	return true
				    end

				    dx=dist_x-@width/2;
				    dy=dist_y-@height/2;
				    return (dx*dx+dy*dy<=(shape.radius**2))

				end

				return false

			end

			def draw
				Gosu.draw_rect(@x, @y, @width, @height, @color)
			end

		end

		class Circle < Shape

			attr_accessor :radius

			def initialize(x, y, radius)
				@x = x
				@y = y
				@type = "Circle"
				@radius = radius
				@color = Gosu::Color::WHITE

				@points = []
			end

			def draw

				for i in 0...360

					dx = Math.cos(i * Math::PI / 180) * @radius;
					dy = Math.sin(i * Math::PI / 180) * @radius;

					Gosu.draw_line(@x + dx,
	                			   @y + dy,
	               				   @color,
	    	           			   @x + dx + 1,
	                			   @y + dy + 1,
	                			   @color,
	                			   0)

				end

			end

			def resize(radius)
				@radius = radius
			end

			def collides?(shape)

				if !shape.is_a?(Shape)
					raise "NeoGame [ERROR]: This is not a shape."
				end

				if shape.is_a? Circle

					distance = (@x - shape.x)**2 + (@y - shape.y)**2

					if (distance < (shape.radius + @radius)**2)
						return true
					else
						return false
					end

				elsif shape.is_a? Rectangle

					dist_x = (@x - shape.x - shape.width / 2).abs
					dist_y = (@y - shape.y - shape.height / 2).abs

					if (dist_x > (shape.width/2 + @radius))
						return false
    				end

    				if (dist_y > (shape.height/2 + @radius))
    					return false
    				end

    				if (dist_x <= (shape.width/2))
    					return true
    				end

				    if (dist_y <= (shape.height/2))
				    	return true
				    end

				    dx=dist_x-shape.width/2;
				    dy=dist_y-shape.height/2;
				    return (dx*dx+dy*dy<=(@radius**2))

				end

				return false

			end

		end

	end

	class Window < Gosu::Window

		attr_accessor :settings

		private

		attr_accessor :game_input
		attr_accessor :use_cursor

		public

		def initialize(settings)
			# Send settings to the window
			super settings.width, settings.height, settings.fullscreen

			# And keep the settings for reading information
			@settings = settings

			# Set the title
			self.caption = settings.title.to_s

			# The input object
			@game_input = Input.new()

			# The class variables
			@use_cursor = false
		end

		def run
			show
		end

		def update; end

		def draw; end

		def input
			return @game_input
		end

		def needs_cursor?
			@use_cursor
		end

		def resize(width, height)
			@settings.width = width
			@settings.height = height
			self.width = width
			self.height = height
		end

		private

		def show
			super
		end

	end

	class Sprite

		attr_accessor :x, :y, :z
		attr_accessor :angle, :scale_x, :scale_y
		attr_accessor :center_x, :center_y
		attr_accessor :mirror_x, :mirror_y
		attr_accessor :color
		attr_accessor :path

		def initialize(path, options = {})

			if path.is_a? String
				@img = Gosu::Image.new(path, options)
			elsif path.is_a? Gosu::Image
				@img = path
			end

			@path = path
			@width = @img.width
			@height = @img.height
			@x = 0
			@y = 0
			@z = 0
			@angle = 0.0
			@scale_x = 1.0
			@scale_y = 1.0
			@center_x = 0.0
			@center_y = 0.0
			@mirror_x = false
			@mirror_y = false
			@color = Gosu::Color::WHITE
			@blob = @img.to_blob
		end

		def draw(x = @x ,y = @y ,z = @z, scale_x = @scale_x, scale_y = @scale_y)

			# Set each point / scale / angle / ...
			# @center_x = (@center_x * @scale_x).to_f
			# @center_y = (@center_y * @scale_y).to_f

			@scale_x = @scale_x.to_f
			@scale_y = @scale_y.to_f

			@angle = @angle.to_f

			@img.draw_rot(x,
						  y,
						  z,
						  @angle,
						  @center_x,
						  @center_y,
						  (@mirror_x) ? -scale_x : scale_x,
						  (@mirror_y) ? -scale_y : scale_y,
						  @color)

		end

		def get_pixel(x, y)

			if x < 0 or x >= width or y < 0 or y >= height
				return nil
			else
				r = @blob[(y * @img.width + x) * 4, 4][0].unpack("H*").first.to_i(16)
				g = @blob[(y * @img.width + x) * 4, 4][1].unpack("H*").first.to_i(16)
				b = @blob[(y * @img.width + x) * 4, 4][2].unpack("H*").first.to_i(16)
				a = @blob[(y * @img.width + x) * 4, 4][3].unpack("H*").first.to_i(16)

				return Gosu::Color.new(a, r, g, b)
			end

		end

		def mouse_hover?
			if $game.mouse_x < @x or $game.mouse_x >= @x + @width or $game.mouse_y < @y or $game.mouse_y >= @y + @height
				return false
			else
				return true
			end
		end

		def width
			return @width
		end

		def height
			return @height
		end

		def position=(vec)
			if vec.is_a? Vector2
				@x = vec.x
				@y = vec.y
			elsif vec.is_a? Vector3
				@x = vec.x
				@y = vec.y
				@z = vec.z
			else
				raise "NeoGame [ERROR]: The position cannot be a #{vec.class}."
			end
		end

		def position
			return Vector3.new(@x, @y, @z)
		end


	end

	class SpriteSheet

		attr_accessor :frame_time
		attr_accessor :x, :y, :z
		attr_accessor :angle, :scale_x, :scale_y
		attr_accessor :center_x, :center_y
		attr_accessor :mirror_x, :mirror_y
		attr_accessor :color
		attr_accessor :path

		def initialize(path, width, height, options = {})

			@animation = Gosu::Image.load_tiles(path, width, height, options)

			@path = path

			@frame_time = 1.0

			@current_frame = 0

			@stop = false

			@start_time = Gosu.milliseconds
			@time = @start_time.to_f

			@mirror_x = false
			@mirror_y = false

			@x = 0
			@y = 0
			@z = 0
			@width = width
			@height = height
			@angle = 0.0
			@scale_x = 1.0
			@scale_y = 1.0
			@center_x = 0.0
			@center_y = 0.0
			@color = Gosu::Color::WHITE

			@blob = []

			@animation.each { |image| @blob << image.to_blob }
		end

		def  draw(x = @x, y = @y, z = @z)

			# Update
			if !@stop
				@time = Gosu.milliseconds - @start_time

				if @time >= (@frame_time * 1000)
					@start_time = Gosu.milliseconds
					@time = 0.0

					@current_frame += 1

					@current_frame = 0 if @current_frame == @animation.size
				end
			end


			if @mirror_y
				@center_y = @center_x
			end

			# Draw
			@animation[@current_frame].draw_rot(x,
												y,
												z,
												@angle,
												(@mirror_x) ? (@width - @center_x) / @width : @center_x / @width,
												(@mirror_y) ? (@height - @center_y) / @height : @center_y / @height,
												(@mirror_x) ? -@scale_x : @scale_x,
												(@mirror_y) ? -@scale_y : @scale_y,
												@color)

		end

		def stop
			@stop = true
		end

		def start
			@stop = false
		end

		def set_frame(frame)
			frame = 0 if frame > @animation.size
			@current_frame = frame
		end

		def get_pixel(x, y, frame = @current_frame)

			if x < 0 or x >= width or y < 0 or y >= height
				return nil
			else
				r = @blob[frame][(y * width + x) * 4, 4][0].unpack("H*").first.to_i(16)
				g = @blob[frame][(y * width + x) * 4, 4][1].unpack("H*").first.to_i(16)
				b = @blob[frame][(y * width + x) * 4, 4][2].unpack("H*").first.to_i(16)
				a = @blob[frame][(y * width + x) * 4, 4][3].unpack("H*").first.to_i(16)

				return Gosu::Color.new(a, r, g, b)
			end

		end

		def mouse_hover?
			if $game.mouse_x < @x or $game.mouse_x >= @x + @width or $game.mouse_y < @y or $game.mouse_y >= @y + @height
				return false
			else
				return true
			end
		end

		def width
			return @width
		end

		def height
			return @height
		end

		def position=(vec)
			if vec.is_a? Vector2
				@x = vec.x
				@y = vec.y
			elsif vec.is_a? Vector3
				@x = vec.x
				@y = vec.y
				@z = vec.z
			else
				raise "NeoGame [ERROR]: The position cannot be a #{vec.class}."
			end
		end

		def position
			return Vector3.new(@x, @y, @z)
		end

	end

	class ObjectManager

		@@objects = {}

		def ObjectManager.set(id, object)
			@@objects[id] = object
		end

		def ObjectManager.delete(id)
			@@objects[id] = nil
		end

		def ObjectManager.get(id)
			return @@objects[id]
		end

	end

	class Text

		DEFAULT_FONT = Gosu.default_font_name

		attr_accessor :text
		attr_accessor :x, :y, :z
		attr_accessor :scale_x, :scale_y
		attr_accessor :angle, :center_x, :center_y
		attr_accessor :color

		def initialize(font_path, size)

			if font_path != DEFAULT_FONT
				if font_path[0] != "." && font_path[1] != "/"
					font_path = ("./" + font_path).to_s
				end
			end

			@font = Gosu::Font.new(size, :name => font_path)
			@color = Gosu::Color::WHITE

			@scale_x = 1.0
			@scale_y = 1.0

			@x = 0
			@y = 0
			@z = 0

			@text = ""

			@angle = 0.0
			@center_x = 0.0
			@center_y = 0.0

		end

		def draw(text = @text, x = @x, y = @y, z = @z, scale_x = @scale_x, scale_y = @scale_y, color = @color)
			Gosu.rotate(@angle, @center_x, @center_y) do
				@font.draw(text, x, y, z, scale_x, scale_y, color)
			end
		end

		def width(text = @text, scale_x = @scale_x)
			return @font.text_width(text, scale_x)
		end

		def height
			return @font.height
		end

		def position=(vec)
			if vec.is_a? Vector2
				@x = vec.x
				@y = vec.y
			elsif vec.is_a? Vector3
				@x = vec.x
				@y = vec.y
				@z = vec.z
			else
				raise "NeoGame [ERROR]: The position cannot be a #{vec.class}."
			end
		end

		def position
			return Vector3.new(@x, @y, @z)
		end

	end

	class Camera

		attr_accessor :x, :y
		attr_accessor :scale_x, :scale_y
		attr_accessor :center_x, :center_y
		attr_accessor :render_order
		attr_accessor :angle

		def initialize

			@x = 0
			@y = 0

			@scale_x = 1.0
			@scale_y = 1.0

			@center_x = 0.0
			@center_y = 0.0

			@render_order = [:scale, :translate, :rotate]

			@angle = 0.0
		end

		def render

			raise "NeoGame [ERROR]: The render order array is less than 3." if render_order.size < 3

			self.send render_order[0] do
				self.send render_order[1] do
					self.send render_order[2] do
						yield
					end
				end
			end

		end

		def scale(scale_x = @scale_x, scale_y = @scale_y, center_x = @center_x, center_y = @center_y)
			Gosu.scale(scale_x, scale_y, center_x, center_y) do
				yield
			end
		end

		def translate(x = @x, y = @y)
			Gosu.translate(x, y) do
				yield
			end
		end

		def rotate(angle = @angle, center_x = @center_x, center_y = @center_y)
			Gosu.rotate(angle, center_x, center_y) do
				yield
			end
		end

		def record(width, height)
			img = Gosu.record(width, height) do
				yield
			end

			return Sprite.new(img)
		end

		def position=(vec)
			if vec.is_a? Vector2
				@x = vec.x
				@y = vec.y
			else
				raise "NeoGame [ERROR]: The position cannot be a #{vec.class}."
			end
		end

		def position
			return Vector2.new(@x, @y)
		end

	end

	class Media

		attr_reader :looping, :volume, :speed, :panning

		def initialize(path)

			@sample = Gosu::Sample.new(path)
			@channel = nil

			@looping = false
			@volume = 1.0
			@speed = 1.0
			@panning = 0.0

			@playing = false

		end

		def play(looping = @looping, volume = @volume, speed = @speed, panning = @panning)

			@channel = nil

			@looping = looping
			@volume = volume
			@speed = speed
			@panning = panning

			@channel = @sample.play_pan(panning, volume, speed, looping)

			@playing = true

		end

		def stop

			puts "NeoGame [ERROR]: The media is already stopped." if @channel == nil
			return if @channel == nil

			@channel.stop
			@channel = nil

			@playing = false

		end

		def pause

			puts "NeoGame [ERROR]: Cannot pause if it was stopped or not started." if @channel == nil
			return if @channel == nil

			@channel.pause

		end

		def resume

			puts "NeoGame [ERROR]: Cannot resume if it was stopped or not started." if @channel == nil
			return if @channel == nil

			@channel.resume

		end

		def playing?

			@playing = @channel.playing? if @channel != nil

			return @playing

		end

		def paused?

			puts "NeoGame [ERROR]: Cannot return if the media is paused if it was stopped or not played." if @channel == nil
			return if @channel == nil

			return @channel.paused?

		end

		def pan=(v)
			puts "NeoGame [ERROR]: Cannot set the pan if it was stopped or not started." if @channel == nil
			return if @channel == nil

			@panning = v
			@channel.pan = v
		end

		def speed=(v)
			puts "NeoGame [ERROR]: Cannot set the speed if it was stopped or not started." if @channel == nil
			return if @channel == nil

			@speed = v
			@channel.speed = v
		end

		def volume=(v)
			puts "NeoGame [ERROR]: Cannot set the volume if it was stopped or not started." if @channel == nil
			return if @channel == nil

			@volume = v
			@channel.volume = v
		end

	end

	class StateManager

		def self.initialize(window)
			@@window = window
			@@state ||= {}
			@@current_state ||= nil
			@@input = window.input

			@@last_state_screenshot ||= nil
		end

		def self.update
			@@input.send :reset

			@@state[@@current_state].update(@@input) if @@current_state != nil
		end

		def self.draw
			@@state[@@current_state].draw if @@current_state != nil
		end

		def self.add_state(id, state)
			raise "NeoGame [ERROR]: \"#{id}\": Waiting for a symbol." if !id.is_a? Symbol
			raise "NeoGame [ERROR]: \"#{state}\": Waiting for a State." if !state.is_a? State

			@@state[id] = state
		end

		def self.set_state(id)
			raise "NeoGame [ERROR]: \"#{id}\": Waiting for a symbol." if !id.is_a? Symbol
			raise "NeoGame [ERROR]: This State doesn't exit." if !@@state.include?(id)

			if @@current_state != nil
				@@last_state_screenshot = Gosu.record(@@window.width, @@window.height) { @@state[@@current_state].draw() } rescue nil
				@@state[@@current_state].reset
			end

			@@current_state = id

			@@state[@@current_state].reset
		end

		def self.get_state(id)
			raise "NeoGame [ERROR]: \"#{id}\": Waiting for a symbol." if !id.is_a? Symbol
			raise "NeoGame [ERROR]: This GameState doesn't exit." if !@@state.include?(id)

			return @@state[id]
		end

		def self.get_state_id()
			return @@current_state
		end

		def self.get_last_state_screenshot()
			return @@last_state_screenshot
		end

		def self.window()
			return @@window
		end

	end

	class State

		def update(input); end
		def draw; end
		def reset; end

	end

	module GUI

		class Panel

			attr_accessor :x, :y, :z
			attr_accessor :width, :height
			attr_accessor :border_size
			attr_accessor :color_in, :color_out

			def initialize(width, height, border_size)
				@color_in = Color::WHITE
				@color_out = Color::BLACK
				@x = 0
				@y = 0
				@z = 0
				@width = width
				@height = height
				@border_size = border_size
			end

			def draw
				Gosu.draw_rect(
					@x,
					@y,
					@width,
					@height,
					@color_out,
					@z
				)

				Gosu.draw_rect(
					@x + @border_size,
					@y + @border_size,
					@width - @border_size * 2,
					@height - @border_size * 2,
					@color_in,
					@z
				)
			end

			def size=(vec2)
				@width = vec2.x
				@height = vec2.y
			end

			def size
				return Vector2.new(@width, @height)
			end

			def position=(vec)
				if vec.is_a? Vector2
					@x = vec.x
					@y = vec.y
				elsif vec.is_a? Vector3
					@x = vec.x
					@y = vec.y
					@z = vec.z
				else
					raise "NeoGame [ERROR]: The position cannot be a #{vec.class}."
				end
			end

			def position
				return Vector3.new(@x, @y, @z)
			end

		end

		class ProgressBar
			attr_accessor :x, :y, :z
			attr_accessor :width, :height
			attr_accessor :border_size
			attr_accessor :color_in, :color_out
			attr_accessor :percentage

			def initialize(x, y, z, width, height, border_size, color_out, color_in)
				@color_in = color_in
				@color_out = color_out
				@x = x
				@y = y
				@z = z
				@width = width
				@height = height
				@border_size = border_size
				@percentage = 0
			end

			def draw
				Gosu.draw_rect(
					@x,
					@y,
					@width,
					@height,
					@color_out,
					@z
				)

				Gosu.draw_rect(
					@x + @border_size,
					@y + @border_size,
					(@percentage * (@width - @border_size * 2) / 100),
					@height - @border_size * 2,
					@color_in,
					@z
				)
			end

			def position=(vec)
				if vec.is_a? Vector2
					@x = vec.x
					@y = vec.y
				elsif vec.is_a? Vector3
					@x = vec.x
					@y = vec.y
					@z = vec.z
				else
					raise "NeoGame [ERROR]: The position cannot be a #{vec.class}."
				end
			end

			def position
				return Vector3.new(@x, @y, @z)
			end

		end

		class Button
  
			attr_accessor :x, :y, :z
			attr_accessor :width, :height
			attr_accessor :text
			attr_accessor :text
		  
			def initialize(window, img_n, img_s)
				
				@window = window
		
				@x = 0
				@y = 0
				@z = 0

				if img_n.class == String
					@img_n = Sprite.new(img_n)
				elsif img_n.class == Neogame::Sprite
					@img_n = img_n
				end

				if img_s.class == String
					@img_s = Sprite.new(img_s)
				elsif img_s.class == Neogame::Sprite
					@img_s = img_s
				end

				@text = ""

				@text = nil

				if @img_n.width != @img_s.width or @img_s.height != @img_n.height
					raise "NeoGame [ERROR]: The two image haven't the same size!"
				end

				@width = @img_n.width
				@height = @img_n.height

				@pressed = 0
			end
			
			def hover?
			  if @window.mouse_x >= @x and @window.mouse_x <= @x + @width then
				if @window.mouse_y >= @y and @window.mouse_y < @y + @height then
				  return true
				end
			  end
			  return false
			end
			
			def pressed?
			  
			  if hover? and button_down?(MS_LEFT) and @pressed == 0
				@pressed = 1
			  end
			  
			  if not button_down?(MS_LEFT) and @pressed == 1
				@pressed = 0
				return true
			  end
			  
			  return false
			end
			
			def draw
				if hover?
					@img_s.draw(@x, @y, @z)
				else
					@img_n.draw(@x, @y, @z)
				end

				if @text != ""
					if @text != nil
						DEFAULT_TEXT.draw(@text,
						@x + (@width - DEFAULT_TEXT.width(@text))/2,
						@y + (@height - DEFAULT_TEXT.height) / 2,
						@z,
						1.0,
						1.0,
						Color::YELLOW)
					else
						DEFAULT_TEXT.draw(@text,
							@x + (@width - DEFAULT_TEXT.width(@text))/2,
							@y + (@height - DEFAULT_TEXT.height) / 2,
							@z,
							1.0,
							1.0,
							Color::YELLOW)
					end
				end
			end

		end

	end

	# Module constant definition

	Vector2 = Struct.new(:x, :y)
	Vector3 = Struct.new(:x, :y, :z)

	Settings = Struct.new(
			:width,
			:height,
			:fullscreen,
			:title
	)

	DEFAULT_TEXT = Text.new(Text::DEFAULT_FONT, 50)

end
