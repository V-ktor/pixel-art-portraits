tool
extends Sprite

enum Sprites {NONE,GLASSES01,GLASSES01_REFLECTION,GLASSES02,GLASSES02_REFLECTION,\
GLASSES03,GLASSES03_REFLECTION,GLASSES04,GLASSES04_REFLECTION,MONOCLE}
const FILES = {
	Sprites.GLASSES01:"res://images/glasses/glasses01.png",
	Sprites.GLASSES01_REFLECTION:"res://images/glasses/glasses01_reflection.png",
	Sprites.GLASSES02:"res://images/glasses/glasses02.png",
	Sprites.GLASSES02_REFLECTION:"res://images/glasses/glasses02_reflection.png",
	Sprites.GLASSES03:"res://images/glasses/glasses03.png",
	Sprites.GLASSES03_REFLECTION:"res://images/glasses/glasses03_reflection.png",
	Sprites.GLASSES04:"res://images/glasses/glasses04.png",
	Sprites.GLASSES04_REFLECTION:"res://images/glasses/glasses04_reflection.png",
	Sprites.MONOCLE:"res://images/glasses/monocle.png",
}

export(Sprites) var sprite:= Sprites.NONE setget set_sprite

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
		printt(FILES[value]+"."+ending+" not found!")
		return false
	sprite = value
	texture = new_texture
	if !is_inside_tree():
		return false
	new_texture = load(path+"_shadow."+ending)
	if new_texture==null:
		$Shadow.texture = null
	else:
		$Shadow.texture = new_texture
	return true
