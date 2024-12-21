extends Resource
class_name Card

@export var display_name: String = ""
@export var picture: Texture2D
@export_multiline var description: String = ""

enum BG_COLOR {GREY, BLACK, BLUE}
@export var bg_color: BG_COLOR = BG_COLOR.GREY
