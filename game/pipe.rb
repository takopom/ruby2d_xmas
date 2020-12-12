# frozen_string_literal: true

require 'ruby2d'
require_relative 'movable'
require_relative 'collision'

class Pipe < Image
  include Movable
  include Collision

  WIDTH = 52
  HEIGHT = 320
  Z = 1
  SPEED = 2
  IMAGES = { top: 'images/pipe-top.png', bottom: 'images/pipe-bottom.png' }.freeze

  attr_reader :label

  def initialize(x:, y:, label:)
    super IMAGES[label], x: x, y: y, z: Z, width: WIDTH, height: HEIGHT
    @label = label
  end

  def update
    to_left speed: SPEED
  end
end
