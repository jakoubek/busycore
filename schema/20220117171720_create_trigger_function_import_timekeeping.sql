-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION import_timekeeping()
RETURNS trigger
LANGUAGE plpgsql AS
$BODY$
BEGIN

  IF NOT EXISTS(SELECT 1 FROM busycore.timekeeping WHERE mite_record_id = NEW.mite_record_id) THEN
    INSERT INTO busycore.timekeeping (mite_record_id, date_at, note, mite_id, minutes, revenue, hourly_rate)
    VALUES (NEW.mite_record_id, NEW.date_at, NEW.note, NEW.mite_id, NEW.minutes, NEW.revenue/100.0, NEW.hourly_rate/100.0);
  END IF;

  RETURN NEW;
END;
$BODY$
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP FUNCTION IF EXISTS import_timekeeping() CASCADE;
-- +goose StatementEnd
