SELECT
    *
FROM
    orders;

SELECT
    *
FROM
    emp
WHERE
    deptno BETWEEN 10 AND 30;

SELECT
    empno,
    ename,
    job,
    hiredate
FROM
    emp
WHERE
        empno >= 1020
    AND empno <= 1030;

SELECT
    *
FROM
    emp
WHERE
    hiredate BETWEEN '21/01/01' AND '21/12/31';

SELECT
    *
FROM
    emp
WHERE
    deptno = 10
    OR deptno = 20
    OR deptno = 30;

SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20, 30 );

SELECT
    *
FROM
    emp
WHERE
    job IN ( '사원', '대리', '팀장' );

SELECT
    *
FROM
    emp
WHERE
    hiredate IN ( '20/01/10', '21/01/10', '22/06/18' );

SELECT
    *
FROM
    emp
WHERE
    hiredate NOT BETWEEN '21/01/01' AND '21/12/31';

SELECT
    *
FROM
    emp
WHERE
    hiredate NOT IN ( '20/01/10', '21/01/10', '22/06/18' );

SELECT
    *
FROM
    emp
WHERE
    comm IS NOT NULL;

SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;

SELECT
    *
FROM
    emp
WHERE
    ename LIKE '이%';

SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%민';

SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%하%';

SELECT
    *
FROM
    emp
WHERE
    ename LIKE '송_영';

SELECT
    *
FROM
    emp
WHERE
    hiredate LIKE '25%';

SELECT
    lengthb('홍길동')
FROM
    dual;

@c:\oracleDev\zipcode

SELECT
    COUNT(*)
FROM
    zipcode;

COMMIT;

SELECT *
FROM zipcode
WHERE dong LIKE '서초%';

/*
    ***BETWEEN 범위 검색 컬럼명 BETWEEN 값 (최소) AND 값 (최대)
    ***IN 여러값 검색 컬럼명 IN(값, 값...)
    ***LIKE 문자패턴 검색 컬럼명 LIKE '%값%', '%값', '값%', '_값'
    NOT 조건 반대 NOT IN, NOT LIKE, NOT BETWEEN
    IS NULL NULL 검색 컬럼명 IS NULL
    IS NOT NULL NULL 제외 컬럼명 IS NOT NULL
*/

-- 복합
SELECT *
FROM emp;

-- 사원중에 25년 입사 => 직위가 사원인 사람 정보
SELECT *
FROM emp
WHERE hiredate LIKE '25%' AND job = '사원';

-- 2020년에 입사한 사원중에 성과급을 받는 사원의 정보
SELECT *
FROM emp
WHERE hiredate LIKE '20%' AND comm IS NOT NULL;

-- 사원중에 20년 입사 => 김씨성을 가진 사원 정보 출력
SELECT *
FROM emp
WHERE hiredate LIKE '20%' AND ename LIKE '김%';

/*
    SELECT 문장 => 데이터 검색용
        ----------------------------------------
    형식) SELECT * | column 나열 (원하는 데이터)
         FROM table_name (view_name, SELECT~)
        ---------------------------------------- 필수
        [
            WHERE 조건 => 연산자
            GROUP BY => 그룹별로 따로 처리
            HAVING   => 그룹 조건
            ORDER BY => 정렬
        ]
        
        => FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
                                      | => GROUP BY가 있는 경우
        => WHERE : 조건문이 필요
                 --------
                   연산자 / 내장함수
        연산자
          산술연산자 ( + - * / )
                    / => 정수/정수 = 실수
                    + => 문자열 결합 (x) ==> ||
          비교연산자 : =, !=(<>, ^=), <, >, <=, >=
          논리연산자 : OR, AND
          BETWEEN : 범위 검색
          IN : 여러개 검색
          LIKE : 유사 검색
          NOT  : 반대 검색
          NULL : IS NULL, IS NOT NULL
          WHERE 컬럼명 연산자 값
                --------------
    
    ORDER BY => 정렬
    ORDER BY 정렬할 컬럼 ASC | DESC
                              | 내림차순
                        | 오름차순
*/ 

SELECT *
FROM emp
ORDER BY sal DESC;

SELECT *
FROM emp
ORDER BY deptno ASC;

SELECT *
FROM emp
ORDER BY hiredate ASC;

SELECT *
FROM emp
ORDER BY hiredate; -- ASC는 생략이 가능

SELECT *
FROM emp
ORDER BY 4;

SELECT *
FROM emp
ORDER BY 7 DESC, 1 DESC; -- 이중 정렬 

DESC book;

DESC customer;

SELECT *
FROM book;

commit;0.















