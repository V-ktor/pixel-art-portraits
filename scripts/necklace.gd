tool
extends Sprite

enum Sprites {NONE,NECKLACE,COLLAR,TIE,SCARF}
const FILES = {
	Sprites.NECKLACE:"res://images/neck/necklace.png",
	Sprites.COLLAR:"res://images/neck/collar.png",
	Sprites.TIE:"res://images/neck/tie.png",
	Sprites.SCARF:"res://images/neck/scarf.png",
}

export(Sprites) var sprite:= Sprites.NONE setget set_sprite

func set_sprite(value: int) -> bool:
	if value==Sprites.NONE:
		sprite = value
		texture = null
		return true
	var new_texture:= load(FILES[value])
	if new_texture==null:
		printt(FILES[value]+" not found!")
		return false
	sprite = value
	texture = new_texture
	return true
