defmodule CloseTreatments.McepdTest do
  use CloseTreatments.DataCase

  alias CloseTreatments.Mcepd

  describe "treatments" do
    alias CloseTreatments.Mcepd.Treatment

    @valid_attrs %{name: "some name", status: "some status"}
    @update_attrs %{name: "some updated name", status: "some updated status"}
    @invalid_attrs %{name: nil, status: nil}

    def treatment_fixture(attrs \\ %{}) do
      {:ok, treatment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mcepd.create_treatment()

      treatment
    end

    test "list_treatments/0 returns all treatments" do
      treatment = treatment_fixture()
      assert Mcepd.list_treatments() == [treatment]
    end

    test "get_treatment!/1 returns the treatment with given id" do
      treatment = treatment_fixture()
      assert Mcepd.get_treatment!(treatment.id) == treatment
    end

    test "create_treatment/1 with valid data creates a treatment" do
      assert {:ok, %Treatment{} = treatment} = Mcepd.create_treatment(@valid_attrs)
      assert treatment.name == "some name"
      assert treatment.status == "some status"
    end

    test "create_treatment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mcepd.create_treatment(@invalid_attrs)
    end

    test "update_treatment/2 with valid data updates the treatment" do
      treatment = treatment_fixture()
      assert {:ok, %Treatment{} = treatment} = Mcepd.update_treatment(treatment, @update_attrs)
      assert treatment.name == "some updated name"
      assert treatment.status == "some updated status"
    end

    test "update_treatment/2 with invalid data returns error changeset" do
      treatment = treatment_fixture()
      assert {:error, %Ecto.Changeset{}} = Mcepd.update_treatment(treatment, @invalid_attrs)
      assert treatment == Mcepd.get_treatment!(treatment.id)
    end

    test "delete_treatment/1 deletes the treatment" do
      treatment = treatment_fixture()
      assert {:ok, %Treatment{}} = Mcepd.delete_treatment(treatment)
      assert_raise Ecto.NoResultsError, fn -> Mcepd.get_treatment!(treatment.id) end
    end

    test "change_treatment/1 returns a treatment changeset" do
      treatment = treatment_fixture()
      assert %Ecto.Changeset{} = Mcepd.change_treatment(treatment)
    end
  end
end
