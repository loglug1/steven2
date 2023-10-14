extends StaticBody2D

var bulletScene = preload("res://scenes/tire.tscn")
var timeSinceLastBullet = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	timeSinceLastBullet += delta
	if timeSinceLastBullet >= 0.25:
		var instance = bulletScene.instantiate()
		instance.scale = Vector2(0.25,0.25)
		instance.position = position
		instance.z_index = z_index - 1
		add_sibling(instance)
		timeSinceLastBullet = 0
