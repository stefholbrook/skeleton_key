defmodule SkeletonKeyWeb.UserMagicLinkRegistrationLive do
  @moduledoc false
  use SkeletonKeyWeb, :live_view

  alias SkeletonKey.Accounts

  require Logger

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm mx-auto max-w-sm flex flex-col justify-center min-h-screen">
      <.header class="text-center">
        Register for an account
        <:subtitle>
          Already registered?
          <.link navigate={~p"/user/log_in"} class="font-semibold text-brand hover:underline">
            Log in
          </.link>
          to your account now.
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="magic_link_form"
        phx-trigger-action={@trigger_action}
        action={~p"/user/log_in?_action=registered"}
        phx-submit="save"
        method="post"
      >
        <.input field={@form[:email]} type="email" label="Email" required />
        <:actions>
          <.button>
            Send me a link <.icon name="hero-envelope" />
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")

    {:ok, assign(socket, form: form, trigger_action: false), temporary_assigns: [form: form]}
  end

  def handle_event("save", %{"user" => %{"email" => _email} = user_params}, socket) do
    user_params
    |> Accounts.register_magic_link_user()
    |> save(socket)
  end

  defp save(user, socket) do
    case user do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/user/confirm/#{&1}")
          )

        {:noreply, assign(socket, trigger_action: true)}

      error ->
        Logger.error("Could not deliver user confirmation: #{inspect(error)}")
        {:noreply, socket}
    end
  end
end
