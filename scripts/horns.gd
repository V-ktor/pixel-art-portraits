tool
extends Sprite

enum Sprites {NONE,DRAGON01,MASSIVE01,LONG01}
const FILES = {
	Sprites.DRAGON01:"res://images/horns/dragon_horns01.png",
	Sprites.MASSIVE01:"res://images/horns/massive01.png",
	Sprites.LONG01:"res://images/horns/long01.png",
}

export(Sprites) var sprite:= Sprites.NONE setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
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
	return true
