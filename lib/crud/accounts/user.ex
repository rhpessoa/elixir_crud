defmodule Crud.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :nascimento, :date
    field :salario, :decimal

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :salario, :nascimento])
    |> validate_required([:name, :email, :salario, :nascimento])
    |> validate_change(:nascimento,&validate_date(&1,&2))
    |> validate_number(:salario, greater_than: 0)
    |> validate_length(:name, min: 5, max: 40)
    |> unique_constraint(:email)
  end
  defp validate_date(_type,nascimento) do
    IO.inspect(nascimento)
    today = Date.utc_today
    if  Date.diff(today,nascimento) > 2 do
      [nascimento: "-5"]
    else
      []
    end
  end
end
