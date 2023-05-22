/*
VIEW�� �������� �ڷḦ ���� ���� ����ϴ� �������̺� �Դϴ�.
VIEW�� �̿��ؼ� �ʿ��� �÷��� �����صθ�, ������ ������ ���ϴ�.
VIEW�� ���ؼ� �����Ϳ� �����ϸ�, ���� �����ϰ� �����͸� ������ �� �ֽ��ϴ�.
*/
SELECT * FROM EMP_DETAILS_VIEW;

--�並 �����ҷ��� ������ �ʿ��մϴ�.
SELECT * FROM USER_SYS_PRIVS;

--CREATE OR REPLACE VIEW
--���� ����
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       JOB_ID,
       SALARY
FROM EMPLOYEES
);

SELECT * FROM EMPS_VIEW;
--���� ������ OR REPLACE���� ������ �˴ϴ�.
CREATE OR REPLACE VIEW EMPS_VIEW
AS(
SELECT EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       JOB_ID,
       SALARY,
       COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
);
--���պ�
--JOIN�� �̿��ؼ� �ʿ��� �����͸� ��� ������
CREATE OR REPLACE VIEW EMPS_VIEW
AS(
SELECT E.EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
);
SELECT * FROM EMPS_VIEW;
SELECT * FROM EMPS_VIEW WHERE NAME LIKE '%Nancy%';

--���� ����
--DROP VIEW
DROP VIEW EMPS_VIEW;

--------------------------------------------------------------------------------
/*
VIEW�� ���� DML�� �����ϱ� ������, ��� ��������� �ֽ��ϴ�.
1. �����̸� �ȵ˴ϴ�.
2. JOIN�� �̿��� ���̺��� ��쿡�� �ȵ˴ϴ�.
3. �������̺� NOT NULL������ �ִٸ� �ȵ˴ϴ�.
*/

CREATE OR REPLACE VIEW EMPS_VIEW
AS(
SELECT E.EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
);

SELECT * FROM EMPS_VIEW;
--1. �����̸� �ȵ˴ϴ�.(NAME�� ����)
INSERT INTO EMPS_VIEW(EMPLOYEE_ID, NAME, DEPARTMENT_NAME, JOB_TITLE)
VALUES(1000, 'DEMO HONG', 'DEMO IT', 'DEMO IT PROG');
--2. JOIN�� �̿��� ���̺��� ��쿡�� �ȵ˴ϴ�.
INSERT INTO EMPS_VIEW (DEPARTMENT_NAME) VALUES('DEMO');
--3. �������̺� NOT NULL������ �ִٸ� �ȵ˴ϴ�.
INSERT INTO EMPS_VIEW(EMPLOYEE_ID, JOB_TITLE) VALUES(300, 'TEST');
DESC EMPS_VIEW;

--���� �������� READ ONLY
--DML������ �並 ���ؼ��� �� �� ����
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM EMPLOYEES
) WITH READ ONLY;
