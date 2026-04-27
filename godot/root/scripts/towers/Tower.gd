extends Pet
class_name Tower

var coords : Vector2i
var data : PetRegistryData

# Cache these, we'll need them often
var affinity : Vars.ELEMENT
var role : Vars.ROLE

func init(data : PetRegistryData) -> void:
	self.data = data
	affinity = data.get_element()
	role = data.get_role()
	#sprite_img = Vars.get_pet_image(affinity, role, Vars.PET_IMAGE_USES.SPRITE)
	#icon_img = Vars.get_pet_image(affinity, role, Vars.PET_IMAGE_USES.ICON)
	#cursor_img = Vars.get_pet_image(affinity, role, Vars.PET_IMAGE_USES.CURSOR)
	sprite.texture = sprite_img

#region Sprites

@export var sprite : Sprite2D
@export var sprite_img : CompressedTexture2D
@export var icon_img : CompressedTexture2D
@export var cursor_img : CompressedTexture2D

#endregion
