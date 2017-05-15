defmodule Resize do
  alias Matryoshka.{Command}

  def transform(cmd, opts) do
    opts
    |> Map.get("size", "")
    |> Integer.parse
    |> case do
      {size, ""} ->
        cmd
        |> Command.add_option("-thumbnail", "#{size}x#{size}")
        |> Command.add_option("-quality", "80")
      _ ->
        cmd
    end
  end
end

defmodule Rotate do
  alias Matryoshka.{Command}

  def transform(cmd, opts) do
    opts
    |> Map.get("rotate", "")
    |> Integer.parse
    |> case do
      {rotate, ""} ->
        Command.add_option(cmd, "-rotate", "#{rotate}")
      _ ->
        cmd
    end
  end
end

defmodule Strip do
  alias Matryoshka.{Command}

  def transform(cmd, opts) do
    Command.add_option(cmd, "-strip", nil)
  end
end

defmodule Matryoshka.Transformations do
  use Matryoshka.TransformationPlug

  transformation Resize
  transformation Rotate
  transformation Strip
end
