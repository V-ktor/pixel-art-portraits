tool
extends Sprite

enum Sprites {NONE,FEMALE01,FEMALE02,FEMALE03,FEMALE04,FEMALE05,FEMALE06,FEMALE07,CAT_EARS}
const FILES = {
	Sprites.FEMALE01:"res://images/hair/front/female01.png",
	Sprites.FEMALE02:"res://images/hair/front/female02.png",
	Sprites.FEMALE03:"res://images/hair/front/female03.png",
	Sprites.FEMALE04:"res://images/hair/front/female04.png",
	Sprites.FEMALE05:"res://images/hair/front/female05.png",
	Sprites.FEMALE06:"res://images/hair/front/female06.png",
	Sprites.FEMALE07:"res://images/hair/front/female07.png",
	Sprites.CAT_EARS:"res://images/hair/front/cat_ears.png",
}

export(Sprites) var sprite:= Sprites.FEMALE01 setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		if is_inside_tree():
			$"../FrontShadow".texture = null
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
		$"../FrontShadow".texture = null
	else:
		$"../FrontShadow".texture = new_texture
	return true
