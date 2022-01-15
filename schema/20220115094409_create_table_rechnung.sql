-- +goose Up
-- +goose StatementBegin
CREATE SEQUENCE rechnung_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "rechnung" (
  "id" integer DEFAULT nextval('rechnung_id_seq') NOT NULL,
  "created_at" timestamptz DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz,
  "deleted_at" timestamptz,
  "billomat_id" integer,
  "client_id" integer,
  "invoice_number" text,
  "date" date,
  "total_net" NUMERIC(10,2),
  "total_gross" NUMERIC(10,2),
  CONSTRAINT "rechnung_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_rechnung_deleted_at" ON "rechnung" USING btree ("deleted_at");

CREATE TRIGGER tub_rechnung_timestamp
BEFORE UPDATE ON rechnung
FOR EACH ROW
EXECUTE PROCEDURE set_updated_timestamp();

CREATE RULE rechnung_delete AS ON DELETE TO rechnung
DO INSTEAD
UPDATE rechnung SET deleted_at = NOW()
WHERE rechnung.id = OLD.id;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS rechnung;

DROP SEQUENCE IF EXISTS rechnung_id_seq;
-- +goose StatementEnd
