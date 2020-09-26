extends Node2D



func create_effect():
	var GrassEffect = load("res://Effects/Grasseffect.tscn")
	var grasseffect = GrassEffect.instance()
	var main = get_tree().current_scene
	main.add_child(grasseffect)
	grasseffect.global_position = global_position
	

#只需要一个_function

func _on_HurtBox_area_entered(area):
	create_effect()
	queue_free()

