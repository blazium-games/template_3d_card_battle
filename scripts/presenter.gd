extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var tower: MeshInstance3D = $Tower
@onready var rig_eye: Camera3D = $RigEye

func _ready() -> void:
	rig_eye.rotation_degrees = Vector3(-55, 0, 0)

func _process(_delta: float) -> void:
	rules.tick_elixir(_delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		if rules.draw_card(rules.hand):
			rules.hand += 1
		if rules.deploy(3, true) == "deployed":
			rules.strike_tower(2)
			tower.scale = Vector3(1, maxf(float(rules.tower_points) / 20.0, 0.1), 1)
		if rules.may_result():
			_go("res://scenes/result.tscn")
	if event.is_action_pressed("leap"):
		rules.play_costly()

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
