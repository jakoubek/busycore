-- +goose Up
-- +goose StatementBegin
CREATE SEQUENCE kunde_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "kunde" (
  "id" integer DEFAULT nextval('kunde_id_seq') NOT NULL,
  "created_at" timestamptz DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz,
  "deleted_at" timestamptz,
  "name" text NOT NULL UNIQUE,
  "firma" text,
  "kundennummer" text UNIQUE,
  "billomat_id" integer,
  "mite_id" integer,
  CONSTRAINT "kunde_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_kunde_deleted_at" ON "kunde" USING btree ("deleted_at");

CREATE TRIGGER tub_kunde_timestamp
BEFORE UPDATE ON kunde
FOR EACH ROW
EXECUTE PROCEDURE set_updated_timestamp();

CREATE RULE kunde_delete AS ON DELETE TO kunde
DO INSTEAD
UPDATE kunde SET deleted_at = NOW()
WHERE kunde.id = OLD.id;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS kunde;

DROP SEQUENCE IF EXISTS kunde_id_seq;
-- +goose StatementEnd
