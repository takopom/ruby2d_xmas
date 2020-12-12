# frozen_string_literal: true

require 'ruby2d'

module Collision
  def collision_rect?(target)
    col1 = { l: self.x, r: self.x + self.width, t: self.y, b: self.y + self.height }
    col2 = { l: target.x, r: target.x + target.width, t: target.y, b: target.y + target.height }
    col1[:l] < col2[:r] && col1[:r] > col2[:l] && col1[:t] < col2[:b] && col1[:b] > col2[:t]
  end

  def off_screen?(window)
    (self.x + self.width).negative? || self.x > window.get(:width) || (self.y + self.height).negative? || self.y > window.get(:height)
  end

  def off_screen_left?
    (self.x + self.width).negative?
  end

end
