extends Control

var is_gamepad_connected
var current_button

var descriptions = [
	"Welcome, intrepid adventurer, to the Verdant Expanse, a realm veiled in the mystique of eternal twilight. In this ethereal landscape, nature's heartbeat pulses with an otherworldly vitality, and the very essence of life intertwines with the shadows cast by ancient trees. As you step into the embrace of the Grasslands of Eternal Dusk, a world akin to the legendary Vampire Survivors, you are greeted by a sea of emerald blades that dance in the silken breezes. The grass, kissed by the hues of a perpetual sunset, whispers ancient secrets to those who dare to listen. Beneath the verdant canopy, towering trees with gnarled branches stretch skyward, weaving an intricate tapestry of shadow and light. The air is alive with the melodic symphony of unseen creatures, and the fragrance of enchanting blooms intoxicates the senses, inviting you deeper into the heart of this mystical realm. But beware, noble wanderer, for within the lush expanse lie challenges that mirror the eternal struggle of vampire survival. Mysterious creatures, both friend and foe, navigate the interwoven maze of grassy corridors, and hidden among the foliage are secrets that could either unveil great treasures or unleash malevolent forces. To navigate this supernatural terrain, harness the power of nature itself. Imbibe the essence of ancient flora to bolster your strength, and let the very ground beneath your feet become a weapon against the encroaching darkness. Unleash abilities that tap into the primal energy of the Grasslands, transforming you into a force to be reckoned with. As you traverse this twilight realm, your every step echoes with the weight of destiny. The Grasslands of Eternal Dusk beckon, adventurer. Will you succumb to the shadows, or will you emerge as a legend, a survivor of the night? The choice is yours, and the journey awaits in this epic tale of nature's embrace and resilience.",
	"Embark upon a journey into the Looming Citadel, a fantastical realm where the very fabric of reality is woven into existence. In this extraordinary tapestry of wonder, threads of magic and mystery intertwine, creating a living, breathing world that mirrors the fear. As you step into the surreal landscape of the Fabricated Haven, behold a breathtaking panorama of colossal spools and towering looms that stretch towards the heavens. The air is infused with the scent of fresh linen and the gentle hum of ethereal sewing machines that seem to echo through the very fabric of time. Wander through corridors adorned with cascading curtains of vibrant silk and navigate platforms crafted from the interwoven threads of dreams. The ground beneath your feet pulses with the rhythmic heartbeat of the loom, and the very air crackles with the energy of arcane stitches and celestial seams. Mysterious creatures, born of stitches and whimsy, traverse the intricacies of this living tapestry.  To navigate this surreal landscape, master the art of threadcraft. Stitch together your fate with the enchanting abilities bestowed upon you, unraveling the fabric of time to your advantage. As you embark on this fabric-bound odyssey, the looms bear witness to your every move. Will you emerge as a master of the threads or become entangled in the warp and weft of destiny?",
	"Venture forth into the formidable Stone City, a realm sculpted by the hands of ancient titans and graced by the stoic majesty of unyielding rock. In this epic landscape, where the echoes of Vampire Survivors resonate, craggy peaks pierce the sky, and the very essence of the earth itself is harnessed in the formidable Rockbound Archipelago. As you set foot upon the rugged terrain of the Granite Isles, marvel at the towering monoliths that guard secrets etched in stone. The air is charged with the elemental energy of rock and the resounding echoes of geological symphonies, weaving a narrative as timeless as the very bedrock beneath your boots. Wander through towering spires of obsidian and navigate treacherous cliffs that plunge into the tumultuous sea below. The ground, unyielding and unforgiving, holds the echoes of untold tales and the footsteps of those who came before you. Mythic creatures, born of the very stone they traverse, navigate the craggy expanses. To navigate this rugged landscape, harness the power of geokinesis. Manipulate the very bedrock beneath you, shaping the terrain to your advantage. Traverse precarious ledges and scale towering cliffs with the prowess of a stone-bound acrobat. Embrace the elemental abilities granted to you, forging a path through the granite wilderness."
]

var labels = [
	'LEVEL 1 - VERDANT EXPANSE',
	'LEVEL 2 - LOOMING CITADEL',
	'LEVEL 3 - STONE CITY'
]

@onready var return_button = $MenuBar/ReturnButton
@onready var lvl_button_lst: Array = [
	$MenuBar/VBoxContainer/Level1Button,
	$MenuBar/VBoxContainer/Level2Button,
]

func _ready():
	is_gamepad_connected = true if Input.get_connected_joypads().size() == 1 else false
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	lvl_button_lst[0].grab_focus()
	current_button = lvl_button_lst[0]
	
func _on_focus_changed(button):
	current_button = button

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right") || event.is_action_pressed("action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _on_return_button_pressed():
	while GlobalVars.preloaded_scenes["menu"] == null:
		pass
	get_tree().change_scene_to_packed(GlobalVars.preloaded_scenes['menu'])

# HANDLERS
func _on_level_1_button_pressed():
	MainMenuAudio.stop()
	GlobalVars.current_level = "res://scenes/level1/level1_gm.tscn"
	get_tree().change_scene_to_file("res://scenes/loadscreen/load.tscn")


func _on_level_2_button_pressed():
	MainMenuAudio.stop()
	GlobalVars.current_level = "res://scenes/level2/level2_gm.tscn"
	get_tree().change_scene_to_file("res://scenes/loadscreen/load.tscn")


func _on_level_3_button_pressed():
	MainMenuAudio.stop()
	GlobalVars.current_level = "res://scenes/level3/level3_gm.tscn"
	get_tree().change_scene_to_file("res://scenes/loadscreen/load.tscn")

# FOCUS
func _on_level_1_button_focus_entered():
	$Description/LevelName.text = labels[0]
	$Description/ColorRect2/RichTextLabel.text = descriptions[0]
	$Description/LevelPreview.texture = GlobalVars.preview_textures[0]

func _on_level_2_button_focus_entered():
	$Description/LevelName.text = labels[1]
	$Description/ColorRect2/RichTextLabel.text = descriptions[1]
	$Description/LevelPreview.texture = GlobalVars.preview_textures[1]

func _on_level_3_button_focus_entered():
	$Description/LevelName.text = labels[2]
	$Description/ColorRect2/RichTextLabel.text = descriptions[2]
	$Description/LevelPreview.texture = GlobalVars.preview_textures[2]

# HOVER
func _on_level_1_button_mouse_entered():
	$Description/LevelName.text = labels[0]
	$Description/ColorRect2/RichTextLabel.text = descriptions[0]
	$Description/LevelPreview.texture = GlobalVars.preview_textures[0]

func _on_level_2_button_mouse_entered():
	$Description/LevelName.text = labels[1]
	$Description/ColorRect2/RichTextLabel.text = descriptions[1]
	$Description/LevelPreview.texture = GlobalVars.preview_textures[1]

func _on_level_3_button_mouse_entered():
	$Description/LevelName.text = labels[2]
	$Description/ColorRect2/RichTextLabel.text = descriptions[2]
	$Description/LevelPreview.texture = GlobalVars.preview_textures[2]
