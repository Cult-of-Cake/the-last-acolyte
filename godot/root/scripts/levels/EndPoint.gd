extends MapPoint
class_name EndPoint

func _on_body_entered(body : Node2D) -> void:
	if body is CollisionTypeChecker:
		if body.true_body is Enemy:
			body.true_body.on_collide_endpoint(self)
