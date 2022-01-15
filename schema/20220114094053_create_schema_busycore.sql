-- +goose Up
-- +goose StatementBegin
CREATE SCHEMA IF NOT EXISTS busycore;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP SCHEMA IF EXISTS busycore CASCADE;
-- +goose StatementEnd
