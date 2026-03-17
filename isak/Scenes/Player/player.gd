extends CharacterBody2D

var direction: Vector2 = Vector2(0, 0)
var shoot_direction: = Vector2(0, 0)
var shoot_button: = Vector4.ZERO
var speed: = 2.5
var speed_mult: = 100


var can_shoot = true

var damage: = 2
var bullet_speed: = 5.0
var bullet_type: = 1
var bullets_cooldown: = 1.0

@onready var animation := $Bottom
@onready var head := $Head
@onready var bullet_cooldown: = $Bullet_Cooldown
@onready var game: = $".".get_parent()
@onready var bullets: = game.get_child(0)
@onready var bullet_spawner: = $Bullet_Spawner
func _ready() -> void:
	bullet_cooldown.wait_time = bullets_cooldown
func _input(event: InputEvent) -> void:
	#region Move
	if event.is_action_pressed("Left"):
		direction.x += -1
		animation.flip_h = false
		animation.sprite_frames.set_animation_speed("Move_Run", max(speed, 2))
		animation.play("Move_Run")
	if event.is_action_pressed("Down"):
		direction.y += 1
		animation.sprite_frames.set_animation_speed("Move_Run",  max(speed, 2))
		animation.play("Move_Run")
	if event.is_action_pressed("Right"):
		direction.x += 1
		animation.flip_h = true
		animation.sprite_frames.set_animation_speed("Move_Run",  max(speed, 2))
		animation.play("Move_Run")
	if event.is_action_pressed("up"):
		direction.y += -1
		animation.sprite_frames.set_animation_speed("Move_Run", max(speed, 2))
		animation.play("Move_Run")
	
	if event.is_action_released("Left"):
		direction.x -= -1
	if event.is_action_released("Down"):
		direction.y -= 1
	if event.is_action_released("Right"):
		direction.x -= 1
	if event.is_action_released("up"):
		direction.y -= -1
	
	if direction == Vector2(0, 0):
		animation.flip_h = false
		animation.play("Idle")
	else:
		if direction.x == 1:
			animation.flip_h = false
			animation.sprite_frames.set_animation_speed("Move_Run", max(speed, 2))
			animation.play("Move_Run")
		if direction.x == -1:
			animation.flip_h = true
			animation.sprite_frames.set_animation_speed("Move_Run", max(speed, 2))
			animation.play("Move_Run")
	#endregion
	#region Attak
	if event.is_action_pressed("Shoot_Down"):
		shoot_button.x = 1
		#shoot_direction = Vector2(0, -1)
	if event.is_action_pressed("Shoot_Up"):
		shoot_button.y = 1
		#shoot_direction = Vector2(0, 1)
	if event.is_action_pressed("Shoot_Left"):
		shoot_button.z = 1
		#shoot_direction = Vector2(-1, 0)
	if event.is_action_pressed("Shoot_Right"):
		shoot_button.w = 1
		#shoot_direction = Vector2(1, 0)
	
	if event.is_action_released("Shoot_Down"):
		shoot_button.x = 0
	if event.is_action_released("Shoot_Up"):
		shoot_button.y = 0
	if event.is_action_released("Shoot_Left"):
		shoot_button.z = 0
	if event.is_action_released("Shoot_Right"):
		shoot_button.w = 0
	
	#if shoot_button == Vector4.ZERO:
	#	head.play("Down")
	shoot()
	#endregion
func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * speed_mult * delta
	move_and_slide()

func shoot():
	if shoot_button != Vector4.ZERO and can_shoot:
		can_shoot = false
		var rand_dir = randi_range(0, 3)
		while shoot_button[rand_dir] == 0:
			rand_dir = randi_range(0, 3)
		var _bullet = load("res://Scenes/Bullets/bullet.tscn").instantiate()
		_bullet.damage = damage
		_bullet.speed = bullet_speed
		_bullet.starting_position = bullet_spawner.global_position
		_bullet.type = bullet_type
		match rand_dir:
			0: 
				head.play("Down")
				head.z_index = 1
				_bullet.direction = Vector2(0, 1)
			1: 
				head.play("Up")
				head.z_index = 3
				_bullet.direction = Vector2(0, -1)
			2: 
				head.play("Left")
				head.z_index = 1
				_bullet.direction = Vector2(-1, 0)
			3: 
				head.play("Right")
				head.z_index = 1
				_bullet.direction = Vector2(1, 0)
		game.emit_signal("shot", _bullet)
		bullet_cooldown.start()


func _on_bullet_cooldown_timeout() -> void:
	can_shoot = true
	bullet_cooldown.wait_time = bullets_cooldown
	shoot()
