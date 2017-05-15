defmodule Matryoshka.CommandTest do
  use ExUnit.Case

  alias Matryoshka.{Command}

  describe "new" do
    test "returns a new command" do
      filename = "test.jpg"
      expected = %Command{input_path: filename, options: []}
      assert Command.new(filename) == expected
    end
  end

  describe "add_option" do
    test "add option to options list" do
      assert Command.add_option(%Command{}, :foo, 1) == %Command{options: [{:foo, 1}]}
      assert Command.add_option(%Command{options: [{:foo, 1}]}, :bar, 2) == %Command{options: [{:bar, 2}, {:foo, 1}]}
    end
  end

  describe "to_args" do
    test "return args" do
      args =
        "foo.jpg"
        |> Command.new
        |> Command.add_option("-write", "bar.jpg")
        |> Command.to_args

      expected = ["-write", "bar.jpg", "foo.jpg"]
      assert args == expected
    end
  end
end
