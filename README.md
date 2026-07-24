# SkeletonKey

### Running SkeletonKey

#### With Docker
  Run `docker compose up`

Now you can visit [`http:localhost:4000/user/login`](http://localhost:4000/user/log_in) from your browser.

#### With Elixir

Install `asdf`

In the project run `asdf install` to execute .tool-versions in the project.

Run the following: 

```
> mix setup
> mix phx.server
```

### Login / Register

You can register or log in a user through email/password combination or through a magiclink.

#### Magiclink

Registering a user will send them a confirmation email that will direct the user to a "confirmation" page and authenticate them, whereas logging in will send a "sign in" email to log in to the account.

Emails are sent to [`/dev/mailbox`](http://localhost:4000/dev/mailbox), but will also output in the logs. It will look like the example below. Just follow the link to log in.

```text
==============================
Hi test@email.com,
Please use this link to sign in:
http://localhost:4000/user/log_in/-xxVRm0j_BGGTb2ox4XeHdiexY-XUyEqQbCeocwPG9k
If you didn't request this email, feel free to ignore this.
==============================
```

When you're ready to add an email service, consult the [Swoosh documentation](https://github.com/swoosh/swoosh/blob/main/README.md#adapters).

### Admin

An admin experience is available on [`/admin/users`](http://localhost:4000/admin/users)

From here you can run basic CRUD operations on users. 

### TODO

* Fix tests
* Minor style/UI fixes
* Authorization (there are currently no permissions set for the admin and any user can visit this page)
