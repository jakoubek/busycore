-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION set_updated_timestamp()
RETURNS trigger
LANGUAGE plpgsql AS
$BODY$
BEGIN
  IF row(NEW.*) IS DISTINCT FROM row(OLD.*) THEN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  ELSE
    RETURN OLD;
  END IF;
END;
$BODY$;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP FUNCTION IF EXISTS set_updated_timestamp;
-- +goose StatementEnd
