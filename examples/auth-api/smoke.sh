#!/usr/bin/env bash
# Starts the demo, registers a user, logs in, hits /me with and without the token.
set -e
cd "$(dirname "$0")"
rm -f app.sqlite
php ${PHP_FLAGS:-} -S 127.0.0.1:5577 index.php > /tmp/leaf-auth-demo.log 2>&1 &
PID=$!
trap 'kill $PID' EXIT
sleep 1
echo "== register"
curl -s -X POST localhost:5577/register -H 'content-type: application/json' \
  -d '{"name":"Ada","email":"ada@example.com","password":"correct-horse"}'; echo
echo "== login"
LOGIN=$(curl -s -X POST localhost:5577/login -H 'content-type: application/json' \
  -d '{"email":"ada@example.com","password":"correct-horse"}')
echo "$LOGIN"
TOKEN=$(echo "$LOGIN" | php -r 'echo json_decode(stream_get_contents(STDIN))->accessToken ?? "";')
echo "== /me without token"
curl -s -i localhost:5577/me | head -1
echo "== /me with token"
curl -s localhost:5577/me -H "Authorization: Bearer $TOKEN"; echo
