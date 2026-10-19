# Auth API

Register, log in, and a protected route. One file, SQLite, no setup.

```sh
composer install
php -S localhost:5500 index.php
```

Then:

```sh
curl -X POST localhost:5500/register -H 'content-type: application/json' \
  -d '{"name":"Ada","email":"ada@example.com","password":"correct-horse"}'

curl -X POST localhost:5500/login -H 'content-type: application/json' \
  -d '{"email":"ada@example.com","password":"correct-horse"}'

curl localhost:5500/me -H "Authorization: Bearer <accessToken from login>"
```

`smoke.sh` runs all of that for you and is what CI runs on every push.

## The prompt

This is the kind of thing the skill is for. With the skill installed, ask your agent:

> Build me a Leaf 5 API with register, login and a protected `/me` route. SQLite, tokens, validation on the inputs.

It should land on something very close to `index.php`: `auth()->register()`, `auth()->login()`, a named `auth.required` middleware and `auth()->user()->get()` on the protected route. If it starts writing its own JWT code or a users table migration, the skill is not loaded.

Set `AUTH_TOKEN_SECRET` (32+ characters) before you deploy this anywhere real.
