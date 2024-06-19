extends CharacterBody2D

@export var speed: int = 35
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func handle_input():
	var vector: Vector2 = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	velocity = vector * speed

func update_animation():
	if velocity.length() == 0:
		sprite.stop()
	else: 
		var direction: String = "down"
		print(velocity)
		if velocity.x < 0: direction = "left"
		if velocity.x > 0: direction = "right"
		if velocity.y < 0: direction = "up"
		
		sprite.play("walk_" + direction)

func _physics_process(delta):
	handle_input()
	move_and_slide()
	update_animation()
