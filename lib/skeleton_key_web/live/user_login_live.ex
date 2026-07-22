defmodule SkeletonKeyWeb.UserLoginLive do
  use SkeletonKeyWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm flex flex-col justify-center min-h-screen">
      <Layouts.theme_toggle />
      <.header class="text-center">
        Log in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/user/register"} class="font-semibold text-brand hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/user/log_in"} phx-update="ignore">
        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
          <.link href={~p"/user/reset_password"} class="text-sm font-semibold">
            Forgot your password?
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in..." class="w-full">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>

      <div class="flex justify-center mt-8">
        <div class="align-center">OR</div>
      </div>

      <.simple_form
        :let={f}
        for={@form}
        as={:magic_link_user}
        id="magic_link_form"
        action={~p"/user/log_in?_action=magic_link"}
        phx-update="ignore"
      >
        <%!-- class="w-full" --%>
        <.input field={f[:email]} type="email" label="Email" required />
        <:actions>
          <.button class="w-full">
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
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
