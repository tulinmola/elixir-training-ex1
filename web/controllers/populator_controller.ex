defmodule Ex1.PopulatorController do
  use Ex1.Web, :controller

  alias Ex1.Movies

  def populate(conn, _params) do
    Movies.populate()
    redirect(conn, to: "/movies")
  end
end
