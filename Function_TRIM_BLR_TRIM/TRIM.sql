SELECT RTRIM('Hello.....', '.');
-- Output: 'Hello'

SELECT LTRIM('aaHello', 'a');
-- Output: 'Hello'

SELECT BTRIM('-Hello, World!-', '-');
-- Output: 'Hello, World!'

SELECT TRIM('   Hello, World!  ');
-- Output: 'Hello, World!'

-- Block_10m
WITH facttb AS (SELECT COUNT(card_id) AS SLXeVaoTruong,
                       date_trunc('hour', time_stamp + INTERVAL '7 hours')
                           + floor(EXTRACT(MINUTE FROM (time_stamp + INTERVAL '7 hours')) / 10) * INTERVAL '10 minutes'
                                      AS block_10m
                FROM event_scan_data esd
                JOIN cards ON esd.card_id = cards.card_code
                WHERE esd.created_at >= '2025-11-04 17:00:00.00 +00:00'
                  AND esd.created_at < '2025-11-05 17:00:00.00 +00:00'
                  AND check_in = false
                GROUP BY block_10m
                ORDER BY block_10m)
SELECT block_10m, SLXeVaoTruong,
       TO_CHAR(block_10m, 'HH24:MI:SS') AS formatted_time,
       DATE(block_10m + INTERVAL '7 hours') As Date
FROM facttb;

-- tìm log ra vào theo khung giờ
SELECT
    TO_CHAR(esd.created_at + INTERVAL '7 hours', 'HH24:MI:SS DD/MM/YYYY') AS formatted_time,
    DATE(esd.created_at + INTERVAL '7 hours') As Date,
    card_id,
    check_in,
    esd.user_id,
    plate_number
FROM
    event_scan_data esd
JOIN cards ON esd.card_id = cards.card_code
    WHERE (time_stamp + INTERVAL '7 hours') >= '2025-11-05 05:40:00.00 +00:00'
                  AND (time_stamp + INTERVAL '7 hours') < '2025-11-05 12:30:00.00 +00:00'
AND check_in = true
ORDER BY formatted_time
-- Đếm tổng theo thời gian
SELECT esd.*
FROM event_scan_data esd
                join cards on esd.card_id = cards.card_code
                WHERE (time_stamp + INTERVAL '7 hours') >= '2025-11-06 18:30:00.00 +00:00'
                  AND (time_stamp + INTERVAL '7 hours') < '2025-11-06 18:40:00.00 +00:00'
                  AND check_in = false;
