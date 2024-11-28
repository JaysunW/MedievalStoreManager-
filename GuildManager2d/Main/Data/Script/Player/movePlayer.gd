extends Node2D

@export var player : CharacterBody2D
@export var animation_component : Node2D

const SPEED = 25000.0
var last_move_direction = Vector2.DOWN

var can_move = true

func _physics_process(_delta):
	if can_move:
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		if direction:
			last_move_direction = direction
			player.velocity = direction * SPEED * _delta
			if abs(direction.y) > abs(direction.x):
				if direction.y > 0:
					animation_component.set_animation("walking")
				else:
					animation_component.set_animation("walking_back")
			else:
				animation_component.set_animation("walking_horizontal")
				animation_component.set_flip_h(direction.x < 0)
			animation_component.play_animation()
		else:
			player.velocity = Vector2.ZERO
			animation_component.stop_animation()
			#animation_component.set_animation("default")
		player.move_and_slide()

func _on_ui_stand_info_opened_stand_info():
	can_move = false

func _on_ui_stand_info_closed_stand_info():
	can_move = true
