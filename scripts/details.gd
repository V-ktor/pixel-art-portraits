tool
extends Sprite

enum Sprites {NONE,DECORATION01}
const FILES = {
	Sprites.DECORATION01:"decoration01.png"
}

export(Sprites) var sprite:= Sprites.NONE setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		return true
	var path: String = get_parent().FILES[get_parent().Sprites.values()[get_parent().sprite]].split(".")[0]
	var name: String = FILES[value].split(".")[0]
	var ending: String = FILES[value].split(".")[1]
	var new_texture:= load(path+"_"+name+"."+ending)
	if new_texture==null:
		printt(path+"/"+name+"."+ending+" not found!")
		return false
	sprite = value
	texture = new_texture
	return true
