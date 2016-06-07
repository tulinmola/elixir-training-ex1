defmodule Ex1.Movies do
  @seed_filename "priv/data/imdb-movie-data.json"

  defstruct id: -1, title: "", year: -1, cover: "", plot: ""

  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def new do
    %{__struct__: __MODULE__}
  end

  def insert(%__MODULE__{} = movie) do
    Agent.update(__MODULE__, &Enum.into(&1, [movie]))
    movie
  end

  def insert(attrs) do
    insert(movie_from_params(attrs))
  end

  def delete_all do
    Agent.update(__MODULE__, fn(_) -> [] end)
  end

  def all do
    Agent.get(__MODULE__, &(&1))
  end

  def first do
    Agent.get(__MODULE__, fn(movies) -> Enum.at(movies, 0) end)
  end

  def get(id) do
    Agent.get(__MODULE__, fn(movies) ->
      movies |> Enum.find(&(&1.id == id))
    end)
  end

  def get!(id) do
    get(id) || raise "Couldn't find movie with id: #{id}"
  end

  def populate do
    IO.inspect "--- populating!"
    Agent.update(__MODULE__, fn(movies) ->
      IO.inspect "--- doing real population"
      load_from_file |> Enum.reduce(movies, fn(movie, acc) ->
        Enum.into(acc, [movie])
      end)
    end)
  end

  defp movie_from_params(attrs) do
    {year, _} = Integer.parse(attrs["year"] || "-1")
    %{__struct__: __MODULE__,
      id: uuid,
      title: attrs["title"] || "",
      year: year,
      cover: attrs["cover"] || "",
      plot: attrs["plot"] || ""}
  end

  defp load_from_file do
    {:ok, content} = File.read(@seed_filename)

    content
    |> Poison.Parser.parse!
    |> Enum.map(&filter_movie/1)
    |> Enum.filter(&(&1 != nil))
  end

  defp filter_movie(%{"title" => title, "year" => year, "plot_simple" => plot,
                    "poster" => %{"imdb" => cover}}) do
    IO.inspect "--- filtering #{title}"
    %{__struct__: __MODULE__, id: uuid, title: title, year: year, cover: cover,
      plot: plot}
  end
  defp filter_movie(_), do: nil

  defp uuid do
    UUID.uuid4()
  end
end
