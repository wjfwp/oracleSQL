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
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
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


--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT EMPLOYEE_ID AS �������̵�, 
       CONCAT(FIRST_NAME,' ' || LAST_NAME) AS �̸�,
       E.DEPARTMENT_ID AS �μ����̵�,
       DEPARTMENT_NAME AS �μ���
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT EMPLOYEE_ID AS �������̵�,
       CONCAT(FIRST_NAME, ' ' || LAST_NAME) AS �̸�,
       DEPARTMENT_ID AS �μ����̵�,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����

SELECT DEPARTMENT_ID AS �μ����̵�,
       DEPARTMENT_NAME AS �μ��̸�,
       MANAGER_ID AS �Ŵ������̵�,
       D.LOCATION_ID AS �����̼Ǿ��̵�,
       STREET_ADDRESS AS ��Ʈ��_��巹��,
       POSTAL_CODE AS ����Ʈ�ڵ�,
       CITY AS ��Ƽ
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
SELECT LOCATION_ID AS �����̼Ǿ��̵�,
       STREET_ADDRESS AS �ּ�,
       CITY,
       C.COUNTRY_ID,
       COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT LOCATION_ID,
       STREET_ADDRESS,
       CITY,
       COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID )
FROM LOCATIONS L;
ORDER BY COUNTRY_NAME;