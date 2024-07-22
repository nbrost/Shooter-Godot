extends CanvasLayer

# colours
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9,0,0,1)

@onready var laser_label: Label = $HBoxContainer/LaserContainer/Label
@onready var grenade_label: Label = $HBoxContainer/GrenadeContainer/Label
@onready var laser_icon : TextureRect = $HBoxContainer/LaserContainer/TextureRect
@onready var grenade_icon : TextureRect = $HBoxContainer/GrenadeContainer/TextureRect
@onready var health_bar : TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect('stat_change', update_stat_text)
	update_stat_text()
	
func update_stat_text():
	update_grenade_text()
	update_health_text()
	update_laser_text()

func update_laser_text():
	update_color(Globals.laser_amount, laser_label, laser_icon)
	laser_label.text = str(Globals.laser_amount)

func update_grenade_text():
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	grenade_label.text = str(Globals.grenade_amount)

func update_color(amount: int,label: Label,icon: TextureRect) -> void:
	if amount > 0:
		label.modulate = green
		icon.modulate = green
	else:
		label.modulate = red
		icon.modulate = red
		
func update_health_text():
	health_bar.value = Globals.health
