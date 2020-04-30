defmodule CloseTreatmentsWeb.TreatmentControllerTest do
  use CloseTreatmentsWeb.ConnCase

  alias CloseTreatments.Mcepd
  alias CloseTreatments.Mcepd.Treatment

  @create_attrs %{
    name: "some name",
    status: "some status"
  }
  @update_attrs %{
    name: "some updated name",
    status: "some updated status"
  }
  @invalid_attrs %{name: nil, status: nil}

  def fixture(:treatment) do
    {:ok, treatment} = Mcepd.create_treatment(@create_attrs)
    treatment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all treatment", %{conn: conn} do
      conn = get(conn, Routes.treatment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create treatment" do
    test "renders treatment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.treatment_path(conn, :create), treatment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.treatment_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.treatment_path(conn, :create), treatment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update treatment" do
    setup [:create_treatment]

    test "renders treatment when data is valid", %{conn: conn, treatment: %Treatment{id: id} = treatment} do
      conn = put(conn, Routes.treatment_path(conn, :update, treatment), treatment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.treatment_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, treatment: treatment} do
      conn = put(conn, Routes.treatment_path(conn, :update, treatment), treatment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete treatment" do
    setup [:create_treatment]

    test "deletes chosen treatment", %{conn: conn, treatment: treatment} do
      conn = delete(conn, Routes.treatment_path(conn, :delete, treatment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.treatment_path(conn, :show, treatment))
      end
    end
  end

  defp create_treatment(_) do
    treatment = fixture(:treatment)
    %{treatment: treatment}
  end
end
