class_name Level
extends Node2D


@export var house_scenes: Array[PackedScene]
@export var player_scene: PackedScene
@export var child_scene: PackedScene
@export var mother_scene: PackedScene

static var horde_size: int = 0

var house: House
var player: Player
var child: Child
var mother: Mother

@onready var is_level_over: bool = false
@onready var defeat_timer: Timer = $DefeatTimer as Timer
@onready var horde_timer: Timer = $HordeTimer as Timer
@onready var pause_menu: Control = $Menus/PauseMenu as Control
@onready var defeat_screen: Control = $Menus/DefeatScreen as Control


func _ready() -> void:
	Hud.visible = true
	Hud.set_time_left(1)
	Hud.set_hits_left(3)
	tree_exited.connect(Hud.hide)

	SignalBus.child_fainted.connect(_on_child_fainted)

	var house_scene: PackedScene = house_scenes.pick_random()
	house = house_scene.instantiate() as House
	add_child(house)

	player = player_scene.instantiate() as Player
	player.global_position = house.player_spawn.global_position
	add_child(player)

	var camera: Camera2D = Camera2D.new()
	camera.process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS
	camera.position_smoothing_enabled = true
	camera.zoom = 2 * Vector2.ONE
	player.add_child(camera)

	mother = mother_scene.instantiate() as Mother
	mother.global_position = house.mother_spawn.global_position
	add_child(mother)

	SignalBus.child_fainted.connect(mother._on_child_fainted)

	child = child_scene.instantiate() as Child
	child.global_position = house.child_spawn.global_position
	child.mother = mother
	add_child(child)


func _process(_delta: float) -> void:
	Hud.set_time_left(defeat_timer.time_left / defeat_timer.wait_time)


func _on_defeat_timer_timeout() -> void:
	defeat_screen.enable()


func _on_horde_timer_timeout() -> void:
	for _i in range(horde_size):
		#if is_level_over:
			#break
		var m: Mother = mother_scene.instantiate() as Mother
		m.global_position = house.player_spawn.global_position
		add_child(m)
		await get_tree().create_timer(0.25).timeout


func _on_child_fainted() -> void:
	is_level_over = true
	horde_size += 1
	#defeat_timer.paused = true
	#defeat_timer.start(defeat_timer.wait_time)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		pause_menu.enable()
