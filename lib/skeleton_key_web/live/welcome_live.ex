defmodule SkeletonKeyWeb.WelcomeLive do
  use SkeletonKeyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_user={@current_user}>
      <div>Welcome</div>
    </Layouts.app>
    """
  end
end
