-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE VIEW v_turnover_per_year
AS
SELECT  EXTRACT(year FROM date) AS jahr,
        COUNT(*) AS anzahl,
        ROUND(SUM(r.total_net)) AS nettoumsatz
FROM    rechnung AS r
GROUP BY jahr
HAVING EXTRACT(year FROM date) > 2005
ORDER BY jahr DESC
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP VIEW IF EXISTS v_turnover_per_year;
-- +goose StatementEnd
