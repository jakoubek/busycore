-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS "tmp_rechnung_import" (
  "billomat_id" integer,
  "client_id" integer,
  "invoice_number" text,
  "date" date,
  "total_net" NUMERIC(10,2),
  "total_gross" NUMERIC(10,2),
  "created_at" timestamptz DEFAULT CURRENT_TIMESTAMP
) WITH (oids = false);

CREATE TRIGGER tia_tmp_rechnung_import
AFTER INSERT ON tmp_rechnung_import
FOR EACH ROW
EXECUTE PROCEDURE import_rechnung();
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS tmp_rechnung_import;
-- +goose StatementEnd
