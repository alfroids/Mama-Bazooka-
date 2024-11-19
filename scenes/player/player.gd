class_name Player
extends CharacterBody2D


@export var speed: float = 400.0
@export var acceleration: float = 1600.0

@onready var weapon_holder: Node2D = $WeaponHolder as Node2D


func _physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	if input.dot(velocity.normalized()) < 0:
		velocity = velocity.move_toward(speed * input, 2 * delta * acceleration)
	else:
		velocity = velocity.move_toward(speed * input, delta * acceleration)

	move_and_slide()


func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	#weapon_holder.rotation = global_position.angle_to_point(mouse_pos)
	weapon_holder.look_at(mouse_pos)
