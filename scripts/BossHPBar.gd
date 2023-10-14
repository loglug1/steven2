extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

func set_bar_value(value_to_set):
	value = value_to_set
	if $Timer.is_stopped():
		$Timer.start()

func _on_timer_timeout():
	set_process(true)

func _process(delta):
	$ProgressBar2.value = lerp($ProgressBar2.value, value, 0.1)
	if($ProgressBar2.value - value <= 0.5):
		$ProgressBar2.value = value
		set_process(false)
	is_boss_dead()


func is_boss_dead():
	if(value <= 0):
		get_tree().change_scene_to_file("res://scenes/victory_screen.tscn")
		
func decrease_value(amount):
	set_bar_value(value - amount)
