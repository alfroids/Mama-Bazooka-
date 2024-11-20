extends Child

func _physics_process(delta: float) -> void:
	var player_dir: Vector2
	if player:
		player_dir = global_position.direction_to(player.global_position)

		if player_dir.y > 0:
			sprite.animation = "walk_back"
		if player_dir.y < 0:
			sprite.animation = "walk_front"

	velocity = velocity.move_toward(speed * (-player_dir), delta * acceleration)

	move_and_slide()
