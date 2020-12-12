# frozen_string_literal: true

require 'ruby2d'
require_relative 'pipe'

class PipeController
  attr_reader :pipes, :window

  DISTANCE = 150
  RANDOM_Y = [-64, -32, 0, 32, 64].freeze

  def initialize(window:)
    @pipes = []
    @window = window
    first_pipe
    second_pipe
  end

  def update
    off_screen_pipes = []

    @pipes.each do |pipe|
      pipe.update
      off_screen_pipes.push pipe if pipe.off_screen_left?
    end

    reset_pipes off_screen_pipes if off_screen_pipes.size == 2
  end

  def reset
    @pipes[0].x = @window.get(:width)
    @pipes[1].x = @window.get(:width)
    @pipes[2].x = @window.get(:width) * 1.5 + @pipes[0].width / 2
    @pipes[3].x = @window.get(:width) * 1.5 + @pipes[0].width / 2

    @pipes[0].y = random_y
    @pipes[1].y = 0
    @pipes[2].y = random_y
    @pipes[3].y = 0

    pipes_distance @pipes[0], @pipes[1]
    pipes_distance @pipes[2], @pipes[3]
  end

  private

  def window_width
    @window.get(:width)
  end

  def reset_pipes(pipes)
    pipes.each do |pipe|
      pipe.x = @window.get(:width)
      pipe.y = random_y if pipe.label == :top
    end

    pipes_distance pipes[0], pipes[1]
  end

  def first_pipe_x
    @window.get(:width)
  end

  def first_pipe
    top_pipe = Pipe.new x: 0, y: random_y, label: :top
    x = @window.get(:width) - top_pipe.width / 2
    top_pipe.x = x
    @pipes.push top_pipe

    bottom_pipe = Pipe.new x: x, y: 0, label: :bottom
    bottom_pipe.y = @window.get(:height) - bottom_pipe.height
    @pipes.push bottom_pipe

    pipes_distance top_pipe, bottom_pipe
  end

  def second_pipe
    x = @window.get(:width) * 1.5
    top_pipe = Pipe.new x: x, y: random_y, label: :top
    @pipes.push top_pipe

    bottom_pipe = Pipe.new x: x, y: 0, label: :bottom
    bottom_pipe.y = @window.get(:height) - bottom_pipe.height
    @pipes.push bottom_pipe

    pipes_distance top_pipe, bottom_pipe
  end

  def pipes_distance(top, bottom)
    top.y -= DISTANCE / 2
    bottom.y = top.y + top.height + DISTANCE
  end

  def random_y
    RANDOM_Y.sample
  end
end
