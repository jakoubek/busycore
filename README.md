# busycore
PostgreSQL database structures for my mini "ERP"


## Database migrations

Database migrations are set up with [Goose](https://github.com/pressly/goose).

**Note**

All structures are created in a schema named *busycore*. The creation of this schema must be manual because goose cannot create the target schema itself (unless the goose migrations table is in another schema, i.e. public).


## Import invoices

I import invoices from my [Billomat account](https://www.billomat.com) using [their API](https://www.billomat.com/api/). The connection between Billomat's API and the PostgreSQL database is done in [Integromat](https://www.integromat.com). To avoid having to check if an invoice already exists in the invoice table (*rechnung*) I import into a helper table called *tmp_import_rechnung*. A trigger on that table checks if the invoice already exists; if not the real invoice record is created. That way I can safely run an import several times.
