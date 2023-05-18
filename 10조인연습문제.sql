--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
---EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT * FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;--106
SELECT * FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --107
SELECT * FROM EMPLOYEES E RIGHT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; --122
SELECT * FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;--123


--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT FIRST_NAME || ' ' || LAST_NAME AS �̸�,
       E.DEPARTMENT_ID
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE EMPLOYEE_ID = 200;


--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT * FROM JOBS; 
SELECT FIRST_NAME AS �̸�,
       E.JOB_ID �������̵�,
       JOB_TITLE ����Ÿ��Ʋ
FROM EMPLOYEES E INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID
ORDER BY �̸�;


--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT * FROM JOBS;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS J LEFT OUTER JOIN JOB_HISTORY H ON J.JOB_ID = H.JOB_ID;

--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT * FROM DEPARTMENTS;
SELECT FIRST_NAME,
       DEPARTMENT_NAME
FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE FIRST_NAME || ' ' || LAST_NAME = 'Steven King';
--WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';


--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT * FROM EMPLOYEES CROSS JOIN DEPARTMENTS;

--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME AS �̸�,
       SALARY AS �޿�,
       DEPARTMENT_NAME AS �μ���,
       CITY AS �ٹ���
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';

--���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT *
FROM EMPLOYEES E RIGHT OUTER JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE JOB_TITLE IN ('Stock Manager', 'Stock Clerk' );

SELECT *
FROM EMPLOYEES E LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE JOB_TITLE IN ('Stock Manager', 'Stock Clerk' );


--���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE FIRST_NAME IS NULL;

--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT E1.EMPLOYEE_ID,
       E1.FIRST_NAME AS ����̸�,
       E2.FIRST_NAME AS �Ŵ����̸�
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
ORDER BY E1.EMPLOYEE_ID;


--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT E1.FIRST_NAME AS �����,
       E1.SALARY AS D,
       E2.EMPLOYEE_ID AS D,
       E2.FIRST_NAME,
       E2.SALARY
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
WHERE E1.MANAGER_ID IS NOT NULL
ORDER BY E1.SALARY DESC;



