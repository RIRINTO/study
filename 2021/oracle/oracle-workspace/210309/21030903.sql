2021-03-09-03)
동의어 ( SYNONYM ) 객체
	- 오라클에서 사용되는 객체에 부여되는 별도의 이름
	- 컬럼 별칭과 테이블 별칭과의 차이점은 동의어는 쿼리에 독립적
	- 긴 문자열로 구성된 테이블명 등을 대치할 문자열 선언
	
	예)
		다른 소유자 테이블 접근 시 '스키마명.객체명'으로 접근해야 함
			이 경우, '스키마명.객체명'을 축약단어로 선언하여 사용
	
	ex) DUAL 테이블은 SYS계정 소유의 테이블이기 때문에
		DUAL 테이블 사용의 FULL NAME은 SYS.DUAL이다.
			SELECT SYSDATE FROM SYS.DUAL;

	사용 형식
		CREATE OR REPLACE[ PUBLIC] SYNONYM 동의어이름
			FOR 객체명;

	. 'PUBLIC'
		공개적 동의어 생성

	사용 예)
		CREATE OR REPLACE SYNONYM DT
			FOR DEPARTMENTS;
		CREATE OR REPLACE SYNONYM EP
			FOR EMPLOYEES;
		
		SELECT A.EMP_NAME AS 사원명,
				A.SALARY AS 급여,
				B.DEPARTMENT_NAME AS 부서명
			FROM EP A, DT B
			WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
				AND A.SALARY >= 15000;

		SELECT *
			FROM DT
			WHERE PARENT_ID IS NULL;

		CREATE OR REPLACE SYNONYM MD
			FOR SYS.DUAL;









