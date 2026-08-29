defmodule SkeletonKey.Astrology.AstroClient.Http do
  require Logger

  def fetch_pokemon(pokemon) do
    pokemon = String.downcase(pokemon)

    "/pokemon/#{pokemon}"
    |> get()
    |> handle_response()
  end

  defp get(path) do
    req_opts =
      :req_opts
      |> config([])
      |> Keyword.merge(params: [], headers: [])

    Req.get("https://pokeapi.co/api/v2#{path}")
  end

  defp config(_key, _default) do
    # fetch env configs/keys to pass to api here
    :ok
  end

  defp handle_response({:ok, %Req.Response{body: body}}),
    do: {:ok, body}

  defp handle_response(response) do
    Logger.error("Encounterd #{inspect(response)} while attempting to fetch pokemon.")
    {:error, :unknown}
  end
end
