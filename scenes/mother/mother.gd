class_name Mother
extends CharacterBody2D


@export var speed: float = 250.0
@export var acceleration: float = 1200.0

var is_furious: bool = false

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player") as CharacterBody2D
@onready var is_stunned: bool = false
@onready var stun_timer: Timer = $StunTimer as Timer
@onready var sprite: AnimatedSprite2D = $MotherSprite as AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	animation_player.speed_scale = 3
	animation_player.play(&"moving")


func _physics_process(delta: float) -> void:
	if is_stunned:
		return

	if player:
		var player_dir: Vector2 = global_position.direction_to(player.global_position)
		var dir: Vector2 = player_dir.rotated(randf_range(-PI / 3, PI / 3))
		velocity = velocity.move_toward(speed * dir, delta * acceleration)

		if player_dir.y > 0:
			if is_furious:
				sprite.play(&"fury_walk")
			else:
				sprite.play(&"walk_front")
		if player_dir.y < 0:
			sprite.play(&"walk_back")

	move_and_slide()


func hit() -> void:
	is_stunned = true
	stun_timer.start()


func _on_stun_timer_timeout() -> void:
	is_stunned = false


func _on_child_fainted() -> void:
	is_furious = true
	speed *= 2
	animation_player.speed_scale *= 2
