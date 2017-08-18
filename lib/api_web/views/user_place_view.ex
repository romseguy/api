defmodule ApiWeb.UserPlaceView do
  use ApiWeb, :view
  alias ApiWeb.UserPlaceView

  def render("index.json", %{user_places: user_places}) do
    %{data: render_many(user_places, UserPlaceView, "user_place.json")}
  end

  def render("show.json", %{user_place: user_place}) do
    %{data: render_one(user_place, UserPlaceView, "user_place.json")}
  end

  def render("user_place.json", %{user_place: user_place}) do
    %{id: user_place.id}
  end
end
