class_name Child
extends CharacterBody2D


signal fainted()

@export var speed: float = 300.0
@export var acceleration: float = 900.0
@export var threshold: float = 0.98
@export var sprite: AnimatedSprite2D

var mother: Mother
var is_fainted: bool = false

var hit_sounds = {
	"hit_1" = preload("res://assets/sounds/sfx/hurt/9.wav"),
	"hit_2" = preload("res://assets/sounds/sfx/hurt/11.wav"),
	"hit_3" = preload("res://assets/sounds/sfx/hurt/12.wav"),
	"hit_4" = preload("res://assets/sounds/sfx/hurt/13.wav")
	}

@onready var hit_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D as AudioStreamPlayer2D
@onready var player: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var anchor: Node2D = $Anchor as Node2D
@onready var hp: int = 3


func _physics_process(delta: float) -> void:
	if is_fainted:
		return

	var canvas: Transform2D = get_canvas_transform()
	var top_left: Vector2 = -canvas.origin / canvas.get_scale()
	var size: Vector2 = get_viewport_rect().size / canvas.get_scale()
	var screen: Rect2 = Rect2(top_left, size)

	if screen.has_point(global_position):
		anchor.visible = false
	else:
		anchor.visible = true
		anchor.look_at(global_position)
		anchor.global_position = global_position.clamp(screen.position, screen.end)

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

	var dir: Vector2
	if player_dir.dot(mother_dir) >= threshold:
		dir = (-player_dir)
	else:
		dir = (mother_dir - player_dir).normalized()
	dir = dir.rotated(randf_range(-PI / 2, PI / 2))
	velocity = velocity.move_toward(speed * dir, delta * acceleration)

	move_and_slide()


func hit() -> void:
	hp -= 1
	if hp <= 0:
		is_fainted = true
		fainted.emit()
		sprite.play(&"fainted")
		anchor.visible = false
	else:
		sprite.rotation = 3 * PI / 4
		var tween: Tween = create_tween()
		tween.tween_property(
			sprite,
			^"rotation",
			0,
			0.25,
		).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
		
		var hit_size = hit_sounds.size()
		var random_hit = hit_sounds.keys()[randi() % hit_size]
		hit_sound.stream = hit_sounds[random_hit]
		hit_sound.play()
