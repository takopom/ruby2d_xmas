# frozen_string_literal: true

require 'ruby2d'

class Sky < Image
  def initialize(window:)
    super 'images/background-night.png', x: 0, y: 0, z: 0, width: window.get(:width), height: window.get(:height)
  end
end
