--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID >(SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN(SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');


--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT *
FROM (SELECT FIRST_NAME,
        ROWNUM RN
        FROM (SELECT * 
                FROM EMPLOYEES 
                ORDER BY FIRST_NAME DESC))
WHERE RN BETWEEN 41 AND 50;


--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.

SELECT *
FROM(SELECT ROWNUM RN,
       EMPLOYEE_ID,
       FIRST_NAME,
       PHONE_NUMBER
      FROM(SELECT * 
           FROM EMPLOYEES 
           ORDER BY HIRE_DATE))
WHERE RN >=31 AND RN <=40;

--TEACHER
SELECT *
FROM( SELECT E.*,
             ROWNUM RN
         FROM (SELECT EMPLOYEE_ID,
                      FIRST_NAME || ' '|| LAST_NAME AS NAME,
                      PHONE_NUMBER,
                      HIRE_DATE
               FROM EMPLOYEES
               ORDER BY HIRE_DATE) E
      )
WHERE RN >=31 AND RN <=40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT E.EMPLOYEE_ID AS �������̵�, 
       CONCAT(FIRST_NAME,' ' || LAST_NAME) AS �̸�,
       E.DEPARTMENT_ID AS �μ����̵�,
       D.DEPARTMENT_NAME AS �μ���
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT EMPLOYEE_ID AS �������̵�,
       CONCAT(FIRST_NAME, ' ' || LAST_NAME) AS �̸�,
       DEPARTMENT_ID AS �μ����̵�,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS �μ��̸�
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����

SELECT D.DEPARTMENT_ID AS �μ����̵�,
       D.DEPARTMENT_NAME AS �μ��̸�,
       D.MANAGER_ID AS �Ŵ������̵�,
       D.LOCATION_ID AS �����̼Ǿ��̵�,
       L.STREET_ADDRESS AS ��Ʈ��_��巹��,
       L.POSTAL_CODE AS ����Ʈ�ڵ�,
       L.CITY AS ��Ƽ
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;

--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT D.*,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS STREET_ADDRESS,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS POSTAL_CODE,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS CITY
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT L.LOCATION_ID AS �����̼Ǿ��̵�,
       L.STREET_ADDRESS AS �ּ�,
       L.CITY,
       L.COUNTRY_ID,
       C.COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT L.LOCATION_ID AS �����̼Ǿ��̵�,
       L.STREET_ADDRESS AS �ּ�,
       L.CITY,
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID )
FROM LOCATIONS L;


--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.

SELECT *
FROM(SELECT ROWNUM RN,
            A.*
       FROM (SELECT E.EMPLOYEE_ID,
                    E.FIRST_NAME,
                    E.PHONE_NUMBER,
                    E.HIRE_DATE,
                    E.DEPARTMENT_ID,
                    D.DEPARTMENT_NAME
             FROM EMPLOYEES E
             LEFT JOIN DEPARTMENTS D
             ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
             ORDER BY HIRE_DATE) A
      )
WHERE RN >0 AND RN <= 10;

--���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���

SELECT A.*,
       D.DEPARTMENT_NAME
FROM(SELECT LAST_NAME,
            JOB_ID,
            DEPARTMENT_ID
       FROM EMPLOYEES
       WHERE JOB_ID = 'SA_MAN') A 
LEFT JOIN DEPARTMENTS D ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;

--������

SELECT LAST_NAME,
       JOB_ID,
       E.DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM(SELECT *
        FROM EMPLOYEES
        WHERE JOB_ID = 'SA_MAN')E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;



--���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�

SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID,
       COUNT(*)
FROM (SELECT A.*
        FROM EMPLOYEES E
        LEFT JOIN (SELECT DEPARTMENT_ID,
                          DEPARTMENT_NAME,
                          MANAGER_ID
                     FROM DEPARTMENTS D) A
        ON E.DEPARTMENT_ID = A.DEPARTMENT_ID) B
GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID
ORDER BY COUNT(*) DESC;

--TEACHER
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.�ο���
FROM DEPARTMENTS D
JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) AS �ο���
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID)E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY �ο��� DESC;


--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���

SELECT D.*, 
       A
FROM (SELECT D.*,
             L.STREET_ADDRESS,
             L.POSTAL_CODE
        FROM DEPARTMENTS D
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID)D
LEFT JOIN (SELECT DEPARTMENT_ID, 
                  AVG(SALARY) A
             FROM EMPLOYEES
             GROUP BY DEPARTMENT_ID)S
ON D.DEPARTMENT_ID = S.DEPARTMENT_ID 
ORDER BY D.DEPARTMENT_ID;

--TEACHER

SELECT D.*,
       NVL(E.SALARY,0) AS SALARY,
       L.STREET_ADDRESS,
       L.POSTAL_CODE
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                  TRUNC(AVG(SALARY)) AS SALARY
             FROM EMPLOYEES
             GROUP BY DEPARTMENT_ID)E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;




--���� 16
---���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

--TEACHER

SELECT *
FROM (SELECT ROWNUM RN,
             X.* 
        FROM(SELECT D.*,
                    NVL(E.SALARY,0) AS SALARY,
                    L.STREET_ADDRESS,
                    L.POSTAL_CODE
               FROM DEPARTMENTS D
               LEFT JOIN (SELECT DEPARTMENT_ID,
                                 TRUNC(AVG(SALARY)) AS SALARY
                            FROM EMPLOYEES
                            GROUP BY DEPARTMENT_ID)E
               ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
               LEFT JOIN LOCATIONS L
               ON D.LOCATION_ID = L.LOCATION_ID
               ORDER BY D.DEPARTMENT_ID DESC) X
      )
WHERE RN>10 AND RN<=20;



