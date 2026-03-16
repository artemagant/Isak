extends CharacterBody2D

var direction: Vector2 = Vector2(0, 0)
var shoot_direction: = Vector2(0, 0)
var shoot_button: = Vector4.ZERO
var speed: = 2.5
var speed_mult: = 100
var cooldown: = 1.0

var can_shoot = true

@onready var animation := $Bottom
@onready var head := $Bullet_Spawner/Head
@onready var bullet_cooldown: = $Bullet_Cooldown

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
	
	if shoot_button == Vector4.ZERO:
		head.play("Down")
	shoot()
	#endregion
func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * speed_mult * delta
	move_and_slide()

func shoot():
	if shoot_button != Vector4.ZERO and can_shoot:
		can_shoot = false
		bullet_cooldown.start()


func _on_bullet_cooldown_timeout() -> void:
	can_shoot = true
