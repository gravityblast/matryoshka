defmodule Matryoshka.Command do
  defstruct [:input_path, :options]

  import Matryoshka.{Bench}

  @executable "mogrify"

  def executable, do: @executable

  def new(input_path) do
    %__MODULE__{input_path: input_path, options: []}
  end

  def add_option(%__MODULE__{options: options} = command, name, value) when is_list(options) do
    %{command | options: [{name, value} | command.options]}
  end
  def add_option(%__MODULE__{} = command, name, value) do
    add_option(%{command | options: []}, name, value)
  end

  def to_args(%__MODULE__{} = cmd) do
    cmd.options
    |> Enum.flat_map(fn({name, value}) -> [name, value] end)
    |> Enum.reject(&is_nil/1)
    |> Kernel.++([cmd.input_path])
  end

  def execute(%__MODULE__{} = cmd) do
    args = to_args(cmd)
    bench "executing command: #{executable()} #{Enum.join(args, " ")}" do
      System.cmd(executable(), args, stderr_to_stdout: true)
    end
  end
end
