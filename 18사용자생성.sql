--1. USER����
CREATE USER USER01 IDENTIFIED BY USER01; --���̵� USER01, ��й�ȣ USER01

--2. USER���Ѻο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO USER01;
--REVOKE CREATE SESSION FROM USER01; - ���ӱ��� ����

--3. �����Ͱ� ����Ǵ� �������� ����(���̺����̽� ����)
--ALTER USER ������ DEFAULT TABLESPACE ���̺����̽��� QUOTA UNLIMITED ON ���̺����̽���
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--4. ���� ���� (���̺� ���� -> ������ ���� -> ~~~����)
DROP USER USER01 CASCADE;
--------------------------------------------------------------------------------
--ROLE�� �̿��� ��������
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT/*, DBA*/ TO USER01;

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--��й�ȣ ���湮
ALTER USER USER01 IDENTIFIED BY 1234;

--------------------------------------------------------------------------------
--���콺�� �����ϱ�
--1. ���̺����̽� ���� > ���� > DBA > ȭ����ʾƷ� DBA ������ > ���� ���� > ���̺����̽� > ���콺 ��Ŭ��
--1.DBA���� ������ > �ٸ� ����� > ����� ����
