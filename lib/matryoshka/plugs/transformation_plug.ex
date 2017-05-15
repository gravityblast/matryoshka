defmodule Matryoshka.TransformationPlug do
  defmacro __using__(_) do
    quote do
      use Matryoshka.{BasePlug, Transformation}
      alias Matryoshka.{Command}

      def call(conn, _opts) do
        conn
        |> cmd
        |> run(conn.params)
        |> assign_cmd(conn)
      end
    end
  end

  def call(_conn, _opts) do
    # size = conn.params["size"]
    # conn
    # |> add_option("-thumbnail", "#{size}x#{size}")
    # |> add_option("-quality", "90")
    # |> add_option("-strip", nil)

    # |> add_option("-filter", "Triangle")
    # |> add_option("-define", "filter:support=2")
    # |> add_option("-unsharp", "0.25x0.25+8+0.065")
    # |> add_option("-dither", "None")
    # |> add_option("-posterize", "136")
    # |> add_option("-alpha", "Remove")
    # |> add_option("-sampling-factor", "4:2:0")
    # |> add_option("-define", "jpeg:fancy-upsampling=off")
    # |> add_option("-define", "png:compression-filter=5")
    # |> add_option("-define", "png:compression-level=9")
    # |> add_option("-define", "png:compression-strategy=1")
    # |> add_option("-define", "png:exclude-chunk=all")
    # |> add_option("-interlace", "none")
    # |> add_option("-colorspace", "sRGB")
  end
end
