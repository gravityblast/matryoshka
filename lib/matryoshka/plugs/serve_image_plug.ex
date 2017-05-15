defmodule Matryoshka.ServeImagePlug do
  use Matryoshka.BasePlug

  def call(conn, _opts) do
    path = "#{image_path(conn)}-converted"

    conn
    |> add_option("-write", path)
    |> execute
    |> send_file(200, path)
    |> halt
  end
end
