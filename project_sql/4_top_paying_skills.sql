WITH salary AS (SELECT 
    skill_id, round(avg(job_postings_fact.salary_year_avg), 0) AS sal
FROM 
    skills_job_dim   
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE job_postings_fact.job_title_short = 'Data Analyst' AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skill_id)
SELECT 
      skills, salary.sal 
FROM skills_dim
INNER JOIN salary ON salary.skill_id = skills_dim.skill_id
ORDER BY sal DESC