extends Panel

@onready var sprite = $Sprite2D

func update(is_whole: bool):
	sprite.frame = 4 if is_whole else 0
