defmodule SkeletonKey.Astrology.AstroClient do
  @moduledoc "Client module for the Radar API."
  alias SkeletonKey.Astrology.AstroClient.Http

  def catch_them_all(pokemon), do: Http.fetch_pokemon(pokemon)
end
