--Ʈ�����(���� �۾�����)

SHOW AUTOCOMMIT;
--����Ŀ�� ��
SET AUTOCOMMIT ON;
--����Ŀ�� ����
SET AUTOCOMMIT OFF;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DELETE10; --���̺�����Ʈ ���
DELETE FROM DEPTS WHERE DEPARTMENT_ID =20;
SAVEPOINT DELETE20;--���̺�����Ʈ Ű��
ROLLBACK TO DELETE10;
SELECT * FROM DEPTS;
ROLLBACK; --������ Ŀ�� ����

-------------------------------------------
INSERT INTO DEPTS VALUES(300, 'DEMO', NULL, 1800);

COMMIT; --Ʈ����� �ݿ�(���� ������ ���α׷� ������ �����Ͱ� ������ ����)
        --Ŀ�� ������ �����Ͱ� ����� ����� ���� �ƴ�
SELECT *FROM DEPTS;





