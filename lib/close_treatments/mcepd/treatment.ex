defmodule CloseTreatments.Mcepd.Treatment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "treatment" do
    field :name, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(treatment, attrs) do
    treatment
    |> cast(attrs, [:name, :status])
    |> validate_required([:name, :status])
  end
end
