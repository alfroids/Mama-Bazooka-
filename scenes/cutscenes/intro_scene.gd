extends Control

var animation_list: Array = ["slide1_fadein", "slide2_fadein",  "slide3_fadein"]
var current_animation = 0
var play_cur_anim = animation_list[0]

var text_list: Array = [
	"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
	"ccccccccccccccccccccccccccccccccccccccccccccc"
	]
	
	
var current_text = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
@onready var button: Button = $MarginContainer/VBoxContainer/Button as Button
@onready var intro_text: RichTextLabel = $MarginContainer/VBoxContainer/IntroText as RichTextLabel

func _ready():
	intro_text.add_text(text_list[current_text])

func _on_button_pressed():
	intro_text.clear()
	
	current_animation += 1
	current_text += 1
	
	if current_animation < len(animation_list):
		play_cur_anim = animation_list[current_animation]
		animation_player.play(play_cur_anim)
		
		intro_text.add_text(text_list[current_text])
		
	else:
		get_tree().change_scene_to_file("res://scenes/house/house.tscn")
