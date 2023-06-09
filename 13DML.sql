--INSERT, UPDATE, DELETE 문을 작성하면 COMMIT명령으로 실제 반영을 처리하는 작업이 필요합니다.
--INSERT

--테이블 구조 확인
DESC DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES(300, 'DEV', NULL, 1700); --전체행을 넣는 경우
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(310, 'SYSTEM'); --선택적으로 넣는 경우

SELECT * FROM DEPARTMENTS;

ROLLBACK;

--사본테이블(테이블 구조만 복사)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2);
--서브쿼리절 인서트
INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'); --전체컬럼을 맞춤
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES(200, 
       (SELECT LAST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
       (SELECT EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
       SYSDATE,
       'TEST'
       );

SELECT * FROM EMPS;
DESC EMPS;

--------------------------------------------------------------------------------
--UPDATE문장
SELECT * FROM EMPS;
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 103;
--EX1
UPDATE EMPS 
SET HIRE_DATE = SYSDATE, 
    LAST_NAME = 'HONG',
    SALARY = SALARY + 1000
WHERE EMPLOYEE_ID = 103;
--EX2
UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID IN ('IT_PROG', 'SA_NAME');

--EX3 : ID- 200의 급여를 103번과 동일하게 변경(서버쿼리)
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;
--EX4 : 3개의 컬럼을 한번에 변경
UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT) = (SELECT JOB_ID, SALARY, COMMISSION_PCT FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

SELECT * FROM EMPS;

COMMIT;
--------------------------------------------------------------------------------
--DELETE구문
CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1 = 1); --테이블 복사 + 데이터 복사
SELECT * FROM DEPTS;
SELECT * FROM EMPS;
--EX1 -  삭제할 때는 꼭 PK를 이용합니다.
DELETE FROM EMPS WHERE EMPLOYEE_ID = 200;
DELETE FROM EMPS WHERE SALARY >= 4000;

--EX2 -
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT';
DELETE FROM EMPS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');
ROLLBACK;
--
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
--EMPLOYEE가 60번 부서를 사용하고 있기 때문에 삭제불가
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 60;
--------------------------------------------------------------------------------
--MERGE문
--두 테이블을 비교해서 데이터가 있으면 UPDATE, 없다면 INSERT
SELECT * FROM EMPS;

MERGE INTO EMPS E1
USING(SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN')) E2
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID)
WHEN MATCHED THEN
     UPDATE SET E1.HIRE_DATE = E2.HIRE_DATE,
                E1.SALARY = E2.SALARY,
                E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN
    INSERT VALUES(E2.EMPLOYEE_ID,
                  E2.FIRST_NAME,
                  E2.LAST_NAME,
                  E2.EMAIL,
                  E2.PHONE_NUMBER,
                  E2.HIRE_DATE,
                  E2.JOB_ID,
                  E2.SALARY,
                  E2.COMMISSION_PCT,
                  E2.MANAGER_ID,
                  E2.DEPARTMENT_ID); 

--MERGE2
SELECT * FROM EMPS;

MERGE INTO EMPS E
USING DUAL
ON (E.EMPLOYEE_ID = 103)
WHEN MATCHED THEN
    UPDATE SET LAST_NAME = 'DEMO'
WHEN NOT MATCHED THEN
    INSERT(EMPLOYEE_ID,
           LAST_NAME,
           EMAIL,
           HIRE_DATE,
           JOB_ID) VALUES(1000, 'DEMO', 'DEMO', SYSDATE, 'DEMO');
    
--
DELETE FROM EMPS WHERE EMPLOYEE_ID = 103;
SELECT * FROM EMPS;

DESC EMPS;

--------------------------------------------------------------------------------
--문제 1.
--DEPTS테이블의 다음을 추가하세요
--DEPARTMENT_ID     DEPARTMENT_NAME     MANAGER_ID     LOCATION_ID
--   280                 개발               null           1800
--   290                회계부              null           1800
--   300                 재정                301           1800
--   310                 인사                302           1800
--   320                 영업                303           1700

SELECT * FROM DEPTS;
INSERT INTO DEPTS VALUES(280, '개발', NULL, 1800);
INSERT INTO DEPTS VALUES(290, '회계부', NULL, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES(300, '재정', 301, 1800);
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES(310, '인사', 302, 1800); 
INSERT INTO DEPTS VALUES(320, '영업', 303, 1700);           

COMMIT;

--문제 2.
--DEPTS테이블의 데이터를 수정합니다
SELECT * FROM DEPTS;
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Bank'
WHERE DEPARTMENT_NAME = 'IT Support';
--2. department_id가 290인 데이터의 manager_id를 301로 변경
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;
--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
--1800으로 변경하세요
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';
--4. 재정, 인사, 영업 의 매니저아이디를 301로 한번에 변경하세요.
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_NAME IN ('재정','인사','영업');

COMMIT;

--문제 3.
SELECT * FROM DEPTS;
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = '영업');
--DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;
--2. 부서명 NOC를 삭제하세요
SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC'; --220
DELETE FROM DEPTS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');
--DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220;

COMMIT;

--문제4
SELECT * FROM DEPTS;
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
--새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
SELECT * FROM DEPARTMENTS;
MERGE INTO DEPTS D1
    USING DEPARTMENTS D2
    ON(D1.DEPARTMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET D1.DEPARTMENT_NAME =D2.DEPARTMENT_NAME,
               D1.MANAGER_ID = D2.MANAGER_ID,
               D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES(D2.DEPARTMENT_ID,
                  D2.DEPARTMENT_NAME,
                  D2.MANAGER_ID,
                  D2.LOCATION_ID);
                   


--문제 5
SELECT * FROM JOBS_IT;
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000 AND 1 = 1); 
--2. jobs_it 테이블에 다음 데이터를 추가하세요
--JOB_ID   JOB_TITLE     MIN_SALARY   MAX_SALARY
--IT_DEV   아이티개발팀       6000        20000
--NET_DEV  네트워크개발팀      5000        20000
--SEC_DEV  보안개발팀         6000        19000
INSERT INTO JOBS_IT VALUES('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
             VALUES('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO JOBS_IT(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
             VALUES('SEC_DEV', '보안개발팀', 6000, 19000);

--3. jobs_it은 타겟 테이블 입니다
--4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 
--새로 유입된 데이터는 그대로 추가해주는 merge문을 작성하세요
SELECT * FROM JOBS;
SELECT * FROM JOBS_IT;

MERGE INTO JOBS_IT J1
    USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J2
    ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET J1.MIN_SALARY = J2.MIN_SALARY,
               J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES(J2.JOB_ID,
                  J2.JOB_TITLE,
                  J2.MIN_SALARY,
                  J2.MAX_SALARY);
                  