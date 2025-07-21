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
