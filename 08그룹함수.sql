--�׷��Լ� : �����࿡ ���Ͽ� �������
--AVG, SUM, MIN, MAX, COUNT
SELECT AVG(SALARY), SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE) FROM EMPLOYEES;
SELECT MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;


--COUNT(�÷�) : NULL���� �ƴ� �����Ͱ���
--COUNT(*) : ��ü ���� ����
SELECT COUNT(FIRST_NAME) FROM EMPLOYEES;
SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES;
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;
SELECT COUNT(*) FROM EMPLOYEES;


-------------������ ��---------------------
--�׷��Լ� : �׷��Լ��� �Ϲ��÷��� ���ÿ� ����� �� �����ϴ�.(����Ŭ��)
SELECT FIRST_NAME, SUM(SALARY) FROM EMPLOYEES;--ERR

-------------------------------------------------------------------------------
SELECT DEPARTMENT_ID, AVG(SALARY), SUM(SALARY), COUNT(*) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
--������ ��(�׷����� ����� �÷���, SELECT���� ����մϴ�.)
SELECT DEPARTMENT_ID, FRIST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;--ERR
--
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

--�׷��Լ��� WHERE���� ������ �� �����ϴ�.
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) >= 10000 
GROUP BY JOB_ID; --ERR
--------------------------------------------------------------------------------
--�׷��� ������ HAVING��
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) >= 10000;

SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 30;

SELECT JOB_ID, SUM(SALARY), SUM( NVL(COMMISSION_PCT, 0) )
FROM EMPLOYEES
WHERE JOB_ID NOT IN ('IT_PROG')
GROUP BY JOB_ID
HAVING SUM(SALARY) >= 20000
ORDER BY SUM(SALARY) DESC;
--�μ����̵� 50�� �̻��� �μ��� �׷�ȭ ��Ű�� �׷���ձ޿� 5000�̻� ���
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID >= 50
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000
ORDER BY DEPARTMENT_ID;
--------------------------------------------------------------------------------
--ROLLUP - �� �׷��� �Ѱ踦 �Ʒ��� ���
SELECT DEPARTMENT_ID, TRUNC(SUM(SALARY))
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID);

SELECT DEPARTMENT_ID, JOB_ID, TRUNC(SUM(SALARY))
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);

--CUBE - ����׷쿡 ���� �÷����
SELECT DEPARTMENT_ID, JOB_ID, TRUNC(SUM(SALARY))
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--GROUPING() - �׷����� �����Ǹ� 0��ȯ, �Ѿ�ORť��� ��������� 1��ȯ
SELECT DEPARTMENT_ID, 
       JOB_ID, 
       DECODE( GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID ),
       GROUPING(DEPARTMENT_ID),
       GROUPING(JOB_ID),
       SUM(SALARY), 
       COUNT(*)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;
--------------------------------------------------------------------------------
--��������
--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���
SELECT JOB_ID, 
       COUNT(*) AS �����,
       AVG(SALARY) AS �޿����
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY �޿���� DESC;
--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT SUBSTR(HIRE_DATE,1,2) AS �Ի�⵵, 
       COUNT(*) AS �����
FROM EMPLOYEES
GROUP BY SUBSTR(HIRE_DATE,1,2)
ORDER BY �Ի�⵵;

SELECT TO_CHAR(HIRE_DATE, 'YY'),
       COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');

--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT DEPARTMENT_ID, 
       TRUNC( AVG(SALARY) )
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING TRUNC( AVG(SALARY) ) >= 2000;

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT DEPARTMENT_ID, 
       TRUNC( AVG(SALARY + SALARY * COMMISSION_PCT), 2) AS �޿����, 
       SUM(SALARY + SALARY * COMMISSION_PCT) AS �޿��հ�, 
       COUNT(*) AS �����
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;

--���� 5.
--������ ������, ���հ踦 ����ϼ���
SELECT DECODE( GROUPING(JOB_ID), 1, '�հ�', JOB_ID ) AS JOB_ID,
       SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID)
ORDER BY JOB_ID;

--���� 6.
--�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���
SELECT DECODE( GROUPING(DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID) AS DEPARTMENT_ID, 
       DECODE( GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID ) AS JOB_ID,
       COUNT(*) AS TOTAL, 
       SUM(SALARY) AS SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;



