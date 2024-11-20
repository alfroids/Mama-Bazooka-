extends Node2D

var animation_list: Array = ["slide1_fadein", "slide2_fadein",  "slide3_fadein"]
var current_animation = 0
var play_cur_anim = animation_list[0]

@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

func _on_button_pressed():
	current_animation += 1
	play_cur_anim = animation_list[current_animation]
	animation_player.play(play_cur_anim)
