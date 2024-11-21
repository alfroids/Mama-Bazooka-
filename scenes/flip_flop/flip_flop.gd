class_name FlipFlop
extends Area2D


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D as CollisionShape2D
@onready var active_timer: Timer = $ActiveTimer as Timer
@onready var reload_timer: Timer = $ReloadTimer as Timer
@onready var flipflop_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D as AudioStreamPlayer2D

func _unhandled_input(event: InputEvent) -> void:
	if reload_timer.is_stopped() and event.is_action_pressed(&"hit"):
		sprite.play(&"hit")
		collision_shape_2d.disabled = false
		active_timer.start()
		reload_timer.start()
		
		flipflop_sound.play()



func _on_body_entered(body: Node2D) -> void:
	if body is Child:
		(body as Child).hit()
	elif body is Mother:
		(body as Mother).hit()


func _on_active_timer_timeout() -> void:
	collision_shape_2d.disabled = true
