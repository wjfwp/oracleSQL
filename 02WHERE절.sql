--WHERE절
SELECT * FROM EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE SALARY = 4800; --같다
SELECT * FROM EMPLOYEES WHERE SALARY <> 4800; --같지 않다
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID >= 100;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID < 50;
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'AD_ASST'; --문자
SELECT * FROM EMPLOYEES WHERE HIRE_DATE = '03/09/17'; --날짜

--BETWEEN~AND, IN, LIKE
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 6000 AND 9000; --이상~이하
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '08/01/01' AND '08/12/31'; --날짜도 대소비교가 됩니다.(좋은 방법은 아님)

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (10,20,30,40,50); --정확히 일치하는
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('ST_MAN', 'IT_PROG', 'HR_REP');

SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE 'IT%'; --IT로 시작하는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03'; --3일로 끝나는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%12%'; --12가 포함된
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '___05%'; 
SELECT * FROM EMPLOYEES WHERE EMAIL LIKE '_A%'; --A가 두번째에 있는

IS NULL, IS NOT NULL
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL; --X
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

--NOT, OR, AND
SELECT * FROM EMPLOYEES WHERE NOT SALARY >= 6000; --NOT은 <>과 동일한 표현
--AND가 OR보다 우선순위가 빠름
SELECT * FROM EMPLOYEES WHERE SALARY >= 6000 AND SALARY <= 12000; --BETWEEN 6000 AND 12000
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' AND SALARY >= 6000;
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR SALARY  >= 6000;

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR' AND SALARY >= 6000; --FI중 6000이상인 사람 OR IT_PRO인 사람
SELECT * FROM EMPLOYEES WHERE (JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR') AND SALARY >= 6000; --FI거나 IT 중 6000이상인 사람

--------------------------------------------------------------------------------
--ORDER BY 컬럼(엘리어스)
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE; --날짜 기준 ASC
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE DESC;

SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'ST_MAN') ORDER BY FIRST_NAME DESC; --문자는 사전등재순
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 6000 AND 12000 ORDER BY EMPLOYEE_ID;
--ALIAS도 ORDER절에 사용할 수 있음
SELECT FIRST_NAME, SALARY * 12 AS PAY FROM EMPLOYEES ORDER BY PAY ASC;
--정렬 여러개 ,로 나열
SELECT FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES ORDER BY JOB_ID ASC, SALARY DESC ;
