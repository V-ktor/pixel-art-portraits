tool
extends Sprite

enum Sprites {FEMALE01,FEMALE02,FEMALE03,FLAT01,FLAT02,TALL01,CLOSED01,CLOSED02}
const FILES = {
	Sprites.FEMALE01:"res://images/eyes/female01.png",
	Sprites.FEMALE02:"res://images/eyes/female02.png",
	Sprites.FEMALE03:"res://images/eyes/female03.png",
	Sprites.FLAT01:"res://images/eyes/flat01.png",
	Sprites.FLAT02:"res://images/eyes/flat02.png",
	Sprites.TALL01:"res://images/eyes/tall01.png",
	Sprites.CLOSED01:"res://images/eyes/closed01.png",
	Sprites.CLOSED02:"res://images/eyes/closed02.png",
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
