class_name House
extends Node2D


var player: Player
var mother: Mother
var child: Child

@onready var player_scene: PackedScene = preload("res://scenes/player/player.tscn")
@onready var mother_scene: PackedScene = preload("res://scenes/mother/mother.tscn")
@onready var child_scene: PackedScene = preload("res://scenes/child/child.tscn")
@onready var player_spawn: Marker2D = $PlayerSpawn as Marker2D
@onready var mother_spawn: Marker2D = $MotherSpawn as Marker2D
@onready var child_spawn: Marker2D = $ChildSpawn as Marker2D
@onready var door: Door = $Door as Door


func _ready() -> void:
	#Music.playing = true
	AudioController.play_main_song()

	player = player_scene.instantiate() as Player
	player.global_position = player_spawn.global_position
	add_child(player)
	var camera: Camera2D = Camera2D.new()
	camera.zoom = 2 * Vector2.ONE
	camera.process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS
	camera.position_smoothing_enabled = true
	player.add_child(camera)

	mother = mother_scene.instantiate() as Mother
	mother.global_position = mother_spawn.global_position
	add_child(mother)

	child = child_scene.instantiate() as Child
	child.global_position = child_spawn.global_position
	child.mother = mother
	add_child(child)

	child.fainted.connect(mother._on_child_fainted)
	child.fainted.connect(door._on_child_fainted)


func _on_horde_timer_timeout() -> void:
	for _i in range(Manager.horde_size):
		var m: Mother = mother_scene.instantiate() as Mother
		m.global_position = player_spawn.global_position
		add_child(m)
		await get_tree().create_timer(0.2).timeout
