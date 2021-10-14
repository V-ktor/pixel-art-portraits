tool
extends Sprite

enum Sprites {FEMALE01,FEMALE02,FEMALE03,FEMALE_ANDROID,MALE01,MALE02}
const Male = Sprites.MALE01
const Female = Sprites.FEMALE01
const FILES = {
	Sprites.FEMALE01:"res://images/body/female01.png",
	Sprites.FEMALE02:"res://images/body/female02.png",
	Sprites.FEMALE03:"res://images/body/female03.png",
	Sprites.FEMALE_ANDROID:"res://images/body/female_android.png",
	Sprites.MALE01:"res://images/body/male01.png",
	Sprites.MALE02:"res://images/body/male02.png",
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
