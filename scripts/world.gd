extends Node2D

@onready var hearts_container = $CanvasLayer/HeartsContainer
@onready var player = $TileMap/Player

func _ready():
	player.health_changed.connect(hearts_container.update)
	hearts_container.set_max_hearts(player.max_health)
	hearts_container.update(player.max_health)

func _process(delta):
	pass
