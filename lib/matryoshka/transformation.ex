defmodule Matryoshka.Transformation do
  alias Matryoshka.{Command}

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :transformations, accumulate: true)

      def run(%Command{} = initial_cmd, args) do
        Enum.reduce(transformations(), initial_cmd, fn(transformation, cmd) ->
          run_transformation(transformation, cmd, args)
        end)
      end

      defp run_transformation(transformation, %Command{} = cmd, args) do
        apply(transformation, :transform, [cmd, args])
      end

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    transformations = Module.get_attribute(env.module, :transformations)
    quote do
      def transformations do
        unquote(transformations)
      end
    end
  end

  defmacro transformation(module) do
    quote do
      @transformations unquote(module)
    end
  end
end
