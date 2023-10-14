extends StaticBody2D

var bulletScene = preload("res://scenes/snowball.tscn")
var timeSinceLastBullet = 0
var currentAttack = 1
var radialAttackModifier = PI/4
var hoverAnimationParameter = 0
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
		if timeSinceLastBullet >= 0.4:
			var instance = bulletScene.instantiate()
			instance.direction = get_target_attack_direction()
			instance.position = position
			instance.z_index = z_index - 1
			add_sibling(instance)
			timeSinceLastBullet = 0
	if currentAttack == 1:
		#shoot in rotation
		timeSinceLastBullet += delta
		if timeSinceLastBullet >= 0.2:
			for direction in get_radial_attack_directions():
				#bullet1
				var instance = bulletScene.instantiate()
				instance.direction = direction
				instance.position = position
				instance.z_index = z_index - 1
				add_sibling(instance)
			timeSinceLastBullet = 0
	if currentAttack == 2:
		print("2")
	if currentAttack == 3:
		print("3")
			

func get_target_attack_direction():
	var player_node = get_node("/root/gamescene/CharacterBody2D")
	var target
	if player_node:
		target = player_node.position
	else:
		target = get_global_mouse_position()
	return global_position.direction_to(target)
	
	
func get_radial_attack_directions():
	radialAttackModifier += 0.25
	return [
		Vector2(cos(radialAttackModifier),sin(radialAttackModifier)),
		Vector2(cos(radialAttackModifier + PI/2),sin(radialAttackModifier + PI/2)),
		Vector2(cos(radialAttackModifier + PI),sin(radialAttackModifier + PI)),
		Vector2(cos(radialAttackModifier + 3*PI/2),sin(radialAttackModifier + 3*PI/2)),
		]


func change_attack():
	currentAttack = randi() % 4


func _on_attack_change_timer_timeout():
	change_attack()
	$AttackChangeTimer.start()
