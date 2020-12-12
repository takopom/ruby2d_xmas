# frozen_string_literal: true

require 'ruby2d'
require_relative 'movable'
require_relative 'collision'

class Ground < Image
  include Movable
  include Collision

  HEIGHT = 96
  Z = 2
  SPEED = 2

  attr_reader :window

  def initialize(window:)
    @window = window
    super 'images/base.png', x: 0, y: window.get(:height) - HEIGHT, z: Z, width: window.get(:width), height: HEIGHT
  end

  def update
    to_left speed: SPEED
    self.x = window.get(:width) - SPEED if off_screen_left?
  end
end
