-- 부서별 부서번호, 평균급여, 최대급여 를 조회하세요.
-- 단, 부서평균급여가 회사평균급여보다 낮은 부서는 제외하세요.
SELECT
	deptno 부서번호, AVG(sal) 평균급여, MAX(sal) 최대급여,
    (
		SELECT
			AVG(sal)
        FROM
			emp
    )  회사평균급여
FROM
	emp e,
    (SELECT AVG(sal) tav FROM emp) t
GROUP BY
	deptno, tav
HAVING
	AVG(sal) >= tav
;

SELECT
	deptno 사원번호, job 직급
FROM
	emp
WHERE
	deptno = 30
;

SELECT
	deptno 사원번호, COUNT(*) 사원수
FROM
	emp
GROUP BY
	deptno
;

SELECT
	deptno 부서번호, job 직급, COUNT(*) 사원수, 1
FROM
	emp
GROUP BY
	deptno, job, 1
;


SELECT
	*
FROM
	emp e,
    (SELECT AVG(sal) tav FROM emp) t
;


SELECT
	*
FROM
	emp, dept
;

SELECT
	*
FROM
-- self join, inner join
	emp e, -- 사원 정보 테이블
    emp s -- 상사 정보 테이블
WHERE
	e.mgr = s.empno -- 조인조건
;

/*
	JOIN
		테이블들에서 데이터를 조회할 때
        조회되는 대상은 Cartesian Product 라고 부르고
        이것들중 정확한 데이터만 조회하는 방법을 
        Join 이라고 부른다.
        
        종류 ]
			INNER JOIN
            - Cartesian Product 내에서 원하는 데이터를 조회하는 방법
            
            OUTER JOIN
            - Cartesian Product 내에 없는 데이터를 조회하는 방법
            
            SELF JOIN
            - 조인을 하는데 하나의 테이블을 이용해서 조인하는 경우
            
            EQUI JOIN
            - 조인을 할 때 동등비교연산자(=) 를 이용해서 조인하는 경우
            
            NON EQUI JOIN
            - 조인을 할 때 동등비교연산자 외의 방법으로 조인하는 경우
            
	* ANSI JOIN
		- 미국국립표준협회(ANSI) 에서 만든 형식으로
			모든 데이터베이스에서 사용가능한 조인 문법
            
		INNER JOIN
        - 
			 형식 ]
				SELECT
                
                FROM
					테이블1
				[ INNER ]JOIN
					테이블2
				ON
					조인조건1
				[ INNER ]JOIN
					테이블3
				ON
					조인조건2
				WHERE
					 일반조건
				GROUP BY
					컬럼이름
				HAVING
					조건절
				ORDER BY
					컬럼이름 DESC | ASC
				LIMIT 
					[ 행인덱스, ] 갯수
				;
        
        OUTER JOIN
        - 형식 ]
			SELECT
				컬럼리스트...
            FROM	
				테이블1
            LEFT | RIGHT | FULL OUTER JOIN
				테이블2
                
        NATURAL JOIN
        -- 조인하는 테이블들에 동일한 이름의 컬럼이 하나가 존재하고
			조인조건으로 이 컬럼을 사용해야 하는 경우
            조인 조건을 기술하지 않고 조인하는 방법
            같은 이름의 컬럼이 여러개 존재하면 사용 못한다.
            
            형식 ]
				SELECT
					컬럼들...
                FROM
					테이블이름1
                NATURAL JOIN
					테이블이름2
                ;
            
        USING JOIN
		- 반드시 조인 조건식에 사용하는 컬럼이름이 동일한 경우
			이 때 같은 이름의 컬럼이 2개 이상인 경우
            사용하는 조인 방법
            같은 이름의 컬럼이 여러개 존재해도 사용할 수 있다.
            
            형식 ]
				SELECT
					컬럼들...
                FROM
					테이블1
                JOIN
					테이블2
                USING (컬럼이름)
                ;
*/

-- OUTER JOIN
-- 사원들의 사원번호, 사원이름, 상사번호, 상사이름, 상사직급, 부서번호를 조회하세요.
SELECT
	e.empno 사원번호, e.ename 사원이름, e.mgr 상사번호, 
    s.ename 상사이름, s.job 상사직급, e.deptno 부서번호
FROM
	-- 사원정보테이블
	emp e LEFT OUTER JOIN emp s -- 상사정보테이블
ON
	e.mgr = s.empno
;

SELECT
	*
FROM
	emp e
LEFT OUTER JOIN
	emp s
ON 
	e.mgr = s.empno
;

-- 사원들의 사원번호, 사원이름, 직급, 부서번호, 부서이름 을 조회하세요.
SELECT
	empno 사원번호, ename 사원이름, job 직급, e.deptno 부서번호, dname 부서이름
FROM
	emp e, dept d
WHERE
	e.deptno = d.deptno
;

-- ANSI JOIN
SELECT
	empno 사원번호, ename 사원이름, job 직급, e.deptno 부서번호, dname 부서이름
FROM
	emp e
INNER JOIN
    dept d
ON
	e.deptno = d.deptno
;

-- NATURAL JOIN
SELECT
	empno 사원번호, ename 사원이름, job 직급, deptno 부서번호, dname 부서이름
FROM
	emp e
NATURAL JOIN
    dept d
;


-- 사원들의 사원이름, 직급, 급여, 부서번호, 부서이름, 부서위치, 급여등급을 조회하세요.
SELECT
	ename 사원이름, job 직급, sal 급여, 
    deptno 부서번호, dname 부서이름, loc 부서위치, grade 급여등급
FROM
	emp
JOIN
	salgrade
ON
	sal BETWEEN losal AND hisal
JOIN
	dept
USING (deptno)
;

-- SALGRADE
SELECT * FROM emp, salgrade;


-- 사원들의 사원이름, 직급, 급여, 상사이름, 
-- 부서번호, 부서이름, 부서위치, 급여등급을 조회하세요.
-- 상사가 없는 경우는 "상사없음" 으로 조회되게 하세요.
SELECT
	e.ename 사원이름, e.job 직급, e.sal 급여, IFNULL(s.ename, '상사없음') 상사이름, 
	e.deptno 부서번호, dname 부서이름, loc 부서위치, 
    grade 급여등급
FROM
	emp e
JOIN
	salgrade
ON
	sal BETWEEN losal AND hisal
-- NATURAL JOIN
JOIN
	dept
USING (deptno)
LEFT OUTER JOIN
	emp s
ON
	e.mgr = s.empno
;


SELECT
	empno 사원번호, ename 사원이름, job 직급, DATE_FORMAT(hiredate, '%Y') 입사년도,
    deptno 부서번호, sal 급여, grade 급여등급
FROM
	emp, salgrade
WHERE
	sal BETWEEN losal  AND hisal
;

SELECT
	empno 사원번호, ename 사원이름, job 직급, DATE_FORMAT(hiredate, '%Y') 입사년도,
    e.deptno 부서번호, dname 부서이름, sal 급여, grade 급여등급
FROM
	emp e, salgrade, dept d
WHERE
	sal BETWEEN losal  AND hisal
    AND e.deptno = d.deptno
;


------------------------------------------------------------------------------------
-- 사원들의 사원번호, 직급, 부서번호, 부서이름, 부서평균급여 를 조회하세요.
SELECT
	empno 사원번호, job 직급, e.deptno 부서번호, dname 부서이름, 
    (
		SELECT
			AVG(sal)
        FROM
			emp
        WHERE
			deptno = e.deptno
    ) 부서평균급여
FROM
	emp e, dept d
WHERE
	e.deptno = d.deptno
;

SELECT
	empno 사원번호, job 직급, e.deptno 부서번호, dname 부서이름, 
    AVG(sal) OVER(PARTITION BY e.deptno) 부서평균급여
FROM
	emp e, dept d
WHERE
	e.deptno = d.deptno
;

SELECT 
	deptno dno, COUNT(*) cnt, SUM(sal) sum, AVG(sal) avg, MAX(sal) max, MIN(sal) min
FROM
	emp
GROUP BY
	deptno
;

-- 서브질의의 결과도 테이블처럼 사용되어질 수 있고
-- 조인할 수 있다.

-- 사원들의 사원번호, 사원이름, 직급, 급여, 부서번호, 부서평균급여, 부서원수 를 조회하세요.
SELECT
	empno 사원번호, ename 사원이름, job 직급, sal 급여, 
    deptno 부서번호, TRUNCATE(avg, 2) 부서평균급여, cnt 부서원수
FROM
	emp,
    (
		SELECT 
			deptno dno, COUNT(*) cnt, SUM(sal) sum, AVG(sal) avg, MAX(sal) max, MIN(sal) min
		FROM
			emp
		GROUP BY
			deptno
    ) a
WHERE
	deptno = dno
;

-- CTE
-- 질의명령내에서 한번 실행하고 삭제하는 가상의 테이블을 만들 수 있는데 이 테이블을
-- CTE(Common Table Expression) 라고 부른다.

/*
	형식 ]
		WITH 이름 AS (
			질의명령
        )
        SELECT
        ....
        ;
*/

WITH tmp AS (
	SELECT 
		deptno dno, COUNT(*) cnt, SUM(sal) sum, AVG(sal) avg, MAX(sal) max, MIN(sal) min
	FROM
		emp
	GROUP BY
		deptno
)
SELECT
	empno 사원번호, ename 사원이름, job 직급, sal 급여, 
    deptno 부서번호, TRUNCATE(avg, 2) 부서평균급여, cnt 부서원수
FROM
	emp, tmp
WHERE
	deptno = dno
;

----------------------------------------------------------------------------------------------
select * from emp, dept;


select
	*
from
	emp e
join
	dept d
on
	e.deptno = d.deptno
;

----------------------------------------------------------------------------------------------
/*
	DML 
		SELECT - *
        INSERT
        UPDATE
        DELETE
        
	2. INSERT
		
        이미 만들어져 있는 테이블에 데이터를 추가하는 명령
        주의 ]
			이 명령을 실행하면 데이터베이스에 데이터가 추가되어있는 것 처럼 보인다.
            하지만 DML 명령은 데이터베이스에 적용 명령(COMMIT)을 실행하지 않는 이상
            적용시키는 경우는 없다.
            
			따라서 이 명령을 실행한 후
            정확한 처리되었다 판단이 되면 
            반드시 COMMIT 명령으로 데이터베이스에 적용시켜 줘야한다.
            
		형식 1 ] 한개의 행을 추가하는 방법
			
            INSERT INTO
				테이블이름[(컬럼이름1, 컬럼이름2, .... )]
			VALUES(
				데이터1, 데이터2, ....
            );
            
		형식 2] 여러행을 동시에 추가하는 방법
            INSERT INTO
				테이블이름[(컬럼이름1, 컬럼이름2, ...)]
            VALUES
				(데이터1-1, 데이터1-2, ...),
                (데이터2-1, 데이터2-2, ...),
                ...
            ;
            
		형식 3 ]
			INSERT INTO
				테이블이름
            SET
				컬럼이름 = 데이터,
                컬럼이름2 = 데이터2,
                ...
			;
	참고 ]
		테이블 복사 명령
			
            CREATE TABLE 테이블이름
            AS
				SELECT
					컬럼이름, ....
                FROM
					테이블이름
                [WHERE 조건식 ]
			;
            
		테이블의 구조만 복사하는 방법
			CREATE TABLE 테이블이름
            AS
				SELECT
					컬럼이름, ....
                FROM
					테이블이름
                WHERE
					1 = 2
			;
            
	3. UPDATE
		==> 입력되어있는 데이터를 수정하는 명령
        
			형식 ]
				UPDATE
					테이블이름
                SET
					컬럼이름 = 데이터,
                    컬럼이름2 = 데이터2,
                    ...
                [WHERE
					조건식
                ] ==> 생략하면 모든 데이터를 수정하게 된다.
                ;
                
	4. DELETE
		==> 테이블에 입력되어있는 데이터를 삭제할 때 사용하는 명령
        
			형식 ]
				DELETE FROM
					테이블이름
				[WHERE
					조건식]
				;
*/

-- 테이블 복사
-- emp 테이블을 복사해서 tmp1 테이블을 만드세요.
CREATE TABLE tmp1
AS
	SELECT
		*
    FROM
		emp
;

SELECT * FROM tmp1;

-- emp 테이블을 구조만 복사해서(데이터 제외) tmp2 테이블을 만드세요.
CREATE TABLE tmp2
AS
	SELECT
		*
    FROM
		emp
    WHERE
		1 = 2
;

SELECT * FROM tmp2;

-- 컬럼을 나열해서 복사하는 경우
CREATE TABLE tmp3
AS
	SELECT
		empno eno, ename name, job, sal, deptno dno
    FROM
		emp
;

SELECT * FROM tmp3;

DESC emp;
DESC tmp3;

-- emp 테이블을 구조만 복사해서 emp2 테이블을 만드세요.
CREATE TABLE emp2
AS
	SELECT
		*
    FROM
		emp
    WHERE
		'A' = 'B'
;

SELECT * FROM emp2;

-- emp2 테이블에 1001번의 사원번호를 가지는 'jennie' 사원을 입력하세요.
INSERT INTO
	emp2
VALUES(
	1001, 'jennie', NULL, NULL, NULL, NULL, NULL, NULL
);

SELECT * FROM emp2;

-- emp2 테이블에 1002번 사원 'lisa'를 입력하세요.
INSERT INTO
	emp2(empno, ename)
VALUES(
	1002, 'lisa'
);

SELECT * FROM emp2;

-- 1003 번 1004번 'rose', 'jisoo' 사원을 추가하세요.
INSERT INTO	
	emp2(empno, ename)
VALUES
	(1003, 'rose'),
    (1004, 'jisoo')
;

SELECT * FROM emp2;

-- 1005번 'dooly' 사원의 급여를 50으로 하고 데이터추가하세요.
INSERT INTO
	emp2
SET
	empno = 1005,
    ename = 'dooly',
    sal = 50
;

SELECT * FROM emp2;

-- emp2테이블의 empno컬럼에 기본키 제약조건 추가
ALTER TABLE emp2
ADD CONSTRAINT EMP2_ENO_PK PRIMARY KEY(empno);

DESC emp2;

-- EMP2 테이블의 deptno 컬럼에 not null 제약조건 추가
ALTER TABLE emp2
MODIFY deptno TINYINT(2) NOT NULL
; -- 추가된 사원들의 부서번호가 null 이므로 에러가 발생한다.
-- 해결방법은 기존 NULL  데이터를 다른 부서번호로 수정해줘야 한다.

-- 모든 사원의 부서번호를 40부서로 변경한다.
UPDATE
	emp2
SET
	deptno = 40
;

ALTER TABLE emp2
MODIFY deptno TINYINT(2) UNSIGNED NOT NULL
;

SELECT * FROM EMP2;
DESC emp2;

-- deptno에 dept테이블의 deptno를 참조하는 참조키 제약조건을 추가하세요.
ALTER TABLE emp2
ADD CONSTRAINT EMP2_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno);

ALTER TABLE emp2
DROP CONSTRAINT EMP2_DNO_FK;

ALTER TABLE emp2
ADD CONSTRAINT EMP2_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno);

-- tmp1의 데이터를 모두 삭제하세요.
DELETE FROM 
	tmp1
;

-- 조회
SELECT * FROM tmp1;

-- tmp3 조회
SELECT * FROM tmp3;

-- 20번 부서의 사원들 삭제
DELETE FROM
	tmp3
WHERE
	dno = 20
;

-- 확인
SELECT * FROM tmp3;

-- cte를 활용해서 사원번호를 자동으로 입력되게 'loofy' 사원을 추가하세요.
-- 다음 사원번호
SELECT
	IFNULL(MAX(empno) + 1, 1001)
FROM
	emp2
;

INSERT INTO
	emp2(empno, ename, deptno)
VALUES(
	(
    WITH geteno as
    (
		SELECT
			IFNULL(MAX(empno) + 1, 1001) eno
		FROM
			emp2
    )
    SELECT eno FROM geteno), 
    'loofy', 40
);

SELECT * FROM emp2;

-- AUTO_INCREMENT 추가
DESC emp2;

-- 컬럼을 수정한다.
ALTER TABLE emp2
MODIFY empno SMALLINT UNSIGNED AUTO_INCREMENT
;

-- 30번 부서의 'zoro' 사원을 추가하세요.
INSERT INTO
	emp2(deptno, ename) -- 데이터입력순서는 컬럼이름 나열 순서를 따른다.
VALUES(
	30, 'zoro'
);

-- 조회
SELECT
	*
FROM
	emp2
;

--  AUTO_INCREMENT 값 변경
ALTER TABLE emp2 AUTO_INCREMENT = 1011;

-- 20번 부서 'boahancock' 추가하세요.
INSERT INTO
	emp2(ename, deptno)
VALUES(
	'boahancock', 20
);

-- 결과조회
SELECT * FROM emp2;

insert into
	emp2(empno, ename, deptno)
values(
	999, 'woosop', 30
);

insert into
	emp2(ename, deptno)
values(
	'sanji', 30
);

select * from emp2;

insert into
	emp2(empno, ename, deptno)
values(
	1500, 'choppa', 30
);

insert into
	emp2(ename, deptno)
values(
	'nami', 30
);

select * from emp2;

commit;

---------------------------------------------------------------------------------------
/*
	집합연산자
		
        UNION
        ==> 두개의 질의명령의 결과를 합치는 연산자
			중복되는 데이터는 생략한다.
        UNION ALL
        ==> 두개의 질의명령의 결과를 합치는데 중복되는 데이터를 중복해서 추가한다.
        
        [
			MINUS
            
            INTERSECT
            
            ..
        ]
*/

SELECT
	empno, ename
FROM
	emp
WHERE
	deptno = 20
UNION
SELECT
	deptno, job
FROM
	emp
;


SELECT
	empno, ename
FROM
	emp
WHERE
	deptno = 20
UNION -- 중복 데이터는 한번만 조회
SELECT
	empno, ename
FROM
	emp
WHERE
	deptno = 20
;

SELECT
	empno, ename
FROM
	emp
WHERE
	deptno = 20
UNION ALL -- 중복 데이터는 한번만 조회
SELECT
	empno, ename
FROM
	emp
WHERE
	deptno = 20
;

---------------------------------------------------------------------------------------
/*
	사원들중 부서원수가 가장 많은 부서 소속 사원중
    소속 부서의 평균 급여보다 급여가 낮은 사원들의
    사원번호, 사원이름, 직급, 부서이름, 입사일을 조회하세요.
    부서평균급여, 부서최대급여, 부서원수
    
    -- 힌트 ] 부서별 집계테이블이 만들어져 있으면 조회가 쉬워질 것이다.
*/
WITH T AS (
SELECT
	deptno dno, AVG(sal) avg, MAX(sal) max, COUNT(*) cnt
FROM
	emp
GROUP BY
	deptno
)
SELECT
	*
FROM
	emp, t,
    (
		SELECT
			MAX(cnt) mcnt
        FROM
			t
    ) a
WHERE
	deptno = dno
    and cnt = mcnt
    AND sal < avg
;











