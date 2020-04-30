defmodule CloseTreatmentsWeb.TreatmentView do
  use CloseTreatmentsWeb, :view
  alias CloseTreatmentsWeb.TreatmentView

  def render("index.json", %{treatment: treatment}) do
    %{data: render_many(treatment, TreatmentView, "treatment.json")}
  end

  def render("show.json", %{treatment: treatment}) do
    %{data: render_one(treatment, TreatmentView, "treatment.json")}
  end

  def render("treatment.json", %{treatment: treatment}) do
    %{id: treatment.id,
      name: treatment.name,
      status: treatment.status}
  end
end
