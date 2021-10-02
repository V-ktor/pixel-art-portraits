tool
extends Sprite

enum Sprites {FEMALE01,FEMALE02,FEMALE03}
const FILES = {
	Sprites.FEMALE01:"res://images/body/female01.png",
	Sprites.FEMALE02:"res://images/body/female02.png",
	Sprites.FEMALE03:"res://images/body/female03.png",
}

export(Sprites) var sprite:= Sprites.FEMALE01 setget set_sprite

func set_sprite(value: int) -> bool:
	var new_texture:= load(FILES[value])
	if new_texture==null:
		printt(FILES[value]+" not found!")
		return false
	sprite = value
	texture = new_texture
	return true
