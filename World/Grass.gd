extends Node2D

const GrassEffect = preload("res://Effects/Grasseffect.tscn")


func create_effect():
	var grasseffect = GrassEffect.instance()
	get_parent().add_child(grasseffect)
	grasseffect.global_position = global_position
	

#只需要一个_function

func _on_HurtBox_area_entered(area):
	create_effect()
	queue_free()

