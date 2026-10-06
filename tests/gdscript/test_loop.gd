extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_cost_and_half() -> void:
	var rules = Rules.new()
	assert_eq(rules.deploy(3, false), "far_half", "wrong half")
	assert_eq(rules.deploy(9, true), "short", "too costly")
	assert_eq(rules.deploy(3, true), "deployed", "paid")
	assert_almost_eq(rules.elixir, 1.0, 0.01, "spent")

func test_tower() -> void:
	var rules = Rules.new()
	rules.strike_tower(5)
	assert_eq(rules.tower_points, 15, "tower hit")

func test_result_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_result(), "tower stands")
	assert_eq(rules.play_costly(), "short", "costly card")
	rules.tower_points = 0
	assert_true(rules.may_result(), "tower down")
	assert_true(load("res://scenes/result.tscn") != null, "result loads")

func test_draw_card() -> void:
	var rules = Rules.new()
	assert_true(rules.draw_card(4), "under cap")
	assert_false(rules.draw_card(5), "sixth card")
	assert_eq(rules.play_costly(), "short", "costly leap stays")
