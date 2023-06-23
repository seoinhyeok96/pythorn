-- 색상이름이 영문인 테이블을 만들자.
CREATE TABLE ecolor(
	ecode CHAR(7),
    ecname VARCHAR(20) NOT NULL,
    CONSTRAINT ECLR_CODE_PK PRIMARY KEY(ecode)
);
-- ) ENGINE=InnoDB ==> 처리엔진 : 기본값이므로 별도로 기술하지 않아도 된다.

-- 한글 칼라 테이블
CREATE TABLE kcolor(
	kcode CHAR(7),
    kcname VARCHAR(20) NOT NULL,
    CONSTRAINT KCLR_CODE_PK PRIMARY KEY(kcode)
);

-- 영문 칼라 데이터 추가
INSERT INTO
	ecolor
VALUES
	('#FF0000', 'RED'),
    ('#00FF00', 'GREEN'),
    ('#0000FF', 'BLUE')
;

-- 한글 칼라 데이터 추가
INSERT INTO
	kcolor
VALUES
	('#FF0000', '빨강'),
    ('#FFFF00', '노랑'),
    ('#0000FF', '파랑'),
    ('#00FF00', '초록')
;

COMMIT;

SELECT * FROM ecolor;

SELECT * FROM kcolor;

-- 두 테이블의 Cartisian Product 조회
SELECT
	*
FROM
	ecolor, kcolor
;

SELECT
	*
FROM
	ecolor, kcolor
WHERE
	ecode = kcode
;

-- OUTER JOIN
SELECT
	*
FROM
	ecolor
RIGHT OUTER JOIN
	kcolor
ON
	ecode = kcode
;

SELECT
	*
FROM
	ecolor
INNER JOIN
	kcolor
ON
	ecode = kcode
;

------------------------------------------------------------------------------
/*
	\n		: 줄바꿈기호
    \t		: 탭키
    \r\n	: 엔터키
    \b		: backspace
*
/
/*
	csv 파일을 테이블에 저장하는 방법
		1. 테이블을 만든다.
        2. 
			LOAD DATA LOCAL INFILE '파일경로' 	-->  파일경로
            [IGNORE ] INTO TABLE 테이블이름		--> 테이블지정
			FIELDS TERMINATED BY ','			--> 컬럼 구분 지정
            OPTIONALLY ENCLOSED BY '"'			--> 필요한 경우 따옴표로 구분
            LINES TERMINATED BY '\n'			--> 행 구분문자 지정
            [
            IGNORE 1 LINES						--> 컬럼 이름행 무시
            ]
            
*/

-- 테이블 생성
/*
	sepal_length,sepal_width,petal_length,petal_width,species
*/

CREATE TABLE iris(
	sepallength DECIMAL(3,1) NOT NULL,
    sepalwidth DECIMAL(3,1) NOT NULL,
    petallength DECIMAL(3,1) NOT NULL,
    petalwidth DECIMAL(3,1) NOT NULL,
    species VARCHAR(15)
);

/*
	LOAD DATA LOCAL INFILE 명령은
    다음 시스템 변수가 셋팅이 되어있어야 작업이 된다.
    
		@@local_infile			==> 1
        @@secure_file_priv		==> NULL 또는 없어야된다.
*/

SELECT
	@@local_infile,
    @@secure_file_priv
;

LOAD DATA LOCAL INFILE 'C:\\mlProj\\db\\src\\iris.csv'
IGNORE INTO TABLE iris
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM iris;

-- 컬럼이름을 수정해서 테이블 복사
CREATE TABLE iris2
AS
	SELECT
		sepallength sepallen, sepalwidth sepalwd, 
        petallength petallen, petalwidth petalwd, species
    FROM
		iris
;

SELECT * FROM iris2;

-- group by
-- 각 속성별 분산 조회
SELECT
	variance(sepallen) seplen, variance(sepalwd) sepwd,
    variance(petallen) petlen, variance(petalwd) petwd
FROM
	iris2
GROUP BY
	species
;

SELECT DISTINCT species FROM iris2;

-- Consolas

SELECT
	species, char_length(species) len
FROM
	iris2
LIMIT 1
;

UPDATE
	iris2
SET
	species = SUBSTR(species, 1, CHAR_LENGTH(species) - 1)
;

SELECT
	*
FROM
	iris2
LIMIT 140, 10
;

commit;