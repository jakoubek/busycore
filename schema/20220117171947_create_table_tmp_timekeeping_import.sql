-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS "tmp_timekeeping_import" (
  "mite_record_id" integer,
  "date_at" date,
  "note" text,
  "mite_id" integer,
  "minutes" integer,
  "revenue" NUMERIC(10,2),
  "hourly_rate" integer,
  "created_at" timestamptz DEFAULT CURRENT_TIMESTAMP
) WITH (oids = false);

CREATE TRIGGER tia_tmp_timekeeping_import
AFTER INSERT ON tmp_timekeeping_import
FOR EACH ROW
EXECUTE PROCEDURE import_timekeeping();
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS tmp_timekeeping_import;
-- +goose StatementEnd
