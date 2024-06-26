defmodule RobotSimulatorTest do
  use ExUnit.Case

  test "create has sensible defaults" do
    robot = RobotSimulator.create()
    assert RobotSimulator.position(robot) == {0, 0}
    assert RobotSimulator.direction(robot) == :north
  end

  test "create works with valid arguments" do
    robot = RobotSimulator.create(:north, {0, 0})
    assert RobotSimulator.position(robot) == {0, 0}
    assert RobotSimulator.direction(robot) == :north

    robot = RobotSimulator.create(:south, {-1, -1})
    assert RobotSimulator.position(robot) == {-1, -1}
    assert RobotSimulator.direction(robot) == :south

    robot = RobotSimulator.create(:east, {0, 10})
    assert RobotSimulator.position(robot) == {0, 10}
    assert RobotSimulator.direction(robot) == :east

    robot = RobotSimulator.create(:west, {100, -100})
    assert RobotSimulator.position(robot) == {100, -100}
    assert RobotSimulator.direction(robot) == :west
  end

  test "create errors if invalid direction given" do
    position = {0, 0}
    invalid_direction = {:error, "invalid direction"}

    assert RobotSimulator.create(:invalid, position) == invalid_direction
    assert RobotSimulator.create(0, position) == invalid_direction
    assert RobotSimulator.create("east", position) == invalid_direction
  end

  test "create errors if invalid position given" do
    direction = :north
    invalid_position = {:error, "invalid position"}

    assert RobotSimulator.create(direction, {0, 0, 0}) == invalid_position
    assert RobotSimulator.create(direction, {0, :invalid}) == invalid_position
    assert RobotSimulator.create(direction, {"0", 0}) == invalid_position

    assert RobotSimulator.create(direction, "invalid") == invalid_position
    assert RobotSimulator.create(direction, 0) == invalid_position
    assert RobotSimulator.create(direction, [0, 0]) == invalid_position
    assert RobotSimulator.create(direction, nil) == invalid_position
  end

  @tag :pending
  test "rotating clockwise" do
    robot1 = RobotSimulator.create(:north, {0, 0}) |> RobotSimulator.simulate("R")
    assert RobotSimulator.direction(robot1) == :east
    assert RobotSimulator.position(robot1) == {0, 0}

    robot2 = RobotSimulator.create(:east, {0, 0}) |> RobotSimulator.simulate("R")
    assert RobotSimulator.direction(robot2) == :south
    assert RobotSimulator.position(robot2) == {0, 0}

    robot3 = RobotSimulator.create(:south, {0, 0}) |> RobotSimulator.simulate("R")
    assert RobotSimulator.direction(robot3) == :west
    assert RobotSimulator.position(robot3) == {0, 0}

    robot4 = RobotSimulator.create(:west, {0, 0}) |> RobotSimulator.simulate("R")
    assert RobotSimulator.direction(robot4) == :north
    assert RobotSimulator.position(robot4) == {0, 0}
  end

  @tag :pending
  test "rotating counter-clockwise" do
    robot1 = RobotSimulator.create(:north, {0, 0}) |> RobotSimulator.simulate("L")
    assert RobotSimulator.direction(robot1) == :west
    assert RobotSimulator.position(robot1) == {0, 0}

    robot2 = RobotSimulator.create(:west, {0, 0}) |> RobotSimulator.simulate("L")
    assert RobotSimulator.direction(robot2) == :south
    assert RobotSimulator.position(robot2) == {0, 0}

    robot3 = RobotSimulator.create(:south, {0, 0}) |> RobotSimulator.simulate("L")
    assert RobotSimulator.direction(robot3) == :east
    assert RobotSimulator.position(robot3) == {0, 0}

    robot4 = RobotSimulator.create(:east, {0, 0}) |> RobotSimulator.simulate("L")
    assert RobotSimulator.direction(robot4) == :north
    assert RobotSimulator.position(robot4) == {0, 0}
  end

  test "advancing" do
    robot1 = RobotSimulator.create(:north, {0, 0}) |> RobotSimulator.simulate("A")
    assert RobotSimulator.direction(robot1) == :north
    assert RobotSimulator.position(robot1) == {0, 1}

    robot2 = RobotSimulator.create(:south, {0, 0}) |> RobotSimulator.simulate("A")
    assert RobotSimulator.direction(robot2) == :south
    assert RobotSimulator.position(robot2) == {0, -1}

    robot3 = RobotSimulator.create(:east, {0, 0}) |> RobotSimulator.simulate("A")
    assert RobotSimulator.direction(robot3) == :east
    assert RobotSimulator.position(robot3) == {1, 0}

    robot4 = RobotSimulator.create(:west, {0, 0}) |> RobotSimulator.simulate("A")
    assert RobotSimulator.direction(robot4) == :west
    assert RobotSimulator.position(robot4) == {-1, 0}
  end

  @tag :pending
  test "moving east and north from instructions" do
    robot = RobotSimulator.create(:north, {7, 3}) |> RobotSimulator.simulate("RAALAL")
    assert RobotSimulator.direction(robot) == :west
    assert RobotSimulator.position(robot) == {9, 4}
  end

  @tag :pending
  test "moving west and north" do
    robot = RobotSimulator.create(:north, {0, 0}) |> RobotSimulator.simulate("LAAARALA")
    assert RobotSimulator.direction(robot) == :west
    assert RobotSimulator.position(robot) == {-4, 1}
  end

  @tag :pending
  test "moving west and south" do
    robot = RobotSimulator.create(:east, {2, -7}) |> RobotSimulator.simulate("RRAAAAALA")
    assert RobotSimulator.direction(robot) == :south
    assert RobotSimulator.position(robot) == {-3, -8}
  end

  @tag :pending
  test "moving east and north" do
    robot = RobotSimulator.create(:south, {8, 4}) |> RobotSimulator.simulate("LAAARRRALLLL")
    assert RobotSimulator.direction(robot) == :north
    assert RobotSimulator.position(robot) == {11, 5}
  end

  test "simulate errors on invalid instructions" do
    assert RobotSimulator.create() |> RobotSimulator.simulate("UUDDLRLRBASTART") ==
             {:error, "invalid instruction"}
  end
end
