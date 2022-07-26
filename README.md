# gymbud
App for visualizing gym activities, exercises feature to come.

# Links for needed dependencies
- https://docs.docker.com/compose/install/

# Initialization
- docker-compose build
- docker-compose run --rm phoenix mix deps.get
- docker-compose run --rm phoenix mix ecto.create
- docker-compose run --rm phoenix mix ecto.migrate
- docker-compose up

# Key files for your own app
- Dockerfile (all)
- docker-compose.yml (all)
- dev.exs (hostname: "db", http: [ip: {0, 0, 0, 0}, port: 4000])

Template for an app with the ff dependencies:
- Phoenix 1.6.6
- Elixir
- LiveView

Functionalities
- Workout resource CRUD
