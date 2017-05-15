defmodule Matryoshka.Bench do
  defmacro bench(description, do: body) do
    quote do
      require Logger
      Logger.info "start `#{unquote(description)}`"
      {diff, res} = :timer.tc(fn ->
        unquote(body)
      end)
      Logger.info "[#{formatted_diff(diff)}] finished `#{unquote(description)}`"
      res
    end
  end

  def formatted_diff(diff) when diff > 1000, do: [diff |> div(1000) |> Integer.to_string, "ms"]
  def formatted_diff(diff), do: [Integer.to_string(diff), "µs"]
end
