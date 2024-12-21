extends PanelContainer

enum BG_COLOR {GREY, BLACK, BLUE}

@export var card: Card

# Set data from card
func _ready() -> void:
	%CardName.text = card.display_name
	%Picture.texture = card.picture
	%Description.text = card.description
	match card.bg_color:
		BG_COLOR.GREY:
			self_modulate = Color.GRAY
		BG_COLOR.BLACK:
			self_modulate = Color.BLACK
		BG_COLOR.BLUE:
			self_modulate = Color.NAVY_BLUE
		
