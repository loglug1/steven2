extends Node2D

var speed = 1500
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	#goes towards the player to start
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	#damage player
	var progress_bar = body.find_child("ProgressBar")
	if progress_bar:
		progress_bar.decrease_value(50)
	queue_free()


func _on_screen_exited():
	queue_free()


func _on_area_entered(_area):
	queue_free()
