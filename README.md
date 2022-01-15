# busycore
PostgreSQL database structures for my mini "ERP"


## Database migrations

Database migrations are set up with [Goose](https://github.com/pressly/goose).

**Note**

All structures are created in a schema named *busycore*. The creation of this schema must be manual because goose cannot create the target schema itself (unless the goose migrations table is in another schema, i.e. public).

