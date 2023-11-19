extends Control

var current_button

@onready var exit_button = $ShopRect/VBoxContainer/ExitButton
@onready var shop_items = [
	$ShopRect/MenuBar/VBoxContainer/HBoxContainer/Item/ColorRect/BuyButton, $ShopRect/MenuBar/VBoxContainer/HBoxContainer/Item2/ColorRect/BuyButton2,
	$ShopRect/MenuBar/VBoxContainer/HBoxContainer/Item3/ColorRect/BuyButton3, $ShopRect/MenuBar/VBoxContainer/HBoxContainer/Item4/ColorRect/BuyButton4,
	$ShopRect/MenuBar/VBoxContainer/HBoxContainer2/Item5/ColorRect/BuyButton5, $ShopRect/MenuBar/VBoxContainer/HBoxContainer2/Item6/ColorRect/BuyButton6,
	$ShopRect/MenuBar/VBoxContainer/HBoxContainer2/Item7/ColorRect/BuyButton7, $ShopRect/MenuBar/VBoxContainer/HBoxContainer2/Item8/ColorRect/BuyButton8
]

func _ready():
	get_viewport().connect("gui_focus_changed", _on_focus_changed)
	shop_items[0].grab_focus()
	current_button = shop_items[0]
	$ShopRect/VBoxContainer/HBoxContainer/Wallet.text = str(GlobalVars.global_gold)

func _on_focus_changed(button):
	current_button = button

func _input(event):
	if event.is_action_pressed("action") || event.is_action_pressed("up") || event.is_action_pressed("down") || event.is_action_pressed("left") || event.is_action_pressed("right") || event.is_action_pressed("action"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("action"):
		current_button.emit_signal("pressed")

func _on_buy_button_pressed():
	pass # Replace with function body.


func _on_buy_button_2_pressed():
	pass # Replace with function body.


func _on_buy_button_3_pressed():
	pass # Replace with function body.


func _on_buy_button_4_pressed():
	pass # Replace with function body.


func _on_buy_button_5_pressed():
	pass # Replace with function body.


func _on_buy_button_6_pressed():
	pass # Replace with function body.


func _on_buy_button_7_pressed():
	pass # Replace with function body.


func _on_buy_button_8_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main/main.tscn")
