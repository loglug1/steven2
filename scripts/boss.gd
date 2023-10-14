extends StaticBody2D

var bulletScene = preload("res://scenes/snowball.tscn")
var avalancheScene = preload("res://scenes/avalanche.tscn")
var timeSinceLastBullet = 100
var currentAttack = 2
var radialAttackModifier = PI/4
var hoverAnimationParameter = 0
var avalancheOnSides = false
@onready var baseLocation = position

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AttackChangeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hoverAnimationParameter += 0.02
	position = baseLocation + Vector2(sin(hoverAnimationParameter),cos(hoverAnimationParameter)) * 5

func _physics_process(delta):
	if currentAttack == 0:
		#target player directly
		timeSinceLastBullet += delta
		if timeSinceLastBullet >= 0.54:
			target_attack()
			timeSinceLastBullet = 0
	if currentAttack == 1:
		#shoot in rotation
		timeSinceLastBullet += delta
		if timeSinceLastBullet >= 0.2:
			rotation_attack()
			timeSinceLastBullet = 0
	if currentAttack == 2:
		#avalanche attack
		timeSinceLastBullet += delta
		if timeSinceLastBullet >= 1.62 :
			avalanche_attack()
			timeSinceLastBullet = 0
	if currentAttack == 3:
		#shoot everywhere besides mouse pointer
		timeSinceLastBullet += delta
		if timeSinceLastBullet >= 0.5:
			big_bad_attack()
			timeSinceLastBullet = 0
			


func spawn_projectile(direction):
	var instance = bulletScene.instantiate()
	instance.z_index = z_index - 1
	instance.position = position
	instance.direction = direction
	add_sibling(instance)
	return instance
	

func spawn_avalanche(x):
	var instance = avalancheScene.instantiate()
	instance.position = Vector2(x, -265)
	instance.z_index = z_index - 1
	add_sibling(instance)
	return instance


func avalanche_attack():
	if avalancheOnSides:
		spawn_avalanche(450)
		spawn_avalanche(1470)
		avalancheOnSides = false
	else:
		spawn_avalanche(960)
		avalancheOnSides = true
	

func target_attack():
	#target player directly
	spawn_projectile(get_target_attack_direction())
	

func get_target_attack_direction():
	var player_node = get_node("/root/gamescene/CharacterBody2D")
	if player_node:
		return global_position.direction_to(player_node.position)
	else:
		return get_mouse_attack_direction()
		
		
func mouse_attack():
	#target mouse pointer
	spawn_projectile(get_mouse_attack_direction())

		
func get_mouse_attack_direction():
	var returnDirection = global_position.direction_to(get_global_mouse_position())
	#returnDirection.y = abs(returnDirection.y)
	return returnDirection
	
	
func rotation_attack():
	#shoot in rotation
	var projectile
	for direction in get_radial_attack_directions():
		projectile = spawn_projectile(direction)
		projectile.indestructible = true
		projectile.speed = projectile.speed - 200
	
	
func get_radial_attack_directions():
	radialAttackModifier += 0.25
	return [
		Vector2(cos(radialAttackModifier),sin(radialAttackModifier)),
		Vector2(cos(radialAttackModifier + PI/2),sin(radialAttackModifier + PI/2)),
		Vector2(cos(radialAttackModifier + PI),sin(radialAttackModifier + PI)),
		Vector2(cos(radialAttackModifier + 3*PI/2),sin(radialAttackModifier + 3*PI/2)),
		]
		
		
func big_bad_attack():
	#shoot everywhere besides mouse pointer
	for direction in get_big_bad_attack():
		spawn_projectile(direction)
		
		
func get_big_bad_attack():
	var returnArr = []
	var mouseDirection = get_mouse_attack_direction()
	for t in range(20):
		var possibleDirection = Vector2(cos(t*PI/10),sin(t*PI/10))
		##	if abs(possibleDirection.angle_to(mouseDirection)) >= PI/8:
		returnArr.append(possibleDirection)
	return returnArr


func change_attack():
	currentAttack = randi() % 4
	timeSinceLastBullet = 100


func _on_attack_change_timer_timeout():
	change_attack()
	$AttackChangeTimer.start()
