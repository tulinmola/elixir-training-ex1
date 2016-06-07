defmodule Ex1.MovieControllerTest do
  use Ex1.ConnCase

  alias Ex1.Movies

  @valid_attrs %{"cover" => "cover", "plot" => "plot", "title" => "title", "year" => "42"}

  setup %{conn: conn} do
    Movies.delete_all
    {:ok, conn: conn}
  end

  defp insert_movie(attrs) do
    @valid_attrs
    |> Map.merge(attrs)
    |> Movies.insert
  end
  defp insert_movie, do: insert_movie(%{})

  # test "lists empty entries on index and new movie link", %{conn: conn} do
  #   conn = get conn, movie_path(conn, :index)
  #   html = html_response(conn, 200)
  #
  #   assert "Listing movies" = html |> Floki.find("h2") |> Floki.text
  #   refute html |> Floki.find("ul.movies") |> Enum.empty?
  #
  #   [new_movie] = html |> Floki.find("a.new-movie")
  #   assert ["/movies/new"] = new_movie |> Floki.attribute("href")
  # end
  #
  # test "lists all entries on index", %{conn: conn} do
  #   first = insert_movie(%{"title" => "first"})
  #   second = insert_movie(%{"title" => "second"})
  #
  #   conn = get conn, movie_path(conn, :index)
  #   html = html_response(conn, 200)
  #
  #   items = html |> Floki.find("ul.movies li a")
  #   assert second.title == items |> Enum.at(0) |> Floki.text
  #   assert first.title == items |> Enum.at(1) |> Floki.text
  #   assert ["/movies/#{second.id}"] == items |> Enum.at(0) |> Floki.attribute("href")
  #   assert ["/movies/#{first.id}"] == items |> Enum.at(1) |> Floki.attribute("href")
  # end
  #
  # test "renders form for new movie", %{conn: conn} do
  #   conn = get conn, movie_path(conn, :new)
  #   html = html_response(conn, 200)
  #
  #   assert "New movie" = html |> Floki.find("h2") |> Floki.text
  #   refute html |> Floki.find("form") |> Enum.empty?
  # end
  #
  # test "creates resource and redirects when data is valid", %{conn: conn} do
  #   conn = post conn, movie_path(conn, :create), movie: @valid_attrs
  #   assert redirected_to(conn) == movie_path(conn, :index)
  #
  #   assert @valid_attrs["title"] == Movies.first.title
  # end
  #
  # test "shows chosen resource", %{conn: conn} do
  #   movie = insert_movie()
  #   conn = get conn, movie_path(conn, :show, movie)
  #
  #   html = html_response(conn, 200)
  #   refute html |> Floki.find(".movie") |> Enum.empty?
  #
  #   title = "#{movie.title}, #{movie.year}"
  #   assert title == html |> Floki.find(".movie h2") |> Floki.text
  #
  #   [cover_image] = html |> Floki.find(".movie img")
  #   assert [@valid_attrs["cover"]] == cover_image |> Floki.attribute("src")
  #
  #   [plot_paragraph] = html |> Floki.find(".movie p")
  #   assert @valid_attrs["plot"] == plot_paragraph |> Floki.text
  #
  #   [back_link] = html |> Floki.find("a.back")
  #   assert ["/movies"] = back_link |> Floki.attribute("href")
  # end

end
