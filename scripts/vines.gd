extends Area2D

var currentScale: float = 0.0
var targetScale = 9.4
var playerInside = false
var painFactor = 5
var timePassedSinceDamage = 100
var killing = false
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentScale = lerp(currentScale,targetScale,delta*2.0)
	if abs(currentScale - targetScale) < 0.05:
		currentScale = targetScale
		set_process(false)
	scale = Vector2(currentScale, currentScale)
	if killing && currentScale == 0:
		queue_free()
	

func _physics_process(delta):
	timePassedSinceDamage += delta
	if (timePassedSinceDamage >= 0.5) && playerInside:
		timePassedSinceDamage = 0
		var progress_bar = player.find_child("ProgressBar")
		if progress_bar:
			progress_bar.decrease_value(painFactor)


func _on_body_entered(body):
	playerInside = true
	player = body


func _on_body_exited(body):
	playerInside = false


func kill():
	killing = true
	targetScale = 0.0
	set_process(true)
