extends HBoxContainer

@onready var HeartGui = preload("res://scenes/heart_gui.tscn")

func _ready():
	pass

func _process(delta):
	pass
	
func set_max_hearts(max: int):
	for i in range(max):
		add_child(HeartGui.instantiate())
		
func update(current_health: int):
	var hearts = get_children()
	
	for i in len(hearts):
		var heart = hearts[i]
		var is_whole = true if i+1 <= current_health else false
		heart.update(is_whole)
