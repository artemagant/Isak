extends Node2D

signal shot

@onready var bullets: = $Bullets
@onready var camera: = $Camera2D
@export var player_scene: PackedScene
var peer = ENetMultiplayerPeer.new()

func _on_host_pressed() -> void:
	print(1)
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	move_camera()
	_add_player()

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)

func _on_join_pressed() -> void:
	peer.create_client("localhost", 135)
	move_camera()
	multiplayer.multiplayer_peer = peer

func move_camera():
	camera.offset.x = 0

func _process(delta: float) -> void:
	for _bullet in bullets.get_children():
		_bullet.global_position += _bullet.direction * _bullet.speed * delta * 100

func _ready() -> void:
	shot.connect(_shot)

func _shot(_bullet: bullet):
	bullets.add_child(_bullet, true)
	_bullet.global_position = _bullet.starting_position
