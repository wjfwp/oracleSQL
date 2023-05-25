--������ (���������� �����ϴ� ��) - PK�� ���� ����
SELECT * FROM USER_SEQUENCES;

--����� ������ ����
CREATE SEQUENCE DEPTS_SEQ 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10
    MINVALUE 1
    NOCYCLE
    NOCACHE;
    
--������ ���� (��, ���ǰ� �ִ� ��������� ����)
DROP SEQUENCE DEPTS_SEQ;

DROP TABLE DEPTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1=2);
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID); --PK

SELECT * FROM DEPTS;

--������ ���
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --�������� ������ (����)
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --�������� ���簪
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'TEST', 100, 1000); -- X10 (�������� �ִ밪�� �����ϸ� �� �̻� ����� �� ����)

--������ ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--������ ���� ����(�⺻�ɼ����� ����)
CREATE SEQUENCE DEPTS2_SEQ NOCACHE;
SELECT * FROM USER_SEQUENCES;

--������ �ʱ�ȭ(�������� ���̺��� ���ǰ� �ִ� ����, �������� DROP�ϸ� �ȵ˴ϴ�.)
--1.���� ������ Ȯ��
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--2.�������� ������ ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -39; --��������� 1�� ����
--3.������ ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--4.������ �������� �ٽ� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--���ĺ��� �������� 2���� ����....

--������ VS �⺰�� ������ VS ������ ���ڿ�
--20230523-00001-��ǰ��ȣ ������
CREATE TABLE DEPTS3 (
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

CREATE SEQUENCE DEPTS3_SEQ NOCACHE;
--TO_CHAR(SYSDATE, 'YYYYMMDD), LPAD(������, �ڸ���, 'ä�ﰪ')
SELECT TO_CHAR(SYSDATE,'YYYYMMDD') || '-' || LPAD(DEPTS3_SEQ.NEXTVAL, 5, 0) || '-' || '��ǰ��ȣ' FROM DUAL;

INSERT INTO DEPTS3 
VALUES( TO_CHAR(SYSDATE,'YYYYMMDD') || '-' || LPAD(DEPTS3_SEQ.NEXTVAL, 5, 0) || '-' || '��ǰ��ȣ' , 
                            'TEST');

SELECT * FROM DEPTS3;
--------------------------------------------------------------------------------
--INDEX
--�ε����� PK, UK���� �ڵ������Ǵ� UNIQUE�ε����� �ֽ��ϴ�.
--�ε����� ������ ��ȸ�� ������ ���ִ� HINT������ �մϴ�.
--���� ������� �ʴ� �Ϲ��÷��� �ε����� ������ �� �ֽ��ϴ�.

CREATE TABLE EMPS_IT AS ( SELECT * FROM EMPLOYEES WHERE 1=1);
--�ε����� ���� �� ��ȸ VS �ε��� ������ ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; 

--�ε��� ���� (�ε����� ��ȸ�� ������ �ϱ� ������, ������ �ϰ� ���� �����ϸ�, ������ ������ ������ �� �ֽ��ϴ�.)
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME);
CREATE UNIQUE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME);--����ũ�ε���(�÷����� ����ũ�ؾ� �մϴ�.)
--�ε��� ����
DROP INDEX EMPS_IT_IDX;
--�ε����� (�����ε���) �����÷��� ������ �� �ֽ��ϴ�.
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; --�ε��� �����
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen'; --�ε��� �����

--FRIST_NAME �������� ����
--�ε����� �������� ��Ʈ�� �ִ� ���
SELECT *
FROM (SELECT /*+ INDEX_DESC (E EMPS_IT_IDX)*/
           ROWNUM RN,
           E.*
    FROM EMPS_IT E
    ORDER BY FIRST_NAME DESC)
WHERE RN > 10 AND RN <= 20;



