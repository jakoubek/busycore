-- +goose Up
-- +goose StatementBegin
CREATE SEQUENCE timekeeping_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "timekeeping" (
  "id" integer DEFAULT nextval('timekeeping_id_seq') NOT NULL,
  "created_at" timestamptz DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz,
  "deleted_at" timestamptz,
  "mite_record_id" integer,
  "date_at" date,
  "note" text,
  "mite_id" integer,
  "minutes" integer,
  "revenue" NUMERIC(10,2),
  "hourly_rate" integer,
  CONSTRAINT "timekeeping_id_seq_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_timekeeping_deleted_at" ON "timekeeping" USING btree ("deleted_at");

CREATE TRIGGER tub_timekeeping_timestamp
BEFORE UPDATE ON timekeeping
FOR EACH ROW
EXECUTE PROCEDURE set_updated_timestamp();

CREATE RULE timekeeping_delete AS ON DELETE TO timekeeping
DO INSTEAD
UPDATE timekeeping SET deleted_at = NOW()
WHERE timekeeping.id = OLD.id;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS timekeeping;

DROP SEQUENCE IF EXISTS timekeeping_id_seq;
-- +goose StatementEnd
