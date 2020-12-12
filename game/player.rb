# frozen_string_literal: true

require 'ruby2d'
require_relative 'movable'
require_relative 'collision'

class Player < Image
  include Movable
  include Collision

  JUMP_HEIGHT = -6
  GRAVITY = 0.5
  Z = 3

  WIDTH = 46
  HEIGHT = 46

  attr_reader :window, :velocity_y, :acceleration, :jumpable

  def initialize(window:)
    @window = window
    @jumpable = false
    super 'images/santa.png', x: window.get(:width) / 2 - WIDTH / 2, y: window.get(:height) / 2 - HEIGHT / 2, z: Z, width: WIDTH, height: HEIGHT
    reset_velocity
  end

  def update
    return unless jumpable

    @velocity_y += GRAVITY
    self.y += @velocity_y
  end

  def jump
    @jumpable = true
    @velocity_y = JUMP_HEIGHT
  end

  def reset
    @jumpable = false
    reset_velocity
    self.x = @window.get(:width) / 2 - WIDTH / 2
    self.y = @window.get(:height) / 2 - HEIGHT / 2
  end

  def hit?(pipes)
    pipes.each do |pipe|
      return true if collision_rect? pipe
    end

    false
  end

  private

  def reset_velocity
    @velocity_y = 0
  end
end
