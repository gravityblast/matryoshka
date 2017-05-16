# Matryoshka

An image transformation reverse proxy written in Elixir.

It is meant to be used with a CDN in front of it, so that
the it processes each image only once during the first request.

Internally it uses the `mogrify` command.

## Transformations

You can use a plug-like syntax to specify all the transformations:

```elixir
defmodule MyTransformations do
  use Matryoshka.TransformationPlug

  transformation Resize
  transformation Rotate
  transformation Strip
end
```

Each transformation is just a behaviour with a transform function:

```elixir
defmodule Resize do
  alias Matryoshka.{Command}

  def transform(%Command{} = cmd, opts) do
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
```

## Usage

```bash
export REMOTE_ROOT="https://s3.amazonaws.com/BUCKET_NAME"
mix run --no-halt
```

## TODO

The current repository contains an application that can be run with `mix run --no-halt`.
The plan is to change it so that it can be used as a simple library, and each one can just
use the `TransformationPlug` behaviour.

* [ ] Write a TODO list

## Author

[Andrea Franz](http://gravityblast.com)
