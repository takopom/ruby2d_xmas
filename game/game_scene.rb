# frozen_string_literal: true

require 'ruby2d'
require_relative 'player'
require_relative 'pipe_controller'
require_relative 'ground'

class GameScene
  attr_reader :window, :player, :pipe_controller, :grounds, :state

  def initialize(window:)
    @window = window
    @player = Player.new window: window
    @pipe_controller = PipeController.new window: window
    @grounds = game_grounds
    @state = :none
  end

  def update
    @player.update

    if @state == :none
      @pipe_controller.update
      update_grounds

      if @player.hit? @pipe_controller.pipes
        @player.jump
        @state = :miss
      end

    elsif @state == :restart
      restart
    end

    @state = :restart if @player.off_screen? @window
  end

  def key_down(event)
    return unless @state == :none

    @player.jump if event.key == 'space'
  end

  def restart
    @player.reset
    @pipe_controller.reset
    @state = :none
  end

  private

  def game_grounds
    ground_first = Ground.new window: @window
    ground_second = Ground.new window: @window
    ground_second.x = @window.get(:width)
    [ground_first, ground_second]
  end

  def update_grounds
    @grounds.each do |ground|
      ground.update
    end
  end
end
