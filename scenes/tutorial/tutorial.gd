extends Node2D


@onready var pause_menu: Control = $Menus/PauseMenu as Control


func _ready() -> void:
	AudioController.play_main_song()
	SignalBus.child_fainted.connect(_on_child_fainted)


func _on_child_fainted() -> void:
	($Tutorial3 as Label).visible = true


func _on_easter_egg_timer_timeout() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		pause_menu.enable()
