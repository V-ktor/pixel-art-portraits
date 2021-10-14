tool
extends Sprite

enum Sprites {NEUTRAL01,NEUTRAL02,SMALL,SMILE01,SMILE02,GRIN01,GRIN02,SAD01,SAD02,O}
const FILES = {
	Sprites.NEUTRAL01:"res://images/mouth/neutral01.png",
	Sprites.NEUTRAL02:"res://images/mouth/neutral02.png",
	Sprites.SMALL:"res://images/mouth/small.png",
	Sprites.SMILE01:"res://images/mouth/smile01.png",
	Sprites.SMILE02:"res://images/mouth/smile02.png",
	Sprites.GRIN01:"res://images/mouth/grin01.png",
	Sprites.GRIN02:"res://images/mouth/grin02.png",
	Sprites.SAD01:"res://images/mouth/sad01.png",
	Sprites.SAD02:"res://images/mouth/sad02.png",
	Sprites.O:"res://images/mouth/O.png",
}

export(Sprites) var sprite:= Sprites.NEUTRAL01 setget set_sprite

func set_sprite(value: int) -> bool:
	var new_texture:= load(FILES[value])
	if new_texture==null:
		printt(FILES[value]+" not found!")
		return false
	sprite = value
	texture = new_texture
	return true
