defmodule Vegsochk.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :token, :string

      add :user_id, references(:users, on_delete: :delete_all), null: false 
      timestamps()
    end

    create index(:sessions, [:user_id])
    create index(:sessions, [:token], unique: true)
  end
end
