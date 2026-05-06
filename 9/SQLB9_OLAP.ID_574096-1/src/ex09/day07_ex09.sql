SELECT 
person.address,
MAX(age) - (MIN(age)/MAX(age)) AS formula,
AVG(age) AS average,
((MAX(age) - (MIN(age)/MAX(age))) > AVG(age)) AS comparison
FROM person
GROUP BY person.address
ORDER BY address;