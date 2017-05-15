defmodule Matryoshka.Server do
  use Plug.Router

  plug :match
  plug :fetch_query_params
  plug :skip_favicon

  plug Matryoshka.OpenImagePlug
  plug Matryoshka.Transformations
  plug Matryoshka.ServeImagePlug

  plug :dispatch

  def skip_favicon(%Plug.Conn{request_path: "/favicon.ico"} = conn, _) do
    conn
    |> send_resp(404, "no found")
    |> halt
  end
  def skip_favicon(conn, _), do: conn

  get "/*path" do
    body = """
    params #{inspect conn.params} <br/>
    query_params #{inspect conn.query_params} <br/>
    assigns #{inspect conn.assigns} <br/>
    """
    send_resp(conn, 200, body)
  end
end
