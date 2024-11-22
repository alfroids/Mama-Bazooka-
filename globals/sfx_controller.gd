extends AudioStreamPlayer


func _enter_tree() -> void:
	stream = AudioStreamPolyphonic.new()


func play_sfx(sfx: AudioStream) -> void:
	if not playing:
		play()

	var playback: AudioStreamPlayback = get_stream_playback()
	playback.play_stream(sfx)
