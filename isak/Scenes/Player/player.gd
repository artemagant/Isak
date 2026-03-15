extends CharacterBody2D

var direction: Vector2 = Vector2(0, 0)

var speed: = 2.5
var speed_mult: = 100
@onready var animation := $Bottom
func _input(event: InputEvent) -> void:
	
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
func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * speed_mult * delta
	move_and_slide()
