-- Implement your solution here
WITH hostTeamWins AS (
    SELECT host_team AS team_id, SUM(CASE WHEN host_goals > guest_goals THEN 3
    WHEN host_goals = guest_goals THEN 1 ELSE 0 END) AS points
    FROM matches 
    GROUP BY 1
),
guestTeamWins AS (
    SELECT guest_team AS team_id, SUM(CASE WHEN guest_goals > host_goals THEN 3
    WHEN host_goals = guest_goals THEN 1 ELSE 0 END) AS points
    FROM matches 
    GROUP BY 1
),
data AS (
    SELECT * FROM hostTeamWins UNION ALL SELECT * FROM guestTeamWins
)
SELECT t.team_id, t.team_name, COALESCE(SUM(points), 0) AS num_points
FROM teams t
LEFT OUTER JOIN data d on d.team_id = t.team_id
GROUP BY 1, 2
ORDER by 3 DESC, 1
