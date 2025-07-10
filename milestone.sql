CREATE DATABASE salary_data;
USE salary_data;
select * from salaries;

#1. Average Salary by Industry and Gender
SELECT 
    `Industry`, 
    `Gender`, 
    ROUND(AVG(`Final salary`), 2) AS avg_salary
FROM 
    `salaries`
GROUP BY 
    `Industry`, `Gender`;
    
    SELECT 
    `Industry category`, 
    `Gender`, 
    ROUND(AVG(`Final salary`), 2) AS avg_salary
FROM 
    `salaries`
GROUP BY 
    `Industry category`, `Gender`;
    
#2. Total Salary Compensation by Job Title
SELECT 
    `Job title`, 
    SUM(`Annual salary` + IFNULL(`Additional Monetary Compensation`, 0)) AS total_compensation
FROM 
    `salaries`
GROUP BY 
    `Job title`;

SELECT 
    `Industry category`, 
    SUM(`Annual salary` + IFNULL(`Additional Monetary Compensation`, 0)) AS total_compensation
FROM 
    `salaries`
GROUP BY 
    `Industry category`;

#3. Salary Distribution by Education Level
SELECT 
    `Highest level of education completed` AS education_level,
    MIN(`Final salary`) AS min_salary,
    MAX(`Final salary`) AS max_salary,
    ROUND(AVG(`Final salary`), 0) AS avg_salary
FROM 
    `salaries`
GROUP BY 
    `Highest level of education completed`;
    
#4. Number of Employees by Industry and Years of Experience
SELECT 
    `Industry`, 
    `Years of professional experience overall` AS experience, 
    COUNT(*) AS employee_count
FROM 
    `salaries`
GROUP BY 
    `Industry`, `Years of professional experience overall`;
    
SELECT 
    `Industry category`, 
    `Overall experience Category` AS experience, 
    COUNT(*) AS employee_count
FROM 
    `salaries`
GROUP BY 
    `Industry category`, `Overall experience Category`;
    
    
# 5. Median Salary by Age Range and Gender (using GROUP_CONCAT for MySQL < 8.0)
SELECT 
    `Age range`, 
    `Gender`,
    SUBSTRING_INDEX(
        SUBSTRING_INDEX(
            GROUP_CONCAT(`Final salary` ORDER BY `Final salary`), 
            ',', 
            FLOOR(COUNT(*) / 2) + 1
        ), 
        ',', 
        -1
    ) AS median_salary
FROM 
    `salaries`
GROUP BY 
    `Age range`, `Gender`;
    
    
#6. Job Titles with the Highest Salary in Each Country

SELECT 
    s1.`Country`, 
    s1.`Job title`, 
    s1.`Final salary`
FROM 
    `salaries` s1
JOIN (
    SELECT 
        `Country`, 
        MAX(`Final salary`) AS max_salary
    FROM 
        `salaries`
    GROUP BY 
        `Country`
) s2 ON s1.`Country` = s2.`Country` AND s1.`Final salary` = s2.`max_salary`;


#7. Average Salary by City and Industry

SELECT 
    `City`,`Country`, 
    `Industry`, 
    ROUND(AVG(`Final salary`),0) AS avg_salary
FROM 
    `salaries`
GROUP BY 
    `City`, `Country`,`Industry`;
    
# 8. Percentage of Employees with Additional Monetary Compensation by Gender

SELECT 
    `Gender`,
    ROUND(
        SUM(CASE WHEN `Additional Monetary Compensation` > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS percentage_with_comp
FROM 
    `salaries`
GROUP BY 
    `Gender`;
    
    
#9. Total Compensation by Job Title and Years of Experience

SELECT 
    `Job title`,`Overall experience Category`,
    `Years of professional experience overall` AS experience,
    SUM(`Annual salary` + IFNULL(`Additional Monetary Compensation`, 0)) AS total_compensation
FROM 
    `salaries`
GROUP BY 
    `Job title`,`Overall experience Category`, `Years of professional experience overall`;
    
    
#10. Average Salary by Industry, Gender, and Education Level

SELECT 
    `Industry`,
    `Gender`,
    `Highest level of education completed` AS education_level,
    ROUND(AVG(`Final salary`),0) AS avg_salary
FROM 
    `salaries`
GROUP BY 
    `Industry`, `Gender`, `Highest level of education completed`;










