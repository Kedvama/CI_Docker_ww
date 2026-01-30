## Run

1) Copy env file
   cp .env.example .env

2) Start
   docker compose --env-file .env -f docker-compose.yml up -d --pull=always
