extends Control

var animation_list: Array = [
	"slide1_fadein",
	"slide2_fadein",  
	"slide3_fadein",
	"slide4_fadein"
	]

var current_animation = 0
var play_cur_anim = animation_list[0]

var text_list: Array = [
	"On an ordinary Sunday evening, it's natural for every parent to long for a bit of tranquility - a short but precious moment to sit back, breathe deeply, and enjoy a rare sense of peace amidst the usual busyness of family life.",
	"However, as is often the case, children always seem to find a way to disrupt that fleeting moment of calm for their parents—whether it’s by creating a massive mess, accidentally breaking things, or getting themselves into some kind of mischief.",
	"This mother had enough. While her love for children was beyond question, it was time for a valuable lesson. Determined and unstoppable, she vowed to set things straight by KICKING THE BUTT OF EVERY CHILDREN ON THE PLANET.",
	"This is Mama Bazooka."
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
