extends GutTest

func before_each():
	ScoreManager.score = 0

func test_add_points():
	var initial_points = ScoreManager.score
	var value_to_add = 100
	ScoreManager.add_points(value_to_add)
	assert_eq(ScoreManager.score, initial_points + value_to_add, "Score should be incremented by 100")
