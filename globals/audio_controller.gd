extends AudioStreamPlayer


const INTRO_SONG: AudioStream = preload("res://assets/sounds/pizza_jam_introsong_tuba.wav")
const MAIN_SONG: AudioStream = preload("res://assets/sounds/pizza_jam_song_v3.wav")
const TITLESCREEN_SONG: AudioStream = preload("res://assets/sounds/pizza_jam_titlescreen_song.wav")


func _ready() -> void:
	play_intro_song()


func play_intro_song() -> void:
	volume_db = -2
	stream = INTRO_SONG
	play()


func play_main_song() -> void:
	volume_db = 0
	stream = MAIN_SONG
	play()


func play_titlescreen_song() -> void:
	volume_db = 0
	stream = TITLESCREEN_SONG
	play()
