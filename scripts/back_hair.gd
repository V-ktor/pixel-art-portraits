tool
extends Sprite

enum Sprites {NONE,SHORT01,MEDIUM01,MEDIUM02,MEDIUM03,LONG01,LONG02,LONG03,
RIGHT01,CURLY01,PIGTAILS01}
const FILES = {
	Sprites.SHORT01:"res://images/hair/back/short01.png",
	Sprites.MEDIUM01:"res://images/hair/back/medium01.png",
	Sprites.MEDIUM02:"res://images/hair/back/medium02.png",
	Sprites.MEDIUM03:"res://images/hair/back/medium03.png",
	Sprites.LONG01:"res://images/hair/back/long01.png",
	Sprites.LONG02:"res://images/hair/back/long02.png",
	Sprites.LONG03:"res://images/hair/back/long03.png",
	Sprites.RIGHT01:"res://images/hair/back/right01.png",
	Sprites.CURLY01:"res://images/hair/back/curly01.png",
	Sprites.PIGTAILS01:"res://images/hair/back/pigtails01.png",
}

export(Sprites) var sprite:= Sprites.SHORT01 setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		return true
	var path: String = FILES[value].split(".")[0]
	var ending: String = FILES[value].split(".")[1]
	var new_texture:= load(path+"."+ending)
	if new_texture==null:
		printt(path+"."+ending+" not found!")
		return false
	sprite = value
	texture = new_texture
	return true
