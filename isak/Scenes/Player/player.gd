extends CharacterBody2D

var direction: Vector2 = Vector2(0, 0)

var speed = 350

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Left"):
		direction.x += -1
	if event.is_action_pressed("Down"):
		direction.y += 1
	if event.is_action_pressed("Right"):
		direction.x += 1
	if event.is_action_pressed("up"):
		direction.y += -1
	
	if event.is_action_released("Left"):
		direction.x -= -1
	if event.is_action_released("Down"):
		direction.y -= 1
	if event.is_action_released("Right"):
		direction.x -= 1
	if event.is_action_released("up"):
		direction.y -= -1
		
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	move_and_slide()
