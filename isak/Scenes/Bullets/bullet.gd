extends Area2D
class_name bullet
enum Levels {
	Small,
	Well,
	Medium,
	Big
}


@export var damage: = 1.0
@export var collision_radiuses: = [0.00, 0.00, 0.00, 0.00]
@export var speed: = 0.0
@export var can_piarce: = false
var type: = Levels.Big
@onready var collision: = $CollisionShape2D
@onready var animations: = $AnimatedSprite2D
var direction: = Vector2.ZERO
var starting_position: Vector2

func _ready() -> void:
	collision.shape.radius = collision_radiuses[type]
	animations.play(Levels.find_key(type))
