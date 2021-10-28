tool
extends Sprite

enum Sprites {NONE,FEMALE01,FEMALE02,FEMALE03,FEMALE04,FEMALE06,FEMALE07,FEMALE08,FEMALE09,FEMALE10,\
PONYTAIL01,MALE01,MALE02,MALE03,MALE04,MALE05}
const Male = Sprites.MALE01
const Female = Sprites.FEMALE01
const FILES = {
	Sprites.FEMALE01:"res://images/hair/base/female01.png",
	Sprites.FEMALE02:"res://images/hair/base/female02.png",
	Sprites.FEMALE03:"res://images/hair/base/female03.png",
	Sprites.FEMALE04:"res://images/hair/base/female04.png",
	Sprites.FEMALE06:"res://images/hair/base/female06.png",
	Sprites.FEMALE07:"res://images/hair/base/female07.png",
	Sprites.FEMALE08:"res://images/hair/base/female08.png",
	Sprites.FEMALE09:"res://images/hair/base/female09.png",
	Sprites.FEMALE10:"res://images/hair/base/female10.png",
	Sprites.PONYTAIL01:"res://images/hair/base/ponytail01.png",
	Sprites.MALE01:"res://images/hair/base/male01.png",
	Sprites.MALE02:"res://images/hair/base/male02.png",
	Sprites.MALE03:"res://images/hair/base/male03.png",
	Sprites.MALE04:"res://images/hair/base/male04.png",
	Sprites.MALE05:"res://images/hair/base/male05.png",
}

export(Sprites) var sprite:= Sprites.FEMALE01 setget set_sprite

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
		printt(path+"."+ending+" not found!")
		return false
	sprite = value
	texture = new_texture
	if !is_inside_tree():
		return false
	new_texture = load(path+"_shadow."+ending)
	if new_texture==null:
		printt(path+"_shadow."+ending+" not found!")
	else:
		$Shadow.texture = new_texture
	return true
