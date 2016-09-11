defmodule SquatterTest do
  use ExUnit.Case
  doctest Squatter

  test "refresh_campsites" do
    assert Squatter.refresh_campsites
  end
end
