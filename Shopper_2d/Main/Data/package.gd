extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Collision.set_deferred("disabled", true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_hold_mode(is_being_hold):
	if is_being_hold:
		$Collision.set_deferred("disabled", true)
	else:
		$Collision.set_deferred("disabled", false)