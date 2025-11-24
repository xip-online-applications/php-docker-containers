curl -s https://raw.githubusercontent.com/nodejs/Release/master/schedule.json | jq -r --arg today "$(date +%Y-%m-%d)" '
  to_entries[] |
  select(.value.codename) |
  select(.value.end >= $today) |
  .key | ltrimstr("v")
' | sort -V | head -n 1
