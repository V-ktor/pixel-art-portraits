tool
extends Sprite

enum Sprites {SMALL01,SMALL02,NEUTRAL01,NEUTRAL02,LARGE01,LARGE02,POINTY01,POINTY02}
const FILES = {
	Sprites.SMALL01:"res://images/nose/small01.png",
	Sprites.SMALL02:"res://images/nose/small02.png",
	Sprites.NEUTRAL01:"res://images/nose/neutral01.png",
	Sprites.NEUTRAL02:"res://images/nose/neutral02.png",
	Sprites.LARGE01:"res://images/nose/large01.png",
	Sprites.LARGE02:"res://images/nose/large02.png",
	Sprites.POINTY01:"res://images/nose/pointy01.png",
	Sprites.POINTY02:"res://images/nose/pointy02.png",
}

export(Sprites) var sprite:= Sprites.SMALL01 setget set_sprite

func set_sprite(value: int) -> bool:
	var new_texture:= load(FILES[value])
	if new_texture==null:
		printt(FILES[value]+" not found!")
		return false
	sprite = value
	texture = new_texture
	return true
