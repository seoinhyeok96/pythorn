-- 데이터 조회 질의명령
/*
	이것은 여러행 주석
    ...
    ...
*/

-- 단일행 주석

# 단일행 주석

-- ---------------------------------------------------------------
/*
	기본 조회 질의명령( 쿼리명령 )
    
	형식 ]
		SELECT
			컬럼이름1, 컬럼이름2, ...
        FROM
			테이블이름
        ;
        
	참고 ]
		emp			: 사원정보 테이블
			- 컬럼
					empno	: 사원번호
                    ename	: 사원이름
                    job		: 직급
                    mgr		: 상사번호(상사의 사원번호)
                    hiredate : 입사일
                    sal		:  급여
                    comm 	: 커미션
                    deptno	: 부서번호
                    
        dept		: 부서정보 테이블
					
                    deptno	: 부서번호
                    dname	: 부서이름
                    loc		: 부서위치
                    
        salgrade	: 급여등급 테이블
					
                    grade	: 급여등급
                    losal	: 최소급여
                    hisal	: 최대급여
                    
        bonus		: 보너스 테이블
*/

-- 사원들의 사원번호, 사원이름 을 조회하세요.
SELECT
	empno, ename
FROM
	emp
; -- 세미콜론은 하나의 질의명령이 끝났음을 알려주는 기호( 명령 처리 단위 )


select 
	'abcd' 문자열, curdate() 오늘날짜
from
	emp
;

SELECT * FROM emp;

-- 테이블을 정의하지 않는 경우
SELECT 
	'abcd' 문자열, CURDATE() 오늘날짜
;

SELECT 
	'abcd' 문자열, CURDATE() 오늘날짜
FROM
	dual -- 데이터베이스에서 제공해주는 한행으로 된 가상의 테이블
;

SELECT
	1 + 1 더하기
FROM
	dual
;

/*
	참고 ]
		질의명령의 
			명령키워드, 테이블이름, 컬럼(필드)이름, 함수, ...
		등은 대소문자를 가리지 않는다.
        
    별칭 부여 방법
		1.
        컬럼이름 AS "별칭이름"
        
        2. 
        컬럼이름 별칭이름
        
	참고 ]
		데이터베이스에서 문자열 데이터의 표현은
        ''(작은따옴표)로 표현한다.
*/

SELECT
	empno AS "사 원 번 호", ename AS "사 원 이 름"
FROM
	emp
;

SELECT
	empno 사원번호, ename 사원이름
FROM
	emp
;

-- DISTINCT : 중복되는 행을 하나로 걸러서 조회하는 방법
-- 사원들의 부서번호를 조회하세요. 단, 중복되는 부서번호는 한번만 조회하세요.
SELECT
	deptno
FROM
	emp
;

SELECT
	DISTINCT deptno
FROM
	emp
;

-- 사원들의 부서번호, 직급을 조회하세요. 단, 중복되는 정보는 한번만 조회하세요.
SELECT
	DISTINCT deptno, job
FROM
	emp
;

SELECT
	deptno, job
FROM
	emp
ORDER BY
	deptno, job
;

-- n개 조회
SELECT
	*
FROM
	emp
ORDER BY
	sal DESC
LIMIT 5, 5
;

/*
	LIMIT [시작인덱스,] 꺼낼갯수
*/
/*
	참고 ]
		데이터베이스에서 인덱스(위치값)은 1부터 시작한다.
*/

-- 테이블의 간략한 구조를 살펴보는 방법
-- 형식 ] DESCRIBE 테이블이름; 또는 DESC 테이블이름;

DESCRIBE emp;
DESC emp;

-- 변수 작성 및 대입

SELECT
	@no := @no + 1 as num
FROM
	(SELECT @no := 0) d
;

-- IS NULL , IS NOT NULL
/*
	NULL 데이터는 모든 연산에서 제외된다.
*/

-- 사원중 상사가 없는 사원의 사원이름을 조회하세요.
SELECT
	ename 사원이름
FROM
	emp
WHERE
	-- 조건절...
--    mgr = NULL -- 이 연산의 결과는 NULL이 반환되므로 잘못된 조건처리...
	mgr IS NULL
;

SELECT * FROM emp;

-- 조건 처리 질의명령
/*
	형식 ]
		SELECT
			컬럼이름, ...
        FROM
			테이블이름
        WHERE
			조건식
        ;
*/

-- 10번 부서 소속의 사원들의 사원번호, 사원이름, 부서번호를 조회하세요.
SELECT
	empno 사원번호, ename 사원이름, deptno 부서번호
FROM
	emp
WHERE
	deptno = 10
    -- 여러조건은 나열할 경우 AND 또는 OR 를 붙여서 나열하면 된다.
    AND job = 'CLERK'
;

SELECT * FROM emp;

/*
	데이터베이스에서도 하나의 연산식에서 조건 두개를 동시에 처리하는 연산자는 없다.
    예 ]
		1000 <= SAL <= 3000	--> x
        ==>
        SAL >= 1000
        AND SAL <= 3000
*/

-- IN()
-- 사원의 직급이 'SALESMAN'이거나 'CLERK' 인 사원들의 사원이름, 직급 을 조회하세요.
SELECT
	ename 사원이름, job 직급
FROM
	emp
WHERE
	job = 'SALESMAN'
    OR job = 'CLERK'
;

-- IN()
SELECT
	ename 사원이름, job 직급
FROM
	emp
WHERE
	job IN ('SALESMAN', 'CLERK')
;

SELECT
	ename 사원이름, job 직급
FROM
	emp
WHERE
	job = ANY (
			SELECT
				DISTINCT job
			FROM
				emp
			WHERE
				job IN ('SALESMAN', 'CLERK')
    )
;

-- EXISTS(질의명령) : 질의명령의 결과 행이 존재하면 참, 결과가 없으면 거짓으로 ...
-- 40번 부서 사원이 존재하면 사원들의 사원이름, 부서번호를 조회하세요.
SELECT
	ename, deptno
FROM
	emp
WHERE
	NOT EXISTS (
		SELECT
			*
        FROM
			emp
        WHERE
			deptno = 40
    )
; -- 40번 부서 소속 사원은 존재하지 않기 때문에 조회되는 데이터는 없다.

-- LIKE '와일드카드'
/*
	LIKE 'A%' ==> 'A'로 시작하는 모든 문자열이면 참
    LIKE 'A_' ==> 'A'로 시작하고 길이가 2인 문자열이면 참
    LIKE '%X' ==> 'X'로 끝나는 문자열이면 참
*/
-- 이름이 'R'로 끝나는 사원의 사원이름, 직급, 부서번호를 조회하세요.
SELECT
	ename 사원이름, job 직급, deptno 부서번호
FROM
	emp
WHERE
	ename LIKE '%R'
;

-- 이름의 두번째 문자가 'L' 인 사원들의 사원이름, 직급, 부서번호를 조회하세요.
SELECT
	ename 사원이름, job 직급, deptno 부서번호
FROM
	emp
WHERE
	ename LIKE '_L%'
;

------------------------------------------------------------------------
/*
	문제 1 ]
		사원들의 사원번호, 사원이름, 급여를 조회하세요.
*/

/*
	문제 2 ]
		급여가 1000 이상 3000 이하인 사원들의
        사원번호, 사원이름, 직급, 급여를 조회하세요.
*/

/*
	문제 3 ]
		이름 'S'로 시작하는 사원들의
        사원이름, 직급, 입사일 을 조회하세요.
*/

/*
	문제 4 ]
		이름의 글자수가 5글자인 사원들의 
        사원이름, 상사번호, 급여를 조회하세요.
*/

/*
	문제 5 ]
    직급이 'MANAGER'를 제외한 모든 사원들의 
    사원이름, 직급, 입사일을 조회하세요.
*/
SELECT
	ename 사원이름, job 직급, hiredate 입사일
FROM
	emp
WHERE
#	job <> 'MANAGER'
#	job != 'MANAGER'
	NOT job = 'MANAGER'
;
/*
	문제 6 ]
		사원들의 사원이름, 직급, 급여, 커미션 을 조회하세요.
        단, 급여가 많은 사람부터 조회되게 하세요.
*/
SELECT
	ename 사원이름, job 직급, sal 급여, sal + 100 "100 인산된 급여", comm 커미션
FROM
	emp
WHERE
	sal >= 3000
ORDER BY
	급여 DESC
;
/*
	문제 7 ]
		이름에 'A'가 포함된 사원들의
        사원이름, 직급, 입사일을 조회하세요.
        단, 이름순 오름차순 정렬하세요.
*/
