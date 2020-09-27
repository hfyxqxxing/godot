extends Area2D


#export 真好用
export(bool) var show_hit = true

const HitEffect = preload("res://Effects/HitEffect.tscn")



func _on_HurtBox_area_entered(area):
	if show_hit:
		var atkeffect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(atkeffect)
		atkeffect.global_position = global_position
