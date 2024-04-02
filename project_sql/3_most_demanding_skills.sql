WITH demanding_jobs AS 
(
SELECT skill_id, COUNT(*) AS skill_count
FROM skills_job_dim
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY skill_id
)
SELECT skills_dim.skills, demanding_jobs.skill_count
FROM skills_dim
INNER JOIN demanding_jobs ON demanding_jobs.skill_id = skills_dim.skill_id
ORDER BY demanding_jobs.skill_count DESC LIMIT 5;