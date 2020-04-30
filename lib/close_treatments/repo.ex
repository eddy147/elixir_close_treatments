defmodule CloseTreatments.Repo do
  use Ecto.Repo,
    otp_app: :close_treatments,
    adapter: Ecto.Adapters.MyXQL
end
