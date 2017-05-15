defmodule Matryoshka.TransformationTest do
  use ExUnit.Case

  alias Matryoshka.{Command}

  defmodule Resize do
    def transform(%Command{} = cmd, args) do
      Command.add_option(cmd, "resize", args["size"])
    end
  end

  defmodule Rotate do
    def transform(%Command{} = cmd, args) do
      Command.add_option(cmd, "rotate", args["rotate"])
    end
  end

  defmodule CustomTransformer do
    use Matryoshka.Transformation

    transformation Resize
    transformation Rotate
  end

  test "run" do
    args = %{
      "size" => "100x100",
      "rotate" => "45"
    }

    expected = %Command{options: [
      {"resize", "100x100"},
      {"rotate", "45"}
    ]}
    cmd = CustomTransformer.run(%Command{}, args)

    assert cmd == expected
  end
end
