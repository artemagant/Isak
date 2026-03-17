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
var type: Levels
@onready var collision: = $CollisionShape2D
@onready var animations: = $AnimatedSprite2D
var direction: = Vector2.ZERO
var starting_position: Vector2

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	var config = $MultiplayerSynchronizer.replication_config
	if config == null:
		config = SceneReplicationConfig.new()
		$MultiplayerSynchronizer.replication_config = config
	
	# 2. Формируем путь к свойству (относительно синхронизатора)
	# "." означает текущий узел (родитель синхронизатора), "global_position" - само свойство
	var property_path = ".:global_position"
	
	# 3. Добавляем, если его еще нет
	if not config.has_property(property_path):
		config.add_property(property_path)
		
		# 4. ОБЯЗАТЕЛЬНО: ставим режим репликации, иначе данные не полетят
		# REPLICATION_MODE_ALWAYS подходит для пуль, чтобы летели плавно
		config.property_set_replication_mode(property_path, SceneReplicationConfig.REPLICATION_MODE_ALWAYS)
	collision.shape.radius = collision_radiuses[type]
	animations.play(Levels.find_key(type))
