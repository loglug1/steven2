extends Area2D

var direction
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
	queue_free()
