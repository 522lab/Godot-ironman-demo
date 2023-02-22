extends Sprite #the script properties is inheritant of Sprite

var boost_speed = 1000
var normal_speed = 400
var current_speed = normal_speed
var drag = 0.1 # drag coefficient, the less the slow is turning

var direction := Vector2.ZERO
var velocity := Vector2.ZERO
var desired_velocity := Vector2.ZERO
var turning_velocity := Vector2.ZERO

func _process(delta: float) -> void:
	# get user input
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	# normalized vector to not over than 1
	direction = direction.normalized()

	# listen to signal, apply speed and set timer
	if Input.is_action_just_pressed("boost"):
		get_node("Timer").start()
		current_speed = boost_speed

	## smooth the turning movement
	# more velocity > more distance and time
	desired_velocity = current_speed * direction
	turning_velocity = desired_velocity - velocity
	velocity += turning_velocity * drag
	
	position += velocity * delta
	
	# rotate the sprite when direction changed
	if direction:
		rotation = velocity.angle()

# reset the speed after timeout
func _on_Timer_timeout() -> void:
	current_speed = normal_speed
