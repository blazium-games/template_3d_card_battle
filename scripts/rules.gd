extends RefCounted

var elixir := 4.0
var tower_points := 20

func deploy(cost: int, own_half: bool) -> String:
	if not own_half:
		return "far_half"
	if elixir < float(cost):
		return "short"
	elixir -= float(cost)
	return "deployed"

func tick_elixir(step: float) -> void:
	elixir = minf(elixir + step, 10.0)

func strike_tower(amount: int) -> void:
	tower_points = maxi(tower_points - amount, 0)

func reset_match() -> void:
	elixir = 4.0
	tower_points = 20

const COSTLY := 6
const HAND_CAP := 5
var hand := 0

func draw_card(hand_size: int) -> bool:
	return hand_size < HAND_CAP

func play_costly() -> String:
	return deploy(COSTLY, true)

func may_result() -> bool:
	return tower_points <= 0
