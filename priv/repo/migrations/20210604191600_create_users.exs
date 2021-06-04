defmodule Crud.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :salario, :decimal
      add :nascimento, :date

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
