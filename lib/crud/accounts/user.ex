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
    today = Date.utc_today
    teste = Date.diff(today,nascimento)
    IO.inspect(teste)
    date_diff = Date.diff(today,nascimento)
    if  date_diff >= 27375 || date_diff < 0  do
      [nascimento: "data inválida"]

    else
      []
    end
  end
end
