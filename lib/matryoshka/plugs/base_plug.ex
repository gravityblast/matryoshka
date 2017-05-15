defmodule Matryoshka.BasePlug do
  alias Matryoshka.{Command}
  import Plug.Conn

  defmacro __using__(_) do
    quote do
      import Plug.Conn
      import Matryoshka.{BasePlug, Bench}

      def init(options) do
        options
      end

      defoverridable [init: 1]
    end
  end

  def cmd(%Plug.Conn{assigns: %{cmd: cmd}}), do: cmd
  def cmd(_), do: %Command{}

  def put_image_path(conn, path) do
    conn
    |> cmd
    |> Map.put(:input_path, path)
    |> assign_cmd(conn)
  end

  def image_path(conn) do
    conn
    |> cmd
    |> Map.get(:input_path)
  end

  def add_option(%Plug.Conn{} = conn, name, value) do
    conn
    |> cmd
    |> Command.add_option(name, value)
    |> assign_cmd(conn)
  end

  def execute(%Plug.Conn{} = conn) do
    result =
      conn
      |> cmd
      |> Command.execute

    assign(conn, :cmd_result, result)
  end

  def assign_cmd(%Command{} = cmd, conn) do
    assign(conn, :cmd, cmd)
  end
end
