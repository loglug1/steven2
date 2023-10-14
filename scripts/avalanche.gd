extends Node2D

var speed = 800
var direction = Vector2.DOWN
var strength = 100

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
		progress_bar.decrease_value(strength)


func _on_screen_exited():
	queue_free()
