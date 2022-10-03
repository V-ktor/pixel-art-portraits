tool
extends Sprite

enum Sprites {NONE,CAT_EARS01,FOX_EARS01,FOX_EARS02,DOG_EARS01,BEAR_EARS01}
const FILES = {
	Sprites.CAT_EARS01:"res://images/ears/cat_ears01.png",
	Sprites.FOX_EARS01:"res://images/ears/fox_ears01.png",
	Sprites.FOX_EARS02:"res://images/ears/fox_ears02.png",
	Sprites.DOG_EARS01:"res://images/ears/dog_ears01.png",
	Sprites.BEAR_EARS01:"res://images/ears/bear_ears01.png",
}

export(Sprites) var sprite:= Sprites.NONE setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		$EarFluff.texture = null
		$EarSkin.texture = null
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
	
	new_texture = load(path+"_fluff."+ending)
	$EarFluff.texture = new_texture
	new_texture = load(path+"_skin."+ending)
	$EarSkin.texture = new_texture
	return true
