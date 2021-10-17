tool
extends Sprite

enum Sprites {NONE,BEARD01,BEARD02,BEARD03,BEARD04,BEARD05,MOUSTACHE}
const FILES = {
	Sprites.BEARD01:"res://images/beard/beard01.png",
	Sprites.BEARD02:"res://images/beard/beard02.png",
	Sprites.BEARD03:"res://images/beard/beard03.png",
	Sprites.BEARD04:"res://images/beard/beard04.png",
	Sprites.BEARD05:"res://images/beard/beard05.png",
	Sprites.MOUSTACHE:"res://images/beard/moustache.png",
}

export(Sprites) var sprite:= Sprites.NONE setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		$Shadow.texture = null
		return true
	var path: String = FILES[value].split(".")[0]
	var ending: String = FILES[value].split(".")[1]
	var new_texture:= load(path+"."+ending)
	if new_texture==null:
		printt(FILES[value]+"."+ending+" not found!")
		return false
	sprite = value
	texture = new_texture
	if !is_inside_tree():
		return false
	new_texture = load(path+"_shadow."+ending)
	if new_texture==null:
		$Shadow.texture = null
	else:
		$Shadow.texture = new_texture
	return true
