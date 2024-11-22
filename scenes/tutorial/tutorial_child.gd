extends Child


func _on_nav_update_timer_timeout() -> void:
	if hp < 3 and player:
		var player_dir: Vector2 = global_position.direction_to(player.global_position)
		var target: Vector2 = global_position - 256 * player_dir
		var noise: Vector2 = 32 * Vector2.RIGHT.rotated(TAU * randf())
		nav_agent.target_position = target + noise
