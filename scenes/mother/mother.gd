extends CharacterBody2D


@export var speed: float = 200.0

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player") as CharacterBody2D


func _physics_process(_delta: float) -> void:
	if player:
		var player_dir: Vector2 = global_position.direction_to(player.global_position)
		velocity = speed * player_dir

	move_and_slide()
