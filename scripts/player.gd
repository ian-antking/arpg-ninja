extends CharacterBody2D

const speed = 35

func handle_input():
	var vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	velocity = vector * speed

func _physics_process(delta):
	handle_input()
	move_and_slide()
