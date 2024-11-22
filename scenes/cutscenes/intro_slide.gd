extends Transition


@export var is_animation_over: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	animation_player.play("fade_in")


func _on_gui_input(event: InputEvent) -> void:
	if is_animation_over and event.is_action_pressed(&"left_click"):
		transition()
