defmodule ElixirKatas.Tasky.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :title, :string
    field :is_complete, :boolean, default: false
    field :is_favorite, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :is_complete, :is_favorite])
    |> validate_required([:title])
  end
end
