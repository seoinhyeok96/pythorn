/*
	decimal : 365.2426		==> 고정 소수점 방식
    float : 3.652426 * 10^2 ==> 부동 소수점 방식
*/

-- 산술연산자
SELECT
	10 + 3 더하기, 10 - 3 빼기, 10 * 3 곱하기, 10 / 3 나누기
;

-- 사원들의 커미션에 100 더해서 사원이름, 급여, 커미션을 조회하세요.
SELECT
	ename 사원이름, sal 급여, comm + 100 커미션
FROM
	emp
;

SELECT
	e1.ename 사원이름, e1.sal 급여, e1.comm + 100 커미션, e2.*
FROM
	emp e1, emp e2
WHERE
	e1.empno = e2.empno -- self join
;

-- div, mod
SELECT
	10 div 3 "10 / 3 의 몫", 10 mod 3 "10 / 3 의 나머지",
    mod(10, 3), 10 % 3
FROM
	dual -- 물리적으로 만들어져있지 않은 시스템이 제공해주는 가상의 테이블 : 의사테이블
;

-- not
SELECT
	*
FROM
	emp
WHERE
#	1 != 2
	NOT 1 = 2 -- NOT : 부정연산자
;

SELECT
	3 & 5, 3 | 5
FROM
	dual
;

-- 부서번호가 10, 20번인 사원들의 사원이름, 직급, 부서번호를 조회하세요.
SELECT
	ename 사원이름, job 직급, deptno 부서번호
FROM
	emp
WHERE
	deptno = 10
    OR deptno = 20
;
SELECT
	ename 사원이름, job 직급, deptno 부서번호
FROM
	emp
WHERE
	deptno IN (10, 20)
;

-- 사원들 중 이름이 'A' 또는 'B'로 시작하는 사원들의
-- 사원번호, 사원이름, 입사일 을 조회하세요.
SELECT
	empno 사원번호, ename 사원이름, hiredate 입사일
FROM
	emp
WHERE
	ename LIKE 'A%'
    OR ename LIKE 'B%'
;

-- 사원들중 사원이름이 'B'로시작하고 이름이 다섯글자인 사원들의 사원이름, 직급을 조회하세요.
SELECT
	ename 사원이름, job 직급
FROM
	emp
WHERE
#	ename LIKE 'B____'
	ename LIKE 'B%'
    AND ename LIKE '_____'
;

-- 사원들중 커미션을 받는 사원들의 사원번호, 급여, 커미션을 조회하세요.
-- 단, 커미션은 현재 커미션에서 200 더한 값으로 조회하세요.
SELECT
	empno 사원번호, sal 급여, comm + 200 커미션
FROM
	emp
WHERE
#	comm != NULL	==> 결과값 : NULL ==> FALSE로 처리
	comm IS NOT NULL
;

SELECT DISTINCT JOB, DEPTNO FROM EMP;

SELECT * FROM DEPT;
/*
 사원들의 부서번호가
	10 : 회계부
    20 : 개발부
    30 : 영업부
    40 : 운영부
로 사원들의 사원이름, 부서번호, 부서이름을 조회하세요.
 */
 
 SELECT
	ename 사원이름, deptno 부서번호,
    (
		CASE WHEN deptno = 10 THEN '회계부'
			WHEN deptno = 20 THEN '개발부'
            WHEN deptno = 30 THEN '영업부'
            WHEN deptno = 40 THEN '운영부'
            ELSE '딴 회사 사람'
		END
    ) 부서이름
 FROM
	emp
 ;
 
 -- 형식 2 ]
 SELECT
	ename 사원이름, deptno 부서번호,
    (
		CASE deptno
			WHEN 10 THEN '회계부'
			WHEN 20 THEN '개발부'
            WHEN 30 THEN '영업부'
            WHEN 40 THEN '운영부'
            ELSE '딴 회사 사람'
		END
    ) 부서이름
 FROM
	emp
 ;
 
 /*
	사원들의
		사원이름, 직급, 커미션을 조회하세요.
	단, 커미션이 있으면 기존커미션에 100 더한값으로 조회하고
    없으면 50으로 조회되게 하세요.
 */
 SELECT * FROM emp;
 
 SELECT
	ename 사원이름, job 직급, 
    (
		IFNULL(comm + 100, 50)
    ) 커미션
 FROM
	emp
 ;
 
 -- 위 문제를 커미션이 없는 사원은 '커미션 없음' 으로 조회되게 하세요.
SELECT
	ename 사원이름, job 직급, 
    (
		IFNULL(CAST(comm + 100 AS CHAR), '커미션 없음')
    ) 커미션
FROM
	emp
;

SELECT ASCII('A') FROM dual;

SELECT 'A' + 'B';
SELECT '123' + 1;
SELECT 'ABCD' + 1;

SELECT CONCAT('ABCD', 1);

/*
	사원들의
		사원번호 - 사원이름 - 직급
	을 조회하세요.
*/
SELECT
	CONCAT(empno, ' - ', ename, ' - ', job) 사원정보
FROM
	emp
;

-- 사원들의 사원번호, 사원이름, 직급 을 조회하세요. 
-- 단, 사원이름은 이름앞에 'Mr.' 을 붙여서 조회되게하세요.
SELECT
	empno 사원번호, CONCAT('Mr.', ename) 사원이름, job 직급
FROM
	emp
;

-- 위 문제를 해결하는데 
-- 상사가 있으면 [ 사원이름 사원 ]으로 상사 없으면 [ 사원이름 사장님 ] 으로 조회하세요.
SELECT
	empno 사원번호, 
    CONCAT(
		ename, IF(mgr IS NULL, ' 사장님', ' 사원')
    ) 사원이름, 
    job 직급
FROM
	emp
;
SELECT
	empno 사원번호, 
    (
		CASE 
			WHEN mgr IS NULL THEN CONCAT(ename, ' 사장님')
            ELSE CONCAT(ename, ' 사원')
		END
    ) 사원이름, 
    job 직급
FROM
	emp
;

-- 입사일이 1985년 이전에 입사한 사원들의 사원번호, 사원이름, 입사일을 조회하세요.
SELECT
	empno 사원번호, ename 사원이름, hiredate 입사일
FROM
	emp
WHERE
	hiredate < STR_TO_DATE('1985/01/01', '%Y/%m/%d')
;

SELECT
	LENGTH('ABCD'), CHAR_LENGTH('ABCD')
FROM
	dual
;


SELECT
	LENGTH('가나다라'), CHAR_LENGTH('가나다라')
FROM
	dual
;

SELECT
	RIGHT('HELLO WORLD!', 6), LEFT('HELLO WORLD!', 5),
    MID('HELLO WORLD!', 7, 2)
FROM
	dual 
;

SELECT
	TRIM('          H                  E               L            L            O        ') trim,
    RTRIM('          H                  E               L            L            O        ') rtrim,
    LTRIM('          H                  E               L            L            O        ') ltrim
FROM
	dual
;

SELECT UCASE('aBcd') ucase, LCASE(ename) FROM emp;

SELECT
	SUBSTRING('hello world!', 7, 5) substring,
    MID('hello world!', 7, 5) mid,
    SUBSTR('hello world!', 7, 5) substr,
    SUBSTRING_INDEX('1,2,3,4,5', ',',3) substring_index
FROM
	dual
;

SELECT INSERT('abcd', 3, 1, '1234') 문자열대체; 
-- 인덱스 3부터 1개의 문자를 뒤 문자열로 대체해서 반환

SELECT REPLACE('          H                  E               L            L            O        ',
				' ', ''
                )  공백제거,
		REPLACE('AABBCCDD', 'BB', '*');

SELECT REPEAT('jennie!', 10);

SELECT REPLACE(CONCAT('J', SPACE(5), 'I', SPACE(5), 'E', SPACE(5)), ' ', '#');
-- ==> J#####I#####E#####
-- 나눔고딕코딩, D2CODING
/*
	12345
    abcde
    ABCDE
    가나다
    
    0Ooㅇ
    iIl1
*/

-- 사원들의 사원번호, 사원이름을 조회하는데 
-- 사원이름은 15글자에 맞추고 남는 부분은 오른쪽에 * 로 채우세요.
-- 예 ] SMITH ==> SMITH*****
SELECT
	empno 사원번호, 
    RPAD(ename, 15, '*') 사원이름1,
    LPAD(ename, 15, '*') 사원이름2
FROM
	emp
;

-- 사원번호, 사원이름을 조회하는데 이름의 두번째 문자는 보여주고 나머지는 '*'로 표시하세요.
SELECT
	empno, ename,
    -- 두번째 문자 추출
    SUBSTR(ename, 2, 1) "두번째 문자",
    CONCAT('*', SUBSTR(ename, 2, 1)) "두번째 문자까지",
    RPAD(
		CONCAT(
			'*', 
            SUBSTR(ename, 2, 1)
        ), 
        CHAR_LENGTH(ename), 
        '*'
    ) 이름
FROM
	emp
;

-- 사원번호, 사원이름, 메일주소 를 조회하세요.
-- 메일 도메인은 @dmc.com
-- 단, 메일 아이디는 소문자로 표현하세요.
SELECT
	empno 사원번호, ename 사원이름,
    CONCAT(LCASE(ename), '@dmc.com') 메일주소,
    INSTR(CONCAT(LCASE(ename), '@dmc.com'), '@') "@ 위치",
    CHAR_LENGTH(ename) 이름길이
FROM
	emp
;

SELECT STRCMP('A', 'B'), STRCMP('B', 'A');

SELECT INSTR('HELLO', 'LLO');
SELECT LOCATE('LLO', 'HELLO');

-- CEILING()
SELECT
	CEILING(3.14) C1,
    CEILING(-3.14) C2,
    CEILING(-5) C3
;

SELECT
	CURDATE() 현재날짜, CURTIME() 현재시간, SLEEP(5),
    NOW() 지금시간, SYSDATE() 시스템시간
;

-- 사원들의 사원이름, 입사일, 근무개월수를 조회하세요.
SELECT
	ename 사원이름, hiredate 입사일,
    PERIOD_DIFF(
		DATE_FORMAT(CURDATE(), '%Y%m'), 
        DATE_FORMAT(hiredate, '%Y%m')
    ) 근무개월수1,
    PERIOD_DIFF(
		DATE_FORMAT(hiredate, '%Y%m'), 
        DATE_FORMAT(CURDATE(), '%Y%m')
    ) 근무개월수2
FROM
	emp
;

SELECT 
	CURDATE() - hiredate 근무일수
FROM 
	emp
;

SELECT
	ADDDATE(CURDATE(), INTERVAL 2 MONTH)
;

-- 사원들의 사원이름, 급여, 회사급여총액 을 조회하세요.
SELECT
	ename, sal, SUM(sal)
FROM
	emp
;

SELECT * FROM emp;

-- 사원들의 급여합계, 급여평균, 최대급여, 최소급여, 사원수 를 조회하세요.
SELECT
	SUM(sal) 급여합계, AVG(sal) 급여평균, 
    MAX(sal) 최대급여, MIN(sal) 최소급여, COUNT(*) 사원수,
    AVG(comm) 평균커미션, MAX(comm) 최대커미션, MIN(comm) 최소커미션
FROM
	emp
;

SELECT
	empno 사원번호, ename 사원이름, sal 급여, 
    (
		MAX(sal) OVER()
    ) 회사최대급여,
    (
		MAX(sal) OVER(PARTITION BY deptno)
    ) 부서최대급여
FROM
	emp
;

/*
	SUB QUERY(부질의, 서브질의)
    - 질의명령 내에 완벽한 조회 질의명령이 포함될 수 있다.
		이때 이 포함되는 질의명령을 서브질의라 부른다.
    
*/

-- 사원들의 사원번호, 사원이름, 급여, 회사평균급여 를 조회하세요.

SELECT
	empno 사원번호, ename 사원이름, sal 급여,
    (
		SELECT
			AVG(e.sal)
        FROM
			emp e
    ) 회사평균급여,
    (
		(
			SELECT
				AVG(e.sal)
			FROM
				emp e
		) - sal
    ) "평균급여와의 차1",
    (
		SELECT
			AVG(e1.sal) - e.sal
		FROM
			emp e1
    ) "평균급여와의 차2"
FROM
	emp e
;

-- 
SELECT
	empno 사원번호, ename 사원이름, sal 급여, 
    avg 회사평균급여, min 회사최소급여, max 회사최대급여, cnt 사원수
FROM
	emp e,
    (
		SELECT
			COUNT(*) cnt, SUM(sal) sum, AVG(sal) avg,
            MAX(sal) max, MIN(sal) min
        FROM
			emp
    ) t -- 서브질의중  from 절에 들어가는 서브질의를 INLINE VIEW 라고 부른다.
;

select * from emp, dept;

-- GROUP BY
SELECT
	deptno 부서번호, -- 그룹화 기준 컬럼은 집계함수와 함께 사용할 수 있다.
    AVG(sal) 부서평균급여, 
    MAX(sal) 부서최대급여, MIN(sal) 부서최소급여, SUM(sal) 부서급여합계, COUNT(*) 부서원수
FROM
	emp
GROUP BY
	deptno
;

-- 이름 첫문자로 그룹화해서 사원수를 조회하세요.
SELECT
	SUBSTR(ename, 1, 1) 첫문자, COUNT(*) 사원수
FROM
	emp
GROUP BY
	SUBSTR(ename, 1, 1)
;

-- 직급별 사원들의 직급, 사원수, 급여평균, 최대급여 를 조회하세요.
SELECT
	job 직급, deptno 부서번호, COUNT(*) 사원수, AVG(sal) 급여평균, MAX(sal) 최대급여
FROM
	emp
GROUP BY
	job, deptno
ORDER BY
	사원수 DESC
;

-- 직급별 사원들 중 부서별 직급, 부서번호, 사원수, 급여평균, 최대급여 를 조회하세요.
SELECT
	job 직급, deptno 부서번호, COUNT(*) 사원수, AVG(sal) 급여평균, MAX(sal) 최대급여
FROM
	emp
GROUP BY
	job, deptno
ORDER BY
	사원수 DESC
;

-- 사원들중 커미션을 받는 사원의 수를 조회하세요.
SELECT
	COUNT(comm) "커미션 받는 사원 수" -- NULL 데이터는 카운트 하지 않는다.
FROM
	emp
;

SELECT
	COUNT(*)
FROM
	emp
WHERE
	comm IS NOT NULL
;

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
#	AVG(sal) >= (SELECT AVG(sal) FROM emp)
#	AVG(sal) >= all (SELECT AVG(sal) OVER() FROM emp) 
	AVG(sal) >= tav
;









