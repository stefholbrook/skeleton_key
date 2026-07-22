defmodule SkeletonKeyWeb.PageControllerTest do
  @moduledoc false
  use SkeletonKeyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ ""
  end
end
