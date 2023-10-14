extends CharacterBody2D


const SPEED = 475.0
const JUMP_VELOCITY = -500.0
var jumpMax = 2
var jumpCounter = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if (is_on_floor() && jumpCounter == 2) :
		jumpCounter = 0

	# Handle Jump + double jump
	if Input.is_action_just_pressed("move_jump") and jumpCounter < jumpMax:
		velocity.y = JUMP_VELOCITY
		jumpCounter = jumpCounter + 1;

	# hard fall
	if Input.is_action_just_pressed("move_down") and !is_on_floor():
		velocity.y = -JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
