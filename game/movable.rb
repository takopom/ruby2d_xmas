# frozen_string_literal: true

module Movable
  def update
  end

  def reset
  end

  def to_left(speed:)
    self.x -= speed
  end
end
