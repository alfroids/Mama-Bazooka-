class_name Mother
extends CharacterBody2D


@export var speed: float = 250.0
@export var acceleration: float = 1200.0

@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var door: Door = get_tree().get_first_node_in_group(&"door") as Door
@onready var is_stunned: bool = false
@onready var is_furious: bool = false
@onready var is_grabbing_player: bool = false
@onready var stun_timer: Timer = $StunTimer as Timer
@onready var sprite: AnimatedSprite2D = $MotherSprite as AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D as NavigationAgent2D


func _ready() -> void:
	animation_player.speed_scale = 3
	animation_player.play(&"moving")


func _physics_process(delta: float) -> void:
	if is_stunned:
		return

	if not is_grabbing_player and global_position.distance_squared_to(player.global_position) < 400:
		grab_player()

	var next_pos: Vector2 = nav_agent.get_next_path_position()
	var dir: Vector2 = global_position.direction_to(next_pos)
	velocity = velocity.move_toward(speed * dir, delta * acceleration)

	if velocity.y > 0:
		if is_furious:
			sprite.play(&"fury_walk")
		else:
			sprite.play(&"walk_front")
	elif velocity.y < 0:
		sprite.play(&"walk_back")

	move_and_slide()


func hit() -> void:
	is_stunned = true
	stun_timer.start()
	release_player()


func grab_player() -> void:
	is_grabbing_player = true
	speed /= 2
	player.grab(self)


func release_player() -> void:
	if is_grabbing_player:
		is_grabbing_player = false
		speed *= 2
		player.release()


func _on_stun_timer_timeout() -> void:
	is_stunned = false


func _on_child_fainted() -> void:
	is_furious = true
	speed *= 2
	animation_player.speed_scale *= 2


func _on_nav_update_timer_timeout() -> void:
	if is_grabbing_player:
		nav_agent.target_position = door.global_position
	elif player:
		var noise: Vector2 = 32 * Vector2.RIGHT.rotated(TAU * randf())
		nav_agent.target_position = player.global_position + noise
