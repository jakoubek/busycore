-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION import_rechnung()
RETURNS trigger
LANGUAGE plpgsql AS
$BODY$
DECLARE
  new_gebiet_id INTEGER;
  new_datum DATE;
BEGIN

  IF NOT EXISTS(SELECT 1 FROM busycore.rechnung WHERE billomat_id = NEW.billomat_id) THEN
    INSERT INTO busycore.rechnung (billomat_id, client_id, invoice_number, date, total_net, total_gross)
    VALUES (NEW.billomat_id, NEW.client_id, NEW.invoice_number, NEW.date, NEW.total_net, NEW.total_gross);
  END IF;

  RETURN NEW;
END;
$BODY$
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP FUNCTION IF EXISTS import_rechnung() CASCADE;
-- +goose StatementEnd
