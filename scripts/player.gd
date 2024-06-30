extends CharacterBody2D

signal health_changed

@export var speed: int = 50
@export var max_health: int = 3
@export var knockback_power: int = 500

@onready var sprite = $Sprite2D/AnimationPlayer
@onready var current_health: int = max_health

func handle_input():
	var vector: Vector2 = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	velocity = vector * speed

func update_animation():
	if velocity.length() == 0:
		sprite.stop()
	else: 
		var direction: String = "down"
		if velocity.x < 0: direction = "left"
		if velocity.x > 0: direction = "right"
		if velocity.y < 0: direction = "up"
		
		sprite.play("walk_" + direction)

func _physics_process(delta):
	handle_input()
	move_and_slide()
	update_animation()
	
func knockback(entity_velocity: Vector2):
	var knockback_direction =(entity_velocity - velocity).normalized() * knockback_power
	velocity = knockback_direction
	move_and_slide()

func _on_hurtbox_area_entered(area):
	if area.name == "HitBox":
		var entity = area.get_parent()
		current_health -= entity.damage
		if current_health < 0:
			current_health = max_health
		health_changed.emit(current_health)
		knockback(entity.velocity)
