# frozen_string_literal: true

require 'ruby2d'

require_relative 'game/sky'
require_relative 'game/game_scene'

# Set window
set title: "Takopom's Advent calendar 2020"
set diagnostics: false
set width: 360
set height: 640

# Create game objects
Sky.new window: (get :window)
game_scene = GameScene.new window: (get :window)

# Key events
on :key_down do |event|
  game_scene.key_down event
end

# The update loop
update do
  game_scene.update
end

# Show the window
show
