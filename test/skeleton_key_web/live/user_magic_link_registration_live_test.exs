defmodule SkeletonKeyWeb.UserMagicLinkRegistrationLiveTest do
  use SkeletonKeyWeb.ConnCase, async: true

  import SkeletonKey.AccountsFixtures
  import Phoenix.LiveViewTest

  describe "Registration page" do
    test "renders registration page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/user/register/magic-link")

      assert html =~ "Register"
      assert html =~ "Log in"
    end

    test "redirects if already logged in", %{conn: conn} do
      result =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/user/register/magic-link")
        |> follow_redirect(conn, "/")

      assert {:ok, _conn} = result
    end
  end

  describe "register user" do
    test "creates account and logs the user in", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/user/register/magic-link")

      email = unique_user_email()
      form = form(lv, "#magic_link_form", user: valid_magic_link_user_attributes(email: email))
      render_submit(form)
      conn = follow_trigger_action(form, conn)

      assert redirected_to(conn) == ~p"/"

      email_flash_msg = "Account created successfully! Check your email to confirm your account."
      assert Phoenix.Flash.get(conn.assigns.flash, :info) == email_flash_msg

      assert_received {:email, login_email}

      assert %Swoosh.Email{
               subject: "Confirmation instructions",
               from: {"SkeletonKey", "contact@example.com"},
               to: [{"", ^email}],
               cc: [],
               bcc: [],
               text_body: body,
               attachments: [],
               html_body: nil,
               reply_to: nil,
               headers: headers
             } = login_email

      assert headers == %{}

      assert [_, _, _, url, _, _] = String.split(body, "\n\n", trim: true)
      url = String.trim(url)

      assert %URI{scheme: "http", path: "/user/confirm/" <> token} = URI.parse(url)

      # Visit confirmation link and assert user is authenticated and lands on confirmation page
      conn = get(conn, "/user/confirm/#{token}")
      response = html_response(conn, 200)

      assert response =~ email
      assert response =~ "Confirm Account"
      assert response =~ "Log out"
      assert is_binary(conn.private.plug_session["user_token"])
    end
  end
end
