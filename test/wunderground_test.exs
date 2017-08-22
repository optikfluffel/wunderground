defmodule WundergroundTest do
  use ExUnit.Case
  doctest Wunderground

  test "greets the world" do
    assert Wunderground.hello() == :world
  end
end
