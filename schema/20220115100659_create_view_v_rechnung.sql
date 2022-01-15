-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE VIEW v_rechnung
AS
  SELECT *
  FROM   rechnung
  WHERE  deleted_at IS NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP VIEW IF EXISTS v_rechnung;
-- +goose StatementEnd
