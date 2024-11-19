class_name Child
extends CharacterBody2D


@export var speed: float = 300.0
@export var acceleration: float = 900.0
@export var threshold: float = 0.9

var mother: Mother

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var hp: int = 3


func _physics_process(delta: float) -> void:
	var player_dir: Vector2
	if player:
		player_dir = global_position.direction_to(player.global_position)

	var mother_dir: Vector2
	if mother:
		mother_dir = global_position.direction_to(mother.global_position)

	if player_dir.dot(mother_dir) >= threshold:
		($ChildSprite as AnimatedSprite2D).modulate = Color.WHITE
		velocity = velocity.move_toward(speed * (-player_dir), delta * acceleration)
	else:
		($ChildSprite as AnimatedSprite2D).modulate = Color.RED
		velocity = velocity.move_toward(speed * mother_dir, delta * acceleration)

	move_and_slide()


func hit() -> void:
	hp -= 1
	if hp <= 0:
		mother._on_child_died()
		queue_free()
