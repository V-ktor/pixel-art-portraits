tool
extends Sprite

enum Sprites {FEMALE01,FEMALE02,FEMALE03,FLAT01,FLAT02,TALL01,\
CLOSED01,CLOSED02,CLOSED03,CLOSED04,MALE01,MALE02,MALE03,ANGLED01}
const Male = Sprites.CLOSED03
const Female = Sprites.FEMALE01
const FILES = {
	Sprites.FEMALE01:"res://images/eyes/female01.png",
	Sprites.FEMALE02:"res://images/eyes/female02.png",
	Sprites.FEMALE03:"res://images/eyes/female03.png",
	Sprites.FLAT01:"res://images/eyes/flat01.png",
	Sprites.FLAT02:"res://images/eyes/flat02.png",
	Sprites.TALL01:"res://images/eyes/tall01.png",
	Sprites.CLOSED01:"res://images/eyes/closed01.png",
	Sprites.CLOSED02:"res://images/eyes/closed02.png",
	Sprites.CLOSED03:"res://images/eyes/closed03.png",
	Sprites.CLOSED04:"res://images/eyes/closed04.png",
	Sprites.MALE01:"res://images/eyes/male01.png",
	Sprites.MALE02:"res://images/eyes/male02.png",
	Sprites.MALE03:"res://images/eyes/male03.png",
	Sprites.ANGLED01:"res://images/eyes/angled01.png",
}

export(Sprites) var sprite:= Sprites.FEMALE01 setget set_sprite

func set_sprite(value: int) -> bool:
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
		$"../EyeShadow".texture = null
	else:
		$"../EyeShadow".texture = new_texture
	return true
