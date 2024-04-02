WITH demanding_jobs AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS skill_count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id       
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    GROUP BY
        s kills_dim.skill_id, skills_dim.skills
),
salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS sal
    FROM
        job_postings_fact 
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id       
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    demanding_jobs.skill_id,
    demanding_jobs.skills,
    demanding_jobs.skill_count,
    salary.sal
FROM
    demanding_jobs
INNER JOIN
    salary ON demanding_jobs.skill_id = salary.skill_id
ORDER BY 
    demanding_jobs.skill_count DESC    

