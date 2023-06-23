/*
	DDL ( Data Definition Language)
    ==> 데이터베이스 관리시스템에 
		등록되는 개체를 조작(생성, 수정, 삭제)하는 명령
        
참고 ]
	테이블 설계
		관계형 데이터베이스는 
        정규화된 데이터를 기억하도록 하고 있다.
        
        정규화란?
        규칙이 정해지는 것을 의미하고
        따라서 데이터베이스는 어떤 데이터를 기억할지를
        미리 결정해놓고
        그 데이터에(그 규칙에 맞게 준비된 데이터)
        한해서만 기억하도록 한다.
        
        따라서 테이블을 생성할 때는 여러가지 규칙을 가지고(정규화 규칙)
        테이블에 입력될 데이터를 결정해야 한다.
        
	테이블 설계의 종류
		
        개념적 설계
        ==> 현실 세계에 대한 인식을 추상적 개념으로 표현
			
            결과물
				ER-Model, ERD
            
        논리적 설계
        ==> 데이터베이스 관리시스템이 지원하는 논리적 자료구조로 변환
        
        물리적 설계
        ==> 논리적 설계의 결과를 물리적 공간(하드디스크등의 저장장치)에
			저장할 수 있는 물리적 구조로 변환
		
	DDL 명령의 종류
		
        CREATE
        ==> 개체를 생성하는 명령
			데이터베이스 시스템에 등록되는 것들을 의미하고
            테이블, 유저, 데이터베이스, 뷰(VIEW), 함수,...
            를 생성하는 명령
        
        ALTER
        ==> CREATE 명령으로 생성된 개체를 수정하는 명령
        
        DROP
        ==> 생성된 개체를 삭제하는 명령
        
        TRUNCATE
        ==> 테이블의 데이터를 잘라서 버리는 명령
			
			형식 ]
				TRUNCATE 테이블이름;
        
        참고 ] *****
			DDL 소속명령은 실행되는 즉시 트랜젝션처리가 된다.
			
*/

select * from bonus;

DESC EMP;

DESC DEPT;

SELECT TRUNCATE(3.141592, 2) 자릿수버림,
	FLOOR(3.141592) 소수점이하버림,
    ROUND(3.141592, 3) 반올림;

--  TRUNCATE

-- 테이블들 리스트 조회하기
SHOW TABLES;

SELECT * FROM TMP3;

TRUNCATE tmp3;

rollback;

/*
	테이블 조작 DDL 명령
    
    1. 테이블 생성
		형식 ]
			
            CREATE TABLE 테이블이름(
				컬럼이름 타입(길이) [NOT NULL] [ AUTO_INCREMENT ],
                컬럼이름2 타입(길이) [DEFAULT 데이터 ] [NOT NULL],
                ...
                CONSTRAINT 제약조건이름 PRIMARY KEY(적용컬럼이름),
                CONSTRAINT 제약조건이름 FOREIGN KEY(적용컬럼이름) 
							REFERENCES 참조테이블이름(참조컬럼), 
                            ==> 참조키 제약 조건에 사용되는 참조해주는 컬럼은
								반드시 유일키거나 기본키 제약조건이 부여되어 있어야 한다.
				CONSTRAINT 제약조건이름 UNIQUE(적용컬럼이름),
                CONSTRAINT 제약조건이름 CHECK ( 적용컬럼 IN (데이터1, 데이터2, ...))
            );
            
            제약조건 이름 만드는 규칙
				
				[데이터베이스이름_]테이블이름_컬럼이름_제약조건
                
					참고 ]
						PK	- 기본키
                        UK	- 유일키
                        FK	- 참조키
                        CK	- 체크
				의 형식으로 작성한다.
                
	사용자 계정 만들기
		형식 ]
			
            CREATE USER '계정이름'@'localhost | ip주소 | %'
				IDENTIFIED 
					WITH '인증방식' 
                    BY '비밀번호'
				REQUIRE NONE
                PASSWORD EXPIRE INTERVAL 30 DAY
                ACCOUNT UNLOCK | LOCK
                PASSWORD HISTORY DEFAULT
                PASSWORD REUSE INTERVAL DEFAULT
                PASSWORD REQUIRE CURRENT DEFAULT
			;
            
            OPTION 설명 ]
				IDENTIFIED WITH '인증방식' ==> 'mysql_native_password'
                REQUIRE
					서버에 접속할 때 암호화된 인증방식 
                    SSL/TLS 방식 사용여부를 결정
                    기술하지 않으면 비암호화 채널 사용
				PASSWORD EXPIRE 
					비밀번호 유효기간
                    명시하지 않으면 default_password_lifetime 시스템 변수에
                    저장된 시간으로 지정
                    
                    예 ]
						PASSWORD EXPIRE
                        ==> 기본값으로 설정
                        PASSWORD EXPIRE NEVER
                        ==> 유효기간 없음
                        PASSWORD EXPIRE DEFAULT
                        ==> 기본값으로 설정
                        PASSWORD EXPIRE INTERVAL N DAY
                        ==> 유효기간을 N 일로 지정
                        
				PASSWORD HISTORY
					사용했던 비밀번호를 재사용 못하게 하는 옵션
                    
                    PASSWORD HISTORY DEFAULT
                    ==> password_history 시스템 변수에 지정된 갯수만큼 
						비밀번호 이력을 저장
                        
					PASSWORD HISTORY N
                    ==> N개까지 비밀번호 이력 저장
                    
				PASSWORD REUSE INTERVAL
                ==> 사용했던 비밀번호 재사용 금지 기간 설정 옵션
					명시하지 않으면 시스템변수에 기억된 기본 기간으로 설정
                    
                    PASSWORD REUSE INTERVAL DEFAULT
                    PASSWORD REUSE INTERVAL N DAY
                    
				PASSWORD REQUIRE
				==> 비밀번호가 만료되어 새로운 비밀번호로 변경할 때
					기존 비밀번호를 필요로 할지를 결정하는 옵션
                    
                    명시하지 않으면 시스템 변수값으로 자동 지정
                    
                    PASSWORD REQUIRE CURRENT	: 기존 비밀번호를 먼저 입력
                    PASSWORD REQUIRE OPTIONAL	: 입력하지 않아도 되는 옵션
                    PASSWORD REQUIRE DEFAULT	: 기본값으로 지정
                    
			ACCOUNT UNLOCK | LOCK
            ==> 계정을 생성 또는 수정할 때 사용 못하게 잠글지를 결정하는 옵션
				
                ACCOUNT UNLOCK	: 계정 잠금 해제
                ACCOUNT LOCK	: 계정 잠금
                
		참고 ] 
			계정 수정은 계정생성명령에서 
			CREATE  명령 대신  ALTER 로 변경해주면 된다.
                
*/

--------------------------------------------------------------------------------------
-- root 계정에서 작업
-- 모든 곳에서 접속할 수 있는 'jennie' 계정을 만드세요. 
-- 비밀번호는 'blackpink' 로 하세요.

CREATE USER 'jennie'@'%'
	IDENTIFIED WITH 'mysql_native_password' 
    BY 'blackpink'
    REQUIRE NONE
    PASSWORD EXPIRE NEVER
    ACCOUNT UNLOCK
;

-- 데이터베이스 만들기

--				데이터베이스이름		기본한글처리문자셋	
CREATE DATABASE zoro DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- 권한부여 : DCL 명령 - GRANT
GRANT ALL PRIVILEGES ON zoro.* TO jennie@'%';
-- ==> jennie 계정에게 zoro데이터베이스의 모든 권한을 부여한다.

--------------------------------------------------------------------------------------

-- jennie 계정에서 작업


-- 부서정보 테이블 생성
CREATE TABLE dept(
	deptno TINYINT UNSIGNED,
    dname VARCHAR(14) NOT NULL,
    loc VARCHAR(13) NOT NULL,
    CONSTRAINT DPT_DNO_PK PRIMARY KEY(deptno)
);

DESC dept;

-- 사원정보 테이블
CREATE TABLE emp(
	empno SMALLINT UNSIGNED AUTO_INCREMENT,
    ename VARCHAR(10) NOT NULL,
    job		VARCHAR(9) NOT NULL,
    mgr		SMALLINT UNSIGNED,
    hiredate DATE NOT NULL,
    sal		DECIMAL(7,2) NOT NULL,
    comm	DECIMAL(7, 2),
    deptno  TINYINT UNSIGNED,
    CONSTRAINT EMP_NO_PK PRIMARY KEY(empno),
    CONSTRAINT EMP_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno)
 --   , CONSTRAINT EMP_DNO_CK CHECK (deptno IN (10, 20, 30, 40))
);

DESC EMP;

-- 급여등급 테이블
DROP TABLE IF EXISTS SALGRADE;
CREATE TABLE salgrade(
	grade TINYINT UNSIGNED AUTO_INCREMENT,
    losal DECIMAL(7,2) NOT NULL,
    hisal DECIMAL(7,2) NOT NULL,
    CONSTRAINT SALGRD_GRADE_PK PRIMARY KEY(grade)
);

-- 데이터 추가
/*
1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
*/

INSERT INTO
	salgrade(losal, hisal)
VALUES(
	700,	1200
);

SELECT * FROM salgrade;

-- 여러 데이터 동시에 입력
INSERT INTO
	salgrade(losal, hisal)
VALUES
	(1201,	1400),
	(1401,	2000),
	(2001,	3000),
	(3001,	9999)
;

select * from salgrade;

commit;

-- 부서 정보를 입력하세요.
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

TRUNCATE DEPT;
-- orcl에 있는  dept 테이블의 내용으로 채워보자.
SELECT * FROM orcl.dept;

INSERT INTO dept
SELECT
	*
FROM
	orcl.dept
;

SELECT * FROM dept;

-- 사원정보를 입력하세요.
/*
7369	SMITH	CLERK		7902	1980-12-17	800.00				20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600.00		300.00	30
7521	WARD	SALESMAN	7698	1981-02-22	1250.00		500.00	30
7566	JONES	MANAGER		7839	1981-04-02	2975.00				20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250.00		1400.00	30
7698	BLAKE	MANAGER		7839	1981-05-01	2850.00				30
7782	CLARK	MANAGER		7839	1981-06-09	2450.00				10
7788	SCOTT	ANALYST		7566	1987-07-13	3000.00				20
7839	KING	PRESIDENT	NULL	1981-11-17	5000.00				10
7844	TURNER	SALESMAN	7698	1981-09-08	1500.00		0.00	30
7876	ADAMS	CLERK		7788	1987-07-13	1100.00				20
7900	JAMES	CLERK		7698	1981-12-03	950.00				30
7902	FORD	ANALYST		7566	1981-12-03	3000.00				20
7934	MILLER	CLERK		7782	1982-01-23	1300.00				10
*/

INSERT INTO emp
SELECT
	*
FROM
	orcl.emp
;

SELECT * FROM emp;

/*
	ALTER : 개체를 수정하는 명령
    
		테이블 수정
		
			테이블 이름수정
				형식 ]
					
                    ALTER TABLE 테이블이름
                    RENAME TO 새테이블이름;
                    
			컬럼 이름 수정
				형식 ]
					ALTER TABLE 테이블이름
                    RENAME COLUMN 컬럼이름 TO 새이름;
                    
			제약조건 추가하는 방법
				
                ALTER TABLE 테이블이름
                ADD CONSTRAINT 제약조건이름 제약조건(컬럼이름) 표현식;
                
                참고 ]
					NOT NULL 제약조건은 추가하는 개념이 아니고
                    이미 있는 속성을 변경하는 개념이다.
                    
                    ALTER TABLE 테이블이름
                    MODIFY 컬럼이름 타입(길이) NOT NULL;
                    
		컬럼 추가
			 ALTER TABLE 테이블이름
             ADD 컬럼이름 타입(크기) [ DEFAULT 데이터 ] [ NOT NULL ];
             
		컬럼 삭제
			ALTER TABLE 테이블이름
            DROP COLUMN 컬럼이름;
                    
*/

CREATE TABLE tmp1
AS
	SELECT
		*
    FROM
		emp
    WHERE
		1 = 2
;
SELECT * FROM TMP1;
DESC TMP1;

-- TMP1 ==> TMP
ALTER TABLE tmp1
RENAME TO tmp;

DESC TMP;

-- 테이블 리스트 확인
SHOW TABLES;

-- EMPNO --> ENO, DEPTNO --> DNO

ALTER TABLE tmp
RENAME COLUMN empno TO eno;

ALTER TABLE tmp
RENAME COLUMN deptno TO dno;

DESC tmp;

-- 기본키 제약조건 추가
ALTER TABLE tmp
ADD CONSTRAINT TMP_ENO_PK PRIMARY KEY(eno);

-- 참조키 제약조건 추가
ALTER TABLE tmp
ADD CONSTRAINT TMP_DNO_FK FOREIGN KEY(dno) REFERENCES dept(deptno);

-- 구조보기
DESC tmp;

-- TMP에 10 부서 사원들만 추가
INSERT INTO tmp
SELECT
	*
FROM
	emp
WHERE
	deptno = 10;

select * from tmp;

ALTER TABLE tmp
ADD grade TINYINT UNSIGNED NOT NULL;

select * from tmp;

ALTER TABLE tmp
DROP COLUMN grade;

select * from tmp;

ALTER TABLE tmp
ADD grade TINYINT UNSIGNED DEFAULT 9 NOT NULL;

SELECT * FROM tmp;

--------------------------------------------------------------------------------------
/*
	뷰(VIEW) - 조회 결과로는 테이블처럼 작동하지만
				물리적으로 테이블처럼 저장되어 있지 않은
                특정 질의명령의 결과를 보여주는 창 의 개념
                
		형식 ]
			CREATE VIEW 뷰이름
            AS
				조회질의명령
			;
            
            주의 ]
				뷰를 생성할 때 사용하는 서브질의에서 별칭을 주게되면
                별칭으로 뷰의 컬럼이름이 만들어진다.
                
		종류 ]
			단순뷰
            ==> 하나의 테이블에서 별도의 연산없이 만들어진 뷰 
				원칙적으로 수정이 가능하다.
                
            복합뷰
            ==> JOIN, GROUP BY, 연산을 통해서 만들어진 뷰
				원칙적으로 데이터 수정이 불가능하다.
            
*/
drop table if exists tmp2;
CREATE TABLE TMP2
AS
	SELECT
		empno eno, ename name, sal, comm, hiredate hdate, deptno dno
    FROM
		emp
;

SELECT * FROM tmp2;

-- tmp2 사원들의 정보 사원번호, 사원이름, 급여를 조회하는 뷰(TVIEW1)을 만드세요.
CREATE VIEW tview1
AS
	SELECT
		eno, name, sal 
    FROM
		tmp2
;

select * from tview1;
-- 급여를 100 인상하세요.
UPDATE
	tview1
SET
	sal = sal + 100
;

SELECT * FROM tview1;

SELECT * FROM tmp2;

-- 2. tmp2 사원들의 정보 사원번호, 사원이름, 연봉을 조회하는 뷰(TVIEW2)을 만드세요.
CREATE OR REPLACE VIEW tview2
AS
	SELECT
		eno, name, sal * 12 + IFNULL(comm, 0) ysal
    FROM
		tmp2
;

select * from tview2;

-- SMITH 사원의 연봉은 3000으로 수정하세요.
UPDATE
	tview2
SET
	ysal = 3000
WHERE
	name = 'SMITH'
;

-- 사원들의 집계데이터를 조회하는 empagg 뷰를 만드세요.
CREATE OR REPLACE VIEW empagg
AS
	SELECT
		dno, COUNT(*) cnt, SUM(sal) sum, AVG(sal) avg, MAX(sal) max, MIN(sal) min
    FROM
		tmp2
    GROUP BY
		dno
;

-- 사원들중 소속부서 평균급여보다 급여가 많은 사원들의 정보를 조회하세요.
SELECT
	empno, ename, sal, avg, cnt, dno
FROM
	emp, empagg
WHERE
	deptno = dno -- 조인조건
    AND sal > avg
;