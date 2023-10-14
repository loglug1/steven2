extends Node2D

var vineScene = preload("res://scenes/vines.tscn")

var currentlySpawned = false
var vineInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize()
	reset_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_growth_time():
	return randi() % 40 + 10
	
	
func get_decay_time():
	return 5

func reset_timer():
	if currentlySpawned:
		$Timer.wait_time = get_decay_time()
	else:
		$Timer.wait_time = get_growth_time()
	$Timer.start()


func _on_timer_timeout():
	if currentlySpawned:
		vineInstance.kill()
		currentlySpawned = false
	else:
		vineInstance = vineScene.instantiate()
		vineInstance.targetScale = scale.x
		vineInstance.z_index = z_index
		vineInstance.position = position
		add_sibling(vineInstance)
		currentlySpawned = true
	reset_timer()


func _on_ready():
	$Timer.stop()
	$Timer.wait_time = 12
	$Timer.start()
