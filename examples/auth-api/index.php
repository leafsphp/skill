<?php

// A complete auth API in Leaf 5: register, login, and a protected route.
// Run it with:  php -S localhost:5500 index.php

require __DIR__ . '/vendor/autoload.php';

db()->connect(['dbtype' => 'sqlite', 'dbname' => __DIR__ . '/app.sqlite']);

db()->query('CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at TEXT,
    updated_at TEXT
)')->execute();

auth()->config('token.secret', getenv('AUTH_TOKEN_SECRET') ?: 'change-me-before-you-ship-at-least-32-chars-long');
auth()->config('unique', ['email']);

auth()->middleware('auth.required', function () {
    response()->exit(['error' => 'You need to be logged in'], 401);
});

app()->post('/register', function () {
    $data = request()->validate([
        'name' => 'string',
        'email' => 'email',
        'password' => 'min:8',
    ]);

    if (!$data) {
        return response()->exit(request()->errors(), 400);
    }

    if (!auth()->register($data)) {
        return response()->exit(auth()->errors(), 400);
    }

    response()->json(auth()->data(), 201);
});

app()->post('/login', function () {
    $data = request()->validate([
        'email' => 'email',
        'password' => 'string',
    ]);

    if (!$data) {
        return response()->exit(request()->errors(), 400);
    }

    if (!auth()->login($data)) {
        return response()->exit(auth()->errors(), 401);
    }

    response()->json(auth()->data());
});

app()->get('/me', ['middleware' => 'auth.required', function () {
    response()->json(auth()->user()->get());
}]);

app()->run();
