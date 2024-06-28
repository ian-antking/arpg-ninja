extends CharacterBody2D

@export var speed: int = 20
@export var limit: float = 0.5
@export var end_point: Marker2D

@onready var sprite = $Sprite2D/AnimationPlayer

var start_position
var end_position

func _ready():
	start_position = position
	end_position = end_point.global_position
	
func change_direction():
	var temp_end = end_position
	end_position = start_position
	start_position = temp_end
	
func update_velocity():
	var move_direction = (end_position - position)
	if move_direction.length() < limit:
		change_direction()
		
	velocity = move_direction.normalized()*speed
	
func update_animation():
	if velocity.length() == 0:
		sprite.stop()
	else: 
		var direction: String = "down"
		if velocity.x < 0: direction = "left"
		if velocity.x > 0: direction = "right"
		if velocity.y < 0: direction = "up"
		
		sprite.play("walk_" + direction)

func _physics_process(_delta):
	update_velocity()
	move_and_slide()
	update_animation()
