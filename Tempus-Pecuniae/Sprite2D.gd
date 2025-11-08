# Node: Sprite2D
@tool
extends Sprite2D

@export var tile_px: int = 64
@export var cells: int = 8
@export var light_col: Color = Color8(33, 235, 46)   # bright green
@export var dark_col:  Color = Color8(255, 36, 140)  # bright pink
@export var line_px: int = 4
@export var line_col: Color = Color.BLACK

func _ready():
	texture = _make_board()

func _make_board() -> Texture2D:
	var size := tile_px * cells
	var img := Image.create(size, size, false, Image.FORMAT_RGBA8)

	# Pre-make the two tile images
	var tile_a := Image.create(tile_px, tile_px, false, Image.FORMAT_RGBA8)
	tile_a.fill(light_col)
	var tile_b := Image.create(tile_px, tile_px, false, Image.FORMAT_RGBA8)
	tile_b.fill(dark_col)

	# Blit alternating tiles
	for y in range(cells):
		for x in range(cells):
			var src := tile_a if ((x + y) % 2 == 0) else tile_b
			img.blit_rect(src, Rect2i(Vector2i.ZERO, Vector2i(tile_px, tile_px)),
						  Vector2i(x * tile_px, y * tile_px))

	# Draw grid lines by blitting thin strips
	if line_px > 0:
		var vline := Image.create(line_px, size, false, Image.FORMAT_RGBA8)
		vline.fill(line_col)
		var hline := Image.create(size, line_px, false, Image.FORMAT_RGBA8)
		hline.fill(line_col)

		for i in range(cells + 1):
			img.blit_rect(vline, Rect2i(Vector2i.ZERO, Vector2i(line_px, size)),
						  Vector2i(i * tile_px, 0))
			img.blit_rect(hline, Rect2i(Vector2i.ZERO, Vector2i(size, line_px)),
						  Vector2i(0, i * tile_px))

	return ImageTexture.create_from_image(img)
