WITH top_paying_job_skills AS 
(
SELECT 
      job_id,
      job_title,
      name AS company_name,
      job_location,
      job_schedule_type,
      salary_year_avg
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id    
WHERE
    job_title_short = 'Data Analyst' And job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
)
SELECT 
      top_paying_job_skills.*,skills 
FROM top_paying_job_skills
INNER JOIN skills_job_dim ON top_paying_job_skills.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC ;