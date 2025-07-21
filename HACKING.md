# On apple silicon

I found these bundler configs to help:

```
build.nio4r
Set for the current user ($HOME/.bundle/config): "--with-cflags=-Wno-incompatible-pointer-types"

build.ffi
Set for the current user ($HOME/.bundle/config): "--enable-libffi-alloc"

build.pg
Set for the current user ($HOME/.bundle/config): "--with-pg_config=/opt/homebrew/opt/postgresql@17/bin/pg_config"
```

# Google oauth

Create Google Auth Platform / Clients / OAuth 2.0 Client ID:
* Name: Dev
* URI: http://localhost:3031
* Redirect URI: http://localhost:3031/auth/google/callback

Create a .env file using Client ID (from client list) and secret (from edit / info):

```
export GOOGLE_OAUTH_ID="..."
export GOOGLE_OAUTH_SECRET="..."
```

Then `source .env`.
