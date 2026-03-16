extends Node2D

signal shot

@onready var bullets: = $Bullets

func _process(delta: float) -> void:
	for _bullet in bullets.get_children():
		_bullet.global_position += _bullet.direction * _bullet.speed * delta * 100

func _ready() -> void:
	shot.connect(_shot)

func _shot(_bullet: bullet):
	bullets.add_child(_bullet)
	_bullet.global_position = _bullet.starting_position
	_bullet.name = "bullet"
