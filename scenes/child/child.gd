class_name Child
extends CharacterBody2D


signal fainted()

@export var speed: float = 300.0
@export var acceleration: float = 900.0
@export var threshold: float = 0.9
@export var sprite: AnimatedSprite2D

var mother: Mother

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var hp: int = 3

func _physics_process(delta: float) -> void:
	var player_dir: Vector2
	if player:
		player_dir = global_position.direction_to(player.global_position)

		if player_dir.y > 0:
			sprite.animation = "walk_back"
		if player_dir.y < 0:
			sprite.animation = "walk_front"

	var mother_dir: Vector2
	if mother:
		mother_dir = global_position.direction_to(mother.global_position)

	if player_dir.dot(mother_dir) >= threshold:
		($ChildSprite as AnimatedSprite2D).modulate = Color.WHITE
		velocity = velocity.move_toward(speed * (-player_dir), delta * acceleration)
	else:
		($ChildSprite as AnimatedSprite2D).modulate = Color.RED
		var dir: Vector2 = (mother_dir - player_dir).normalized()
		velocity = velocity.move_toward(speed * dir, delta * acceleration)

	move_and_slide()


func hit() -> void:
	hp -= 1
	if hp <= 0:
		fainted.emit()
		queue_free()
	else:
		sprite.rotation = 3 * PI / 4
		var tween: Tween = create_tween()
		tween.tween_property(
			sprite,
			^"rotation",
			0,
			0.25,
		).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
