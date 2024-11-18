extends CharacterBody2D


@export var max_speed: float = 200.0
@export var dash_speed: float = 800.0
@export var acceleration: float = 600.0
@export var dash_acceleration: float = 4000.0
@export var drag: float = 250.0
@export var max_drag: float = 3000.0

@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D
@onready var state_chart: StateChart = $StateChart as StateChart
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer as Timer
@onready var dash_direction: Vector2 = Vector2.ZERO


func _on_idle_state_entered() -> void:
	velocity = Vector2.ZERO
	sprite_2d.frame_coords = Vector2i(0, 0)


func _on_idle_state_physics_processing(_delta: float) -> void:
	var input: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	if input:
		state_chart.send_event(&"started_moving")


func _on_move_state_physics_processing(delta: float) -> void:
	var input: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	if input:
		velocity += delta * acceleration * input

	if velocity:
		if velocity.length() > max_speed:
			velocity = velocity.move_toward(Vector2.ZERO, delta * max_drag)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, delta * drag)

	if not velocity and not input:
		state_chart.send_event(&"stopped_moving")

	else:
		if Input.is_action_just_pressed(&"dash") and dash_cooldown_timer.is_stopped():
			state_chart.send_event(&"started_dashing")
			return

		var x: int = 1 if velocity.x > max_speed / 4 else 2 if velocity.x < -max_speed / 4 else 0
		var y: int = 1 if velocity.y < -max_speed / 4 else 2 if velocity.y > max_speed / 4 else 0
		sprite_2d.frame_coords = Vector2i(x, y)
		move_and_slide()


func _on_dash_state_entered() -> void:
	dash_direction = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	var x: int = 1 if dash_direction.x > 0 else 2 if dash_direction.x < 0 else 0
	var y: int = 1 if dash_direction.y < 0 else 2 if dash_direction.y > 0 else 0
	sprite_2d.frame_coords = Vector2i(x, y)


func _on_dash_state_exited() -> void:
	dash_cooldown_timer.start()


func _on_dash_state_physics_processing(delta: float) -> void:
	velocity = velocity.move_toward(dash_speed * dash_direction, delta * dash_acceleration)
	move_and_slide()

	if is_equal_approx(velocity.length(), dash_speed):
		state_chart.send_event(&"stopped_dashing")
