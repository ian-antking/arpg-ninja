extends CharacterBody2D

signal health_changed

@export var speed: int = 50
@export var max_health: int = 3
@export var knockback_power: int = 1000

@onready var sprite = $AnimationPlayer
@onready var effects = $Effects
@onready var current_health: int = max_health
@onready var hurt_timer = $HurtTimer
@onready var hurtbox = $Hurtbox

var is_hurt: bool = false

func _ready():
	effects.play("RESET")

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
	if !is_hurt:
		for area in hurtbox.get_overlapping_areas():
			if area.name == "HitBox":
				hurt_by_enemy(area)
	
func knockback(entity_velocity: Vector2):
	var knockback_direction =(entity_velocity - velocity).normalized() * knockback_power
	velocity = knockback_direction
	move_and_slide()
	
func hurt_by_enemy(area):
	var entity = area.get_parent()
	current_health -= entity.damage
	
	if current_health < 0:
		current_health = max_health
	
	health_changed.emit(current_health)
	is_hurt = true
	knockback(entity.velocity)
	effects.play("hurt_blink")
	hurt_timer.start()
	await hurt_timer.timeout
	effects.play("RESET")
	is_hurt = false
