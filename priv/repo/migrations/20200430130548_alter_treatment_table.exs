defmodule CloseTreatments.Repo.Migrations.AlterTreatmentTable do
  use Ecto.Migration

  def change do
    alter table("treatment") do
      modify(:status, :string, size: 40, null: false)
    end
  end
end
