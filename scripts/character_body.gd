extends CharacterBody2D


const SPEED = 475.0
const JUMP_VELOCITY = -500.0
var ACCELERATION = 3
var jumpMax = 2
var jumpCounter = 0
var canHoldWall = true
var timeSpentWalling = 0
var timeSinceLastBullet = 0
var bulletScene = preload("res://scenes/fireball.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.25


func _physics_process(delta):	
	if (Input.is_action_pressed("aim_up") || Input.is_action_pressed("aim_down") || Input.is_action_pressed("aim_left") || Input.is_action_pressed("aim_right")):
		timeSinceLastBullet += delta
		if timeSinceLastBullet >= 0.25:
			var aimDirection = Vector2(Input.get_axis("aim_left","aim_right"), Input.get_axis("aim_up","aim_down"))
			if aimDirection.length() != 0:
				shoot_bullet(aimDirection)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if !is_on_floor():
		velocity.x = SPEED + ACCELERATION
	if ((is_on_floor() || is_on_wall()) && jumpCounter >= 2) :
		if (is_on_wall()) :
			jumpCounter = 1
		else :
			jumpCounter = 0
	if (is_on_floor() && position.y > 0) :
		if (Input.is_action_pressed("move_down")) :
			position.y += 5
	if (is_on_wall() && (Input.is_action_pressed("move_left") || (Input.is_action_pressed("move_right")))) :
		velocity.y = 0
		if(Input.is_action_pressed('move_right')) :
			velocity.x = -JUMP_VELOCITY * ACCELERATION
		if (Input.is_action_pressed('move_left')) :
			velocity.x = JUMP_VELOCITY * ACCELERATION
			
		
	# Handle Jump + double jump
	if Input.is_action_just_pressed("move_jump") and jumpCounter < jumpMax:
		velocity.y = JUMP_VELOCITY
		jumpCounter = jumpCounter + 1;

	# hard fall
	if Input.is_action_just_pressed("move_down") and !is_on_floor():
		velocity.y = -JUMP_VELOCITY + 250
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func shoot_bullet(direction):
	var instance = bulletScene.instantiate()
	instance.direction = direction
	instance.position = position
	instance.z_index = z_index - 1
	add_sibling(instance)
	timeSinceLastBullet = 0
