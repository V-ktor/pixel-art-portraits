tool
extends Sprite

enum Sprites {NONE,FEMALE01,FEMALE02,FEMALE03,FEMALE04,FEMALE05,FEMALE06,FEMALE07,FEMALE08,FEMALE09,FEMALE10,FEMALE11}
const FILES = {
	Sprites.FEMALE01:"res://images/cloths/female01.png",
	Sprites.FEMALE02:"res://images/cloths/female02.png",
	Sprites.FEMALE03:"res://images/cloths/female03.png",
	Sprites.FEMALE04:"res://images/cloths/female04.png",
	Sprites.FEMALE05:"res://images/cloths/female05.png",
	Sprites.FEMALE06:"res://images/cloths/female06.png",
	Sprites.FEMALE07:"res://images/cloths/female07.png",
	Sprites.FEMALE08:"res://images/cloths/female08.png",
	Sprites.FEMALE09:"res://images/cloths/female09.png",
	Sprites.FEMALE10:"res://images/cloths/female10.png",
	Sprites.FEMALE11:"res://images/cloths/female11.png",
}

export(Sprites) var sprite:= Sprites.FEMALE01 setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		$Shadow.texture = null
		$Secondary.texture = null
		$Details.texture = null
		return true
	var path: String = FILES[value].split(".")[0]
	var ending: String = FILES[value].split(".")[1]
	var new_texture:= load(path+"_primary."+ending)
	if new_texture==null:
		printt(FILES[value]+"_primary."+ending+" not found!")
		return false
	sprite = value
	texture = new_texture
	if !is_inside_tree():
		return false
	new_texture = load(path+"_secondary."+ending)
	if new_texture==null:
		$Secondary.texture = null
	else:
		$Secondary.texture = new_texture
	new_texture = load(path+"_details."+ending)
	if new_texture==null:
		$Details.texture = null
	else:
		$Details.texture = new_texture
	new_texture = load(path+"_shadow."+ending)
	if new_texture==null:
		$Shadow.texture = null
	else:
		$Shadow.texture = new_texture
	return true
