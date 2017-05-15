defmodule Matryoshka.OpenImagePlug do
  use Matryoshka.BasePlug

  def call(conn, _opts) do
    conn
    |> build_remote_url
    |> retrieve_file
    |> store_file(conn)
  end

  defp build_remote_url(%Plug.Conn{request_path: path}) do
    "#{remote_root()}#{path}"
  end

  defp remote_root do
    Application.get_env(:matryoshka, :remote_root)
  end

  defp retrieve_file(url) do
    bench "retrieving file (#{url})" do
      HTTPoison.get(url)
    end
  end

  defp store_file({:error, _error}, conn) do
    conn
    |> send_resp(500, "internal server error")
    |> halt
  end
  defp store_file({:ok, %HTTPoison.Response{} = resp}, conn) do
    case resp.status_code do
      status when status >= 200 and status <= 299 ->
        filename = :crypto.strong_rand_bytes(32) |> Base.encode16
        path = "tmp/#{filename}"
        File.write!(path, resp.body)
        put_image_path(conn, path)
      status ->
        conn
        |> send_resp(status, "#{status}")
        |> halt
    end
  end
end
