defmodule CloseTreatmentsWeb.TreatmentController do
  use CloseTreatmentsWeb, :controller

  alias CloseTreatments.Mcepd
  alias CloseTreatments.Mcepd.Treatment

  action_fallback CloseTreatmentsWeb.FallbackController

  def index(conn, _params) do
    treatment = Mcepd.list_treatments()
    render(conn, "index.json", treatment: treatment)
  end

  def create(conn, %{"treatment" => treatment_params}) do
    with {:ok, %Treatment{} = treatment} <- Mcepd.create_treatment(treatment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.treatment_path(conn, :show, treatment))
      |> render("show.json", treatment: treatment)
    end
  end

  def show(conn, %{"id" => id}) do
    treatment = Mcepd.get_treatment!(id)
    render(conn, "show.json", treatment: treatment)
  end

  def update(conn, %{"id" => id, "treatment" => treatment_params}) do
    treatment = Mcepd.get_treatment!(id)

    with {:ok, %Treatment{} = treatment} <- Mcepd.update_treatment(treatment, treatment_params) do
      render(conn, "show.json", treatment: treatment)
    end
  end

  def delete(conn, %{"id" => id}) do
    treatment = Mcepd.get_treatment!(id)

    with {:ok, %Treatment{}} <- Mcepd.delete_treatment(treatment) do
      send_resp(conn, :no_content, "")
    end
  end
end
