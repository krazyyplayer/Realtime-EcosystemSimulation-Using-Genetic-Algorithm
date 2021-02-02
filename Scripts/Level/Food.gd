extends Area
var timer

func _ready():
	randomize()
	timer = get_tree().create_timer(rand_range(10,20))

func _process(delta):
	if timer.time_left <= 0.0:
		queue_free()


func _on_Food_body_entered(body):
	if(body.get_groups().find("Player")!=-1):
		var player = get_node(body.get_path())
		player.Regenerate(10)
		queue_free()
