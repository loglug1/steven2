extends Node2D

var speed = 2000
var target
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_global_mouse_position()
	direction = global_position.direction_to(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	print("Hit 'Player'")
	queue_free()
