extends Area2D

var direction = Vector2.ZERO
var speed = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_area_entered(_area):
	queue_free()


func _on_screen_exited():
	queue_free()


func _on_body_entered(body):
	#damage boss
	var progress_bar = body.find_child("ProgressBar")
	if progress_bar:
		progress_bar.decrease_value(10)
	queue_free()
