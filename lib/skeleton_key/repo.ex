defmodule SkeletonKey.Repo do
  use Ecto.Repo,
    otp_app: :skeleton_key,
    adapter: Ecto.Adapters.Postgres
end
