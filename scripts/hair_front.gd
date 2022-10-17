tool
extends Sprite

enum Sprites {NONE,FEMALE01,FEMALE02,FEMALE03,FEMALE04,FEMALE05,FEMALE06,FEMALE07,
FEMALE08,FEMALE09,FEMALE10,FEMALE11,FEMALE12,MALE01,MALE02,MALE03,
EAR_COVER01,EAR_COVER02,EAR_COVER03,EAR_COVER04}
const FILES = {
	Sprites.FEMALE01:"res://images/hair/front/female01.png",
	Sprites.FEMALE02:"res://images/hair/front/female02.png",
	Sprites.FEMALE03:"res://images/hair/front/female03.png",
	Sprites.FEMALE04:"res://images/hair/front/female04.png",
	Sprites.FEMALE05:"res://images/hair/front/female05.png",
	Sprites.FEMALE06:"res://images/hair/front/female06.png",
	Sprites.FEMALE07:"res://images/hair/front/female07.png",
	Sprites.FEMALE08:"res://images/hair/front/female08.png",
	Sprites.FEMALE09:"res://images/hair/front/female09.png",
	Sprites.FEMALE10:"res://images/hair/front/female10.png",
	Sprites.FEMALE11:"res://images/hair/front/female11.png",
	Sprites.FEMALE12:"res://images/hair/front/female12.png",
	Sprites.MALE01:"res://images/hair/front/male01.png",
	Sprites.MALE02:"res://images/hair/front/male02.png",
	Sprites.MALE03:"res://images/hair/front/male03.png",
	Sprites.EAR_COVER01:"res://images/hair/front/ear_cover01.png",
	Sprites.EAR_COVER02:"res://images/hair/front/ear_cover02.png",
	Sprites.EAR_COVER03:"res://images/hair/front/ear_cover03.png",
	Sprites.EAR_COVER04:"res://images/hair/front/ear_cover04.png",
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
	$"../FrontShadow".texture = new_texture
	return true
