class_name Mother
extends CharacterBody2D


@export var speed: float = 250.0
@export var acceleration: float = 1200.0

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player") as CharacterBody2D
@onready var is_stunned: bool = false
@onready var stun_timer: Timer = $StunTimer as Timer
@onready var animated_sprite: AnimatedSprite2D = $MotherSprite as AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	animation_player.speed_scale = 3
	animation_player.play(&"moving")


func _physics_process(delta: float) -> void:
	if is_stunned:
		return

	if player:
		var player_dir: Vector2 = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(speed * player_dir, delta * acceleration)

		if player_dir.y > 0:
			animated_sprite.animation = "walk_front"
		if player_dir.y < 0:
			animated_sprite.animation = "walk_back"

	move_and_slide()


func hit() -> void:
	is_stunned = true
	stun_timer.start()


func _on_stun_timer_timeout() -> void:
	is_stunned = false


func _on_child_fainted() -> void:
	speed *= 2
	animation_player.speed_scale *= 2
