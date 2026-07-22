defmodule SkeletonKey.Factory do
  @moduledoc false
  # with Ecto
  use ExMachina.Ecto, repo: SkeletonKey.Repo

  def user_factory do
    %SkeletonKey.Accounts.User{
      email: "user#{System.unique_integer()}@example.com",
      password: "hello world!"
    }
  end
end
