# Atex -Apex Legends Tracker ex-

Apex Legends Trackerのログを見る。

## Required

- Overwolf
  - Apex Legends Tracker
- Docker Desktop
  - Home Editionなら[ココ](https://docs.docker.jp/docker-for-windows/install-windows-home.html)を見たらよさそう。

## Usage

### Preparation
- Discordのbotを作成し、好きなサーバーに参加させる。
- Atexのルートディレクトリに.envファイルを作成。
  - 参考: .env.template
- Atexのルートディレクトリで以下を実行
  - `docker build -t log_parser .\log_parser\`
  - `docker build -t message_bot .\message_bot\`

### Execution

```
docker compose up -d
```

#### Update database

```
docker compose exec message_bot ./stars.sh
```

#### Import Custom List

```
docker compose exec redis /import_custom_list.sh
```

## Features

- マッチの参加者リストをDiscordに投稿
- マッチに有名人のIDと一致する参加者がいることをDiscordに投稿

## Note
- Apex Legends Trackerのログの場所は適当なので、必要ならdocker-compose.ymlを直接修正してください。
