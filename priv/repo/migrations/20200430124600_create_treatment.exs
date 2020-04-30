defmodule CloseTreatments.Repo.Migrations.CreateTreatment do
  use Ecto.Migration

  def change do
    create table(:treatment) do
      add :name, :string, null: false
      add :status, :string, null: false

      timestamps()
    end
  end
end
