extends Control

const TYPES = ["Female","Male"]
const PARTS = ["Body","Cloths","Cloths/Neck","Mouth","Nose","Hair/Eyes","Hair/Brows","Hair","Hair/Front","BackHair","Hair/Details"]
const COLORS = [
	["#ffe6e2","#996b88","#4c335c"],
	["#cc8665","#4c335c","#0f0814"],
	["#e0f2f3","#6a7587","#181420"],
	["#eecc8c","#8c2a2a","#2a1722"],
	["#9682d9","#4c2f93","#381e78"],
	["#bf5656","#590e0e","#3e111a"],
	["#d099c8","#4c335c","#2a1722"],
	["#4b4b60","#181420","#181420"],
	["#a4dddb","#253a5e","#22264f"],
	["#788bbd","#253579","#22264f"],
	["#d0da91","#314829","#0a1a0d"],
	["#fdf5cc","#cc8665","#644133"],
	["#eecc8c","#644133","#2a1722"],
]
const SHADOW_COLORS = [
	"#2a1722","#22264f","#181420","#4c335c","#0a1a0d"
]
const WHITE_COLOR = "#ffffff"
const BLACK_COLOR = "#0f0814"
const BUFFER_SIZE = 128

var buffer:= []
var buffer_index:= 0
var type: String = TYPES[0]

onready var portrait:= $Viewport/Portrait
onready var skin_material: ShaderMaterial = $Viewport/Portrait/Body.material
onready var primary_material: ShaderMaterial = $Viewport/Portrait/Cloths.material
onready var secondary_material: ShaderMaterial = $Viewport/Portrait/Cloths/Secondary.material
onready var detail_material: ShaderMaterial = $Viewport/Portrait/Cloths/Details.material
onready var eye_material: ShaderMaterial = $Viewport/Portrait/Hair/Eyes.material
onready var hair_material: ShaderMaterial = $Viewport/Portrait/Hair.material


func _randomize():
	var skin_color = max(randi()%3-1, 0)
	var primary_color = randi()%COLORS.size()
	var secondary_color = randi()%COLORS.size()
	var eye_color = randi()%COLORS.size()
	var hair_color = randi()%COLORS.size()
	var shadow_color = SHADOW_COLORS[randi()%SHADOW_COLORS.size()]
	var data:= {
		"white_color":Color(WHITE_COLOR),
		"black_color":Color(BLACK_COLOR),
		"skin_light_color":Color(COLORS[skin_color][0]),
		"skin_dark_color":Color(COLORS[skin_color][1]),
		"skin_shadow_color":Color(COLORS[skin_color][2]),
		"primary_light_color":Color(COLORS[primary_color][0]),
		"primary_dark_color":Color(COLORS[primary_color][1]),
		"primary_shadow_color":Color(COLORS[primary_color][2]),
		"secondary_light_color":Color(COLORS[secondary_color][0]),
		"secondary_dark_color":Color(COLORS[secondary_color][1]),
		"secondary_shadow_color":Color(COLORS[secondary_color][2]),
		"detail_light_color":Color(COLORS[eye_color][0]),
		"detail_dark_color":Color(COLORS[eye_color][1]),
		"detail_shadow_color":Color(COLORS[eye_color][2]),
		"eye_light_color":Color(COLORS[eye_color][0]),
		"eye_dark_color":Color(COLORS[eye_color][1]),
		"eye_shadow_color":Color(shadow_color),
		"hair_light_color":Color(COLORS[hair_color][0]),
		"hair_dark_color":Color(COLORS[hair_color][1]),
		"hair_shadow_color":Color(COLORS[hair_color][2])
	}
	
	for part in PARTS:
		if portrait.get_node(part).get(type)!=null:
			var num: int = portrait.get_node(part).Sprites.size()-portrait.get_node(part).get(type)
			if TYPES.find(type)!=TYPES.size()-1:
				num = portrait.get_node(part).get(TYPES[TYPES.find(type)+1])
			data[part] = randi()%num+portrait.get_node(part).get(type)
		else:
			data[part] = randi()%portrait.get_node(part).Sprites.size()
	if data["Hair"]==0:
		data["Hair"] = 1+randi()%(portrait.get_node("Hair").Sprites.size()-1)
	if data["Cloths"]==0:
		data["Cloths"] = 1+randi()%(portrait.get_node("Cloths").Sprites.size()-1)
	data["brows_offset"] = randi()%3-1
	
	if "android" in portrait.get_node("Body").Sprites.keys()[data.Body].to_lower() && randf()<0.5:
		skin_color = 2
		data.skin_light_color = Color(COLORS[skin_color][0])
		data.skin_dark_color = Color(COLORS[skin_color][1])
		data.skin_shadow_color = Color(COLORS[skin_color][2])
	
	buffer_index += 1
	buffer[buffer_index] = data
	if buffer_index>BUFFER_SIZE:
		buffer_index = 0
	
	set_portrait(data)

func set_portrait(data: Dictionary):
	for type in PARTS:
		portrait.get_node(type).set_sprite(data[type])
		if !has_node("Panel/ScrollContainer/VBoxContainer/"+type):
			var t = type.split("/")
			if t.size()>1 && has_node("Panel/ScrollContainer/VBoxContainer/"+t[1]):
				get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/OptionButton").selected = portrait.get_node(type).sprite
			continue
		get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/OptionButton").selected = portrait.get_node(type).sprite
	portrait.get_node("Hair/Brows").position.y = -data.brows_offset
	get_node("Panel/ScrollContainer/VBoxContainer/Brows/VBoxContainer/Offset/HSlider").value = data.brows_offset
	
	skin_material.set_shader_param("light_color", data.skin_light_color)
	skin_material.set_shader_param("dark_color", data.skin_dark_color)
	skin_material.set_shader_param("shadow_color", data.skin_shadow_color)
	skin_material.set_shader_param("white_color", data.white_color)
	skin_material.set_shader_param("black_color", data.black_color)
	primary_material.set_shader_param("light_color", data.primary_light_color)
	primary_material.set_shader_param("dark_color", data.primary_dark_color)
	primary_material.set_shader_param("shadow_color", data.primary_shadow_color)
	primary_material.set_shader_param("white_color", data.white_color)
	primary_material.set_shader_param("black_color", data.black_color)
	secondary_material.set_shader_param("light_color", data.secondary_light_color)
	secondary_material.set_shader_param("dark_color", data.secondary_dark_color)
	secondary_material.set_shader_param("shadow_color", data.secondary_shadow_color)
	secondary_material.set_shader_param("white_color", data.white_color)
	secondary_material.set_shader_param("black_color", data.black_color)
	detail_material.set_shader_param("light_color", data.detail_light_color)
	detail_material.set_shader_param("dark_color", data.detail_dark_color)
	detail_material.set_shader_param("shadow_color", data.detail_shadow_color)
	detail_material.set_shader_param("white_color", data.white_color)
	detail_material.set_shader_param("black_color", data.black_color)
	eye_material.set_shader_param("light_color", data.eye_light_color)
	eye_material.set_shader_param("dark_color", data.eye_dark_color)
	eye_material.set_shader_param("shadow_color", data.eye_shadow_color)
	eye_material.set_shader_param("white_color", data.white_color)
	eye_material.set_shader_param("black_color", data.black_color)
	hair_material.set_shader_param("light_color", data.hair_light_color)
	hair_material.set_shader_param("dark_color", data.hair_dark_color)
	hair_material.set_shader_param("shadow_color", data.hair_shadow_color)
	hair_material.set_shader_param("white_color", data.white_color)
	hair_material.set_shader_param("black_color", data.black_color)
	
	$Panel/ScrollContainer/VBoxContainer/Colors/VBoxContainer/Black/ColorPickerButton.color = data.black_color
	$Panel/ScrollContainer/VBoxContainer/Colors/VBoxContainer/White/ColorPickerButton.color = data.white_color
	$Panel/ScrollContainer/VBoxContainer/Body/VBoxContainer/LightSkin/ColorPickerButton.color = data.skin_light_color
	$Panel/ScrollContainer/VBoxContainer/Body/VBoxContainer/DarkSkin/ColorPickerButton.color = data.skin_dark_color
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/LightEye/ColorPickerButton.color = data.eye_light_color
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/DarkEye/ColorPickerButton.color = data.eye_dark_color
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/ShadowEye/ColorPickerButton.color = data.eye_shadow_color
	$Panel/ScrollContainer/VBoxContainer/Hair/VBoxContainer/LightHair/ColorPickerButton.color = data.hair_light_color
	$Panel/ScrollContainer/VBoxContainer/Hair/VBoxContainer/DarkHair/ColorPickerButton.color = data.hair_dark_color
	$Panel/ScrollContainer/VBoxContainer/Hair/VBoxContainer/OutlineHair/ColorPickerButton.color = data.hair_shadow_color
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/LightPrimary/ColorPickerButton.color = data.primary_light_color
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/DarkPrimary/ColorPickerButton.color = data.primary_dark_color
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/LightSecondary/ColorPickerButton.color = data.secondary_light_color
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/DarkSecondary/ColorPickerButton.color = data.secondary_dark_color
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/LightDetail/ColorPickerButton.color = data.detail_light_color
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/DarkDetail/ColorPickerButton.color = data.detail_dark_color

func store_data():
	var data:= {
		"white_color":Color(WHITE_COLOR),
		"black_color":Color(BLACK_COLOR),
		"skin_light_color":Color(skin_material.get_shader_param("light_color")),
		"skin_dark_color":Color(skin_material.get_shader_param("dark_color")),
		"skin_shadow_color":Color(skin_material.get_shader_param("shadow_color")),
		"primary_light_color":Color(primary_material.get_shader_param("light_color")),
		"primary_dark_color":Color(primary_material.get_shader_param("dark_color")),
		"primary_shadow_color":Color(primary_material.get_shader_param("shadow_color")),
		"secondary_light_color":Color(secondary_material.get_shader_param("light_color")),
		"secondary_dark_color":Color(secondary_material.get_shader_param("dark_color")),
		"secondary_shadow_color":Color(secondary_material.get_shader_param("shadow_color")),
		"detail_light_color":Color(detail_material.get_shader_param("light_color")),
		"detail_dark_color":Color(detail_material.get_shader_param("dark_color")),
		"detail_shadow_color":Color(detail_material.get_shader_param("shadow_color")),
		"eye_light_color":Color(eye_material.get_shader_param("light_color")),
		"eye_dark_color":Color(eye_material.get_shader_param("dark_color")),
		"eye_shadow_color":Color(eye_material.get_shader_param("shadow_color")),
		"hair_light_color":Color(hair_material.get_shader_param("light_color")),
		"hair_dark_color":Color(hair_material.get_shader_param("dark_color")),
		"hair_shadow_color":Color(hair_material.get_shader_param("shadow_color")),
		"brows_offset":portrait.get_node("Hair/Brows").position.y
	}
	for type in PARTS:
		data[type] = portrait.get_node(type).sprite
	
	buffer_index += 1
	buffer[buffer_index] = data
	if buffer_index>BUFFER_SIZE:
		buffer_index = 0

func _cycle_buffer(inc: int):
	var to:= int(fposmod(buffer_index+inc, BUFFER_SIZE))
	if buffer[to]==null:
		_randomize()
	else:
		buffer_index = to
		set_portrait(buffer[to])

func _save():
	if OS.get_name()=="HTML5":
		var texture: ViewportTexture = $Viewport.get_texture()
		var image:= texture.get_data()
# warning-ignore:integer_division
		HTML5File.save_image(image, "portrait"+str(buffer_index).pad_zeros(3)+".png")
	else:
		$FileDialog.show()
		$FileDialog.invalidate()
	store_data()

func _save_file(file : String):
	var texture: ViewportTexture = $Viewport.get_texture()
	var image:= texture.get_data()
	image.save_png(file)
	printt("Saved image to file: "+file)


func _set_sprite(ID: int, node: Node2D):
	node.set_sprite(ID)

func _cycle(node: Node2D, inc: int, button: OptionButton):
	var ID:= int(fposmod(node.sprite+inc, node.Sprites.size()))
	node.set_sprite(ID)
	button.selected = ID

func _set_type(ID: int):
	type = TYPES[ID]
	set_portrait(buffer[buffer_index])
	store_data()

func _cycle_type(inc: int, button: OptionButton):
	var ID: int = int(abs(TYPES.find(type)+inc))%TYPES.size()
	type = TYPES[ID]
	button.selected = ID
	set_portrait(buffer[buffer_index])
	store_data()

func _set_color(color: Color, material: String, type: String):
	get(material).set_shader_param(type, color)

func _set_bw_color(color: Color, type: String):
	skin_material.set_shader_param(type, color)
	eye_material.set_shader_param(type, color)
	hair_material.set_shader_param(type, color)
	primary_material.set_shader_param(type, color)
	secondary_material.set_shader_param(type, color)
	detail_material.set_shader_param(type, color)

func _set_neck_above_cloths(allowed: bool):
	portrait.get_node("Cloths/Neck").show_behind_parent = !allowed

func _set_eyes_above_hair(allowed: bool):
	portrait.get_node("Hair/Eyes").show_behind_parent = !allowed
	portrait.get_node("Hair/Eyes").raise()
	if !allowed:
		portrait.get_node("Hair/Front").raise()

func _set_brows_above_hair(allowed: bool):
	portrait.get_node("Hair/Brows").show_behind_parent = !allowed
	portrait.get_node("Hair/Brows").raise()
	if !allowed:
		portrait.get_node("Hair/Front").raise()

func _set_brows_offset(value: int):
	portrait.get_node("Hair/Brows").position.y = -value


func add_presets(node):
	for c in node.get_children():
		if c is ColorPickerButton:
			var picker: ColorPicker = c.get_picker()
			for array in COLORS:
				for col in array:
					picker.add_preset(Color(col))
			picker.connect("preset_added", self, "_add_preset", [self])
			picker.connect("preset_removed", self, "_remove_preset", [self])
		else:
			add_presets(c)

func _add_preset(color, node):
	for c in node.get_children():
		if c is ColorPickerButton:
			var picker: ColorPicker = c.get_picker()
			picker.add_preset(color)
		else:
			_add_preset(color, c)

func _remove_preset(color, node):
	for c in node.get_children():
		if c is ColorPickerButton:
			var picker: ColorPicker = c.get_picker()
			picker.erase_preset(color)
		else:
			_remove_preset(color, c)

func _resized():
	var scale:= int(max(5.0*min((OS.window_size.x-60)/1024.0, 1.5*(OS.window_size.y-130)/600.0), 1))
	$Portrait.rect_size = 96*scale*Vector2(1.0,1.0)

func _ready():
	randomize()
	buffer.resize(BUFFER_SIZE)
	_resized()
	get_tree().connect("screen_resized", self, "_resized")
	
	for type in PARTS:
		if !has_node("Panel/ScrollContainer/VBoxContainer/"+type):
			var t = type.split("/")
			if t.size()>1 && has_node("Panel/ScrollContainer/VBoxContainer/"+t[1]):
				for i in range(portrait.get_node(type).Sprites.size()):
					get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/OptionButton").add_item(portrait.get_node(type).Sprites.keys()[i].capitalize(),i)
				get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/OptionButton").connect("item_selected", self, "_set_sprite", [portrait.get_node(type)])
				get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/ButtonLeft").connect("pressed", self, "_cycle", [portrait.get_node(type),-1,get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/OptionButton")])
				get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/ButtonRight").connect("pressed", self, "_cycle", [portrait.get_node(type),1,get_node("Panel/ScrollContainer/VBoxContainer/"+t[1]+"/VBoxContainer/HBoxContainer/OptionButton")])
			continue
		for i in range(portrait.get_node(type).Sprites.size()):
			get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/OptionButton").add_item(portrait.get_node(type).Sprites.keys()[i].capitalize(),i)
		get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/OptionButton").connect("item_selected", self, "_set_sprite", [portrait.get_node(type)])
		get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/ButtonLeft").connect("pressed", self, "_cycle", [portrait.get_node(type),-1,get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/OptionButton")])
		get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/ButtonRight").connect("pressed", self, "_cycle", [portrait.get_node(type),1,get_node("Panel/ScrollContainer/VBoxContainer/"+type+"/VBoxContainer/HBoxContainer/OptionButton")])
	for i in range(TYPES.size()):
		get_node("Panel/ScrollContainer/VBoxContainer/Type/VBoxContainer/HBoxContainer/OptionButton").add_item(TYPES[i].capitalize(),i)
		get_node("Panel/ScrollContainer/VBoxContainer/Type/VBoxContainer/HBoxContainer/OptionButton").connect("item_selected", self, "_set_type")
		get_node("Panel/ScrollContainer/VBoxContainer/Type/VBoxContainer/HBoxContainer/ButtonLeft").connect("pressed", self, "_cycle_type", [-1,get_node("Panel/ScrollContainer/VBoxContainer/Type/VBoxContainer/HBoxContainer/OptionButton")])
		get_node("Panel/ScrollContainer/VBoxContainer/Type/VBoxContainer/HBoxContainer/ButtonRight").connect("pressed", self, "_cycle_type", [1,get_node("Panel/ScrollContainer/VBoxContainer/Type/VBoxContainer/HBoxContainer/OptionButton")])
	
	$Bottom/HBoxContainer/ButtonRng.connect("pressed", self, "_randomize")
	$Bottom/HBoxContainer/ButtonPrev.connect("pressed", self, "_cycle_buffer", [-1])
	$Bottom/HBoxContainer/ButtonNext.connect("pressed", self, "_cycle_buffer", [ 1])
	$Bottom/HBoxContainer/ButtonSave.connect("pressed", self, "_save")
	$Panel/ScrollContainer/VBoxContainer/Colors/VBoxContainer/Black/ColorPickerButton.connect("color_changed", self, "_set_bw_color", ["black_color"])
	$Panel/ScrollContainer/VBoxContainer/Colors/VBoxContainer/White/ColorPickerButton.connect("color_changed", self, "_set_bw_color", ["white_color"])
	$Panel/ScrollContainer/VBoxContainer/Body/VBoxContainer/LightSkin/ColorPickerButton.connect("color_changed", self, "_set_color", ["skin_material","light_color"])
	$Panel/ScrollContainer/VBoxContainer/Body/VBoxContainer/DarkSkin/ColorPickerButton.connect("color_changed", self, "_set_color", ["skin_material","dark_color"])
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/LightEye/ColorPickerButton.connect("color_changed", self, "_set_color", ["eye_material","light_color"])
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/DarkEye/ColorPickerButton.connect("color_changed", self, "_set_color", ["eye_material","dark_color"])
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/ShadowEye/ColorPickerButton.connect("color_changed", self, "_set_color", ["eye_material","shadow_color"])
	$Panel/ScrollContainer/VBoxContainer/Hair/VBoxContainer/LightHair/ColorPickerButton.connect("color_changed", self, "_set_color", ["hair_material","light_color"])
	$Panel/ScrollContainer/VBoxContainer/Hair/VBoxContainer/DarkHair/ColorPickerButton.connect("color_changed", self, "_set_color", ["hair_material","dark_color"])
	$Panel/ScrollContainer/VBoxContainer/Hair/VBoxContainer/OutlineHair/ColorPickerButton.connect("color_changed", self, "_set_color", ["hair_material","shadow_color"])
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/LightPrimary/ColorPickerButton.connect("color_changed", self, "_set_color", ["primary_material","light_color"])
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/DarkPrimary/ColorPickerButton.connect("color_changed", self, "_set_color", ["primary_material","dark_color"])
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/LightSecondary/ColorPickerButton.connect("color_changed", self, "_set_color", ["secondary_material","light_color"])
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/DarkSecondary/ColorPickerButton.connect("color_changed", self, "_set_color", ["secondary_material","dark_color"])
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/LightDetail/ColorPickerButton.connect("color_changed", self, "_set_color", ["detail_material","light_color"])
	$Panel/ScrollContainer/VBoxContainer/Cloths/VBoxContainer/DarkDetail/ColorPickerButton.connect("color_changed", self, "_set_color", ["detail_material","dark_color"])
	$Panel/ScrollContainer/VBoxContainer/Neck/VBoxContainer/CheckBox.connect("toggled", self, "_set_neck_above_cloths")
	$Panel/ScrollContainer/VBoxContainer/Eyes/VBoxContainer/CheckBox.connect("toggled", self, "_set_eyes_above_hair")
	$Panel/ScrollContainer/VBoxContainer/Brows/VBoxContainer/CheckBox.connect("toggled", self, "_set_brows_above_hair")
	$Panel/ScrollContainer/VBoxContainer/Brows/VBoxContainer/Offset/HSlider.connect("value_changed", self, "_set_brows_offset")
	$FileDialog.connect("file_selected", self, "_save_file")
	$FileDialog.current_dir = OS.get_system_dir(OS.SYSTEM_DIR_PICTURES)
	
	add_presets($Panel/ScrollContainer/VBoxContainer)
	
	_randomize()
