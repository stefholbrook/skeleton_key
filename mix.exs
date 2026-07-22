defmodule SkeletonKey.MixProject do
  use Mix.Project

  def project do
    [
      app: :skeleton_key,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      compilers: [:phoenix_live_view] ++ Mix.compilers(),
      listeners: [Phoenix.CodeReloader],
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        list_unused_filters: true,
        plt_file: {:no_warn, "plts/skeleton_key.plt"},
        plt_add_apps: [:ex_unit, :mix, :fun_with_flags]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SkeletonKey.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  def cli do
    [
      preferred_envs: [precommit: :test]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bandit, "~> 1.12.0"},
      {:bcrypt_elixir, "~> 3.3.1"},
      {:credo, "~> 1.7.12", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dns_cluster, "~> 0.2.0"},
      {:ecto_sql, "~> 3.14.0"},
      {:esbuild, "~> 0.10.0", runtime: Mix.env() == :dev},
      {:ex_machina, "~> 2.8"},
      {:floki, ">= 0.37.1", only: :test},
      {:gettext, "~> 1.0.2"},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:jason, "~> 1.2"},
      {:lazy_html, ">= 0.1.0", only: :test},
      {:phoenix, "~> 1.8.3"},
      {:phoenix_ecto, "~> 4.7.0"},
      {:phoenix_html, "~> 4.3.0"},
      {:phoenix_live_dashboard, "~> 0.8.7"},
      {:phoenix_live_reload, "~> 1.6.2", only: :dev},
      {:phoenix_live_view, "~> 1.2.7"},
      {:postgrex, ">= 0.20.0"},
      {:rename_project, "~> 0.1.0", only: :dev},
      {:req, "~> 0.5"},
      {:styler, "~> 1.11.0", only: [:dev, :test], runtime: false},
      {:swoosh, "~> 1.26.3"},
      {:tailwind, "~> 0.5.1", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 1.1.0"},
      {:telemetry_poller, "~> 1.3.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["compile", "tailwind skeleton_key", "esbuild skeleton_key"],
      "assets.deploy": [
        "tailwind skeleton_key --minify",
        "esbuild skeleton_key --minify",
        "phx.digest"
      ]
    ]
  end
end
