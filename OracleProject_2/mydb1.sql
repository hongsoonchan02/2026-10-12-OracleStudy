-- 20260-11-25 3장 / 4장 => 연산자 정리, 내장함수, GROUP BY / HAVING
/*
    SELECT * | column_list
    FROM table_name
    [
        WHERE 연산자 (조건)
        GROUP BY 그룹컬럼
        HAVING 그룹 조건 => 집합 함수
        ORDER BY 정렬 컬럼
    ]
    
    FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
    
    1) SELECT
       => 테이블에 어떤 컬럼이 있는지, 컬럼에 저장된 데이터형
          DESC table_name
       => 문자열 / 날짜 => 반드시 ''를 사용한다
       => SQL문장의 마지막엔 반드시 ;을 사용
          (자바는 자동으로 ;을 만들어준다.)
       => 키워드는 대문자로 사용 => 대소문자 구분이 없다.
       => 중복없이 데이터 추출 : DISTINCT 컬럼
                              --------- JAVA의 SET과 비슷함
       => 별칭 => 컬럼명 "별칭", 컬럼명 as 별칭
       => 문자열 결합 => ||
       => 한줄에 코딩 / 여러줄로도 가능
       SELECT * FROM emp;
       ------------------
       SELECT *
       FROM emp;
       ------------------ 띄어쓰기 주의 => 자바에서 오류 (문자열)
       
       연산자
       ------ WHERE에서 사용되는 조건
       산술연산자 (+, -, *, /) => 순수하게 산술만 사용이 가능
                 3 + 5 = 8
                 '3' + '5' = 8
                 --------- 자동으로 숫자 변환 (묵시적 형변환)
                 TO_NUMBER('3')
                 -------------- 단점은 속도가 누려진다
                 / => 정수 / 정수 = 실수
                       5  /  2   = 2.5
       비교연산자 : = (같다)
                   = : WHERE에서 사용 => 같다
                     : WHERE외에 다른 곳에서 사용 => 대입
                     !=, <>(권장), ^=
                     <, >, <=, >=
       논리연산자 : AND. OR
                        | 하나만 해당해도 선택
                    | 둘 다 해당
                    && => 입력받는 경우
                    || => 문자열 결합 
       BETWEEN ~ AND : 기간, 범위
                 WHERE 컬럼 BETWEEN 값 AND 값
                                   --     -- 포함
                 # 숫자, 날짜, 문자
                 >= AND <=
       IN : 여러개를 동시에 수행
            WHERE 컬럼 IN(값, 값, 값...)
       NOT : 부정 => NOT IN, NOT BETWEEN, NOT LIKT
       NULL : 데이터가 저장이 안된 상태
              # 연산 처리가 안된다
              IS NULL => NULL인 경우
              IS NOT NULL => NULL이 아닌 경우
       LIKE : 검색 => 포함 여부
              % : 여러개 문자 (갯수가 없다)
              _ : 한글자
              
              WHERE 컬럼명 LIKE 'A%'
              WHERE 컬럼명 LIKE '%A'
              WHERE 컬럼명 LIKE '%A%'
              WHERE 컬럼명 LIKE '__A%'
              
       데이터베이스의 단점
       ----------------
         경우의 수가 많다 (같은 데이터를 추출 => sql문장이 여러개 있다)
                                             --------------------
                                             | 가장 빠른 속도 => 튜닝
         SQL => 문자 형식으로 만든다 : 순서, 형식
             => 자신의 스타일을 찾는다
             => 컬럼명으로 구분이 가능 / 명령어 = 읽기, 쓰기 편리
             
         => 전체 데이터 읽기 => * (오라클에서 테이블에 저장된 순서)
            필요한 내용만 출력 => column1, column2...
            문법 사항
              1) 대소문 구분이 없다
                 (실제 저장된 데이터는 대소문자 구분)
              2) 오라클에서는 문장 종료 ; , 자바는 ; 사용 x 자동으로 입력됨 
              3) 키워드 : 대문자로 사용
              4) 일반 연산, 함수 확인 => dual(임시 테이블 이용)
         => 테이블 구조
            DESC emp
            DESC book
            DESC customer
                 orders JOIN, SUBQUERY => 정규화
            
            emp
            EMPNO    NOT NULL NUMBER(4)     사번 => 구분자 (정수) 
            ENAME    NOT NULL VARCHAR2(20)  이름
            JOB               VARCHAR2(20)  직위
            HIREDATE          DATE          입사일
            COMM              NUMBER(10,2)  성과금
            SAL               NUMBER(10,2)  급여
            DEPTNO            NUMBER(2)     부서번호
            
            book
            BOOKID    NOT NULL NUMBER(3)    책번호 => 구분자
            BOOKNAME           VARCHAR2(40) 책이름
            PUBLISHER          VARCHAR2(40) 출판사
            PRICE              NUMBER(8)    가격
            
            customer
            CUSTID  NOT NULL NUMBER(3)      회원번호
            NAME             VARCHAR2(40)   이름
            ADDRESS          VARCHAR2(50)   주소
            PHONE            VARCHAR2(20)   번호
*/

SELECT
    *
FROM
    emp
WHERE
    sal >= 3000000;

SELECT
    ename,
    hiredate,
    job,
    sal
FROM
    emp
WHERE
    sal >= 3000000;

SELECT
    *
FROM
    emp
WHERE
    job <> '사원';

SELECT
    *
FROM
    emp
WHERE
    hiredate < '21/01/01'; -- 비교연산자 => 날짜, 문자

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
    to_char(hiredate, 'YY') = 21;

SELECT
    *
FROM
    emp
WHERE
    substr(hiredate, 1, 2) = 21;

-- 6. 복합 => 부서번호가 10이거나, 직위가 과장
SELECT
    *
FROM
    emp
WHERE
    deptno = 10
    OR job = '과장';

-- 7. IN 연산자 => 같은 컬럼에서 찾는다 => 필터링(검색)
-- 안수빈, 문채린, 백유림
SELECT
    *
FROM
    emp
WHERE
    ename IN ( '안수빈', '문채린', '백유림' );

-- 8. NULL 처리 (연산처리가 안된다) => IS NULL, IS NOT NULL
-- 회원중에 전화가 없는 회원의 모든 정보
SELECT
    *
FROM
    customer
WHERE
    phone IS NULL;

-- 사원중에 성과급이 있는 사람
SELECT
    *
FROM
    emp
WHERE
    comm IS NOT NULL;

-- 9. 부정 => NOT
SELECT
    *
FROM
    emp
WHERE
    ename NOT IN ( '안수빈', '문채린', '백유림' );

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
    NOT ( deptno = 10
          OR job = '과장' );

-- 10. LIKE : 검색
-- 1) 강씨 성을 가진 모든 사원 정보
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '강%';

-- 2) 원으로 끝나는 사원의 정보
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%원';

-- 3) 채가 포함된 사원
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%채%';

-- 4) 두번째 글자 채인 사원 목록
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_채%';

--5) 세글자를 가진 사원의 정보
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '___';

/*
    1. 비교연산자 => 로그인 / 아디이 찾기 / 비밀번호 찾기 / 상세보기
    2. BETWEEN => 페이지 나누기
    3. IN => 검색 필터링
    4. LIKE => 검색 => %값%
*/
-- 1. 정렬 => 오라클은 정렬이 안되어 있다
/*
    ORDER BY => 버블정렬 => 속도가 늦다 (인덱스로 변경)
    
    사용법) ORDER BY 컬럼명 | 함수 ASC | DESC
                                 --- 생략이 가능
           컬럼의 위치를 이용할 수 있다
                    1     2    3     4
           SELECT ename empno job biredate
           FROM emp
           ORDER BY 1 => ename을 정렬 => ASC
           
           * => 오라클에 저장된 순서
           
           이중 정렬
           no   val
           1    A
           2    C
           4    D
           3    E
           1    B 
*/


/*
    단일행 함수
      1) 문자 함수
         = *****LENGTH / LENGTHB
                       | 문자의 Byte수
             | 문자의 갯수
         # LENGTH('ABC')
         # LENGTHB('ABC')
         # LENGTH(문자열, 컬럼명)
         = UPPER / LOWER / INITCAP
                             | 이니셜 (첫자만 대문자)
                               INITCAP(문자열|컬럼명)
                    | 소문자 LOWER(문자열|컬럼명)
             | 대문자 UPPER(문자열|컬럼명)
         = LPAD / *****RPAD (L(left), R(right))
           사용처 : ID 찾기, 비밀번호 찾기 (이메일 전송) => JavaMail
                   hong => ho**
           LPAD(문자열|컬럼명, 글자수, 변경할 문자)
           # LPAD('KING', 7, '*')
             ***KING
             LPAD('KING', 3, '*')
             KIN
         = REPLACE : 변경
           REPLACE(문자열|컬럼명, 찾는 문자, 변경 문자)
           # REPLACE('Hello Java', 'a', 'b')
               => Hello Jbvb
             REPLACE('Hello Java', 'Java', 'Oracle')
               => Hello Oracle
             사용처 => 크롤링시
                   이미지 : URL주소 => &, ||
         = TRIM() 지정된 문자 제거
           LTRIM() / RTRIM() / TRIM()
                                | 좌우 제거
                       | 오른쪽 제거
             | 왼쪽 제거
           LTRIM(문자열|컬럼명, 제거할 문자) 제거문자
           LTRIM(문자열|컬럼명) 공백
           RTRIM은 오른쪽 기능 똑같음
           TRIM(문자 FROM 문자열) => 좌우 제거
         = ASCII() / CHR()
                      | => 숫자를 문자 변경
             | => 문자를 숫자 변경
         ===> LENGTH / RPAD
         문자열 제어
         문자열 자르기 : SUBSTR()
         SUBSTR(문자열|컬럼명, 시작위치, 갯수)
         Hello Oracle
         123456789.... 인텍스번호 1번부터
         문자 위치 찾기 : INSTR() => 인덱스 번호를 구하는 경우
         INSTR(문자열|컬럼명, 찾는 문자, 시작 번호, 몇번째)
         INSTR('ABCDEFG', 'D', 1, 1)
         INSTR('ABCDEDG', 'D', 1, 2)
         문자열 결합 : CONCAT() ==> ||
         CONCAT(문자열, 문자열)
         CONCAT('Hello ','Oracle')
           Hello Oracle
         => LENGTH, SUBSTR, INSTR, RPAD, REPLACE 
      2) 숫자 함수
         MOD => % (나머지)
         ROUND => 반올림
         CEIL => 올림
         TRUNC() => 버림
         
      3) 날짜 함수
         ***SYSDATE : 시스템의 날짜 + 시간
         계산 => SYSDATE+1 / SYSDATE-1 => 자동 등록
         ***MONTH_BETWEEN : 년도 사이의 개월 수
         ADD_MONTH : 개월 추가 => 적금, 연금, 보험
         NEXT_DAY : 오늘이후 무슨요일이 얼마나 남았냐
         LAST_DAY : 이달의 마지막 날
      4) 변환 함수
         ***TO_CHAR : 날짜, 숫자 => 문자 변환
         TO_CHAR(날짜|숫자, 'FORMAT형식') yyyy년도, MM 월, DD 일, HH/HH24, MI 분, SS 초, 99,999
         TO_NUMBER : 문자를 => 숫자 변환
         ***TO_DATE : 문자 => 날짜 (예약)
      5) 기타 함수
         ***NVL : NULL을 다른 값 대체
         ***CASE : switch ~ case
         형식)
              CASE
               WHEN 조건 THEN 값
               WHEN 조건 THEN 값
               WHEN 조건 THEN 값
               WHEN 조건 THEN 값
               ELSE 값
              END 값
         DECODE : 다중 if
*/

SELECT
    length('ABC'),
    lengthb('ABC'),
    length('홍길동'),
    lengthb('홍길동')
FROM
    dual;

SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    ename,
    lpad(ename, 10, '*'),
    rpad(ename, 7, '*')
FROM
    emp;

SELECT
    ename,
    replace(ename, '김', '홍')
FROM
    emp
WHERE
    ename LIKE '김%';

SELECT
    ' Hello Oracle ',
    ltrim(' Hello Oracle '),
    rtrim(' Hello Oracle '),
    TRIM(' Hello Oracle ')
FROM
    dual;

SELECT
    'HHHHello Oracle',
    ltrim('HHHHello Oracle', 'H'),
    rtrim('Hello OracleHHH', 'H'),
    TRIM('H' FROM 'HHHHello OracleHHH')
FROM
    dual;

SELECT
    ascii('K'),
    CHR(68)
FROM
    dual;

SELECT
    ascii('A'),
    CHR(1)
FROM
    dual;

SELECT
    hiredate,
    substr(hiredate, 1, 2)
FROM
    emp;

SELECT
    hiredate,
    substr(hiredate, 4, 2)
FROM
    emp;

SELECT
    hiredate,
    substr(hiredate, 7, 2)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    substr(hiredate, 1, 2) = 22;

SELECT
    *
FROM
    emp
WHERE
    substr(hiredate, 4, 2) = 10;

SELECT
    'ABCDEDG',
    instr('ABCDEDG', 'D', 1, 1),
    instr('ABCDEDG', 'D', 1, 2)
FROM
    dual;

SELECT
    'ABCDEDG',
    instr('ABCDEDG', 'D', 1, 1),
    instr('ABCDEDG', 'D', -1, 1)
FROM
    dual;

/*
    A B C D E F G
    1 2 3 4 5 6 7
    -7-6-5-4-3-2-1 lastIndexOf -1
*/
SELECT
    concat('Hello ', 'Oracle')
FROM
    dual;

SELECT
    'Hello ' || 'Oracle'
FROM
    dual;
    
    
SELECT *
FROM emp
WHERE MOD(empno, 2) = 0;

SELECT ROUND(123.5678, 2), ROUND(123.5678, 3)
FROM dual;

SELECT TRUNC(123.5678, 2), TRUNC(123.5678, 3)
FROM dual;
-- 총페이지 계산
SELECT CEIL(1234.123)
FROM dual;

SELECT COUNT(*)
FROM book;

SELECT CEIL(COUNT(*)/10.0)
FROM book;

-- ROUND / MOD / CEIL / TRUNC
SELECT SYSDATE, SYSDATE-1, SYSDATE+1
FROM DUAL;

SELECT ename, hiredate, ROUND((MONTHS_BETWEEN(SYSDATE, hiredate))/12)
FROM emp;

-- ADD_MONTH => 개월 => 보험 / 적금 / 연금
SELECT ADD_MONTHS('26/10/12', 7)
FROM DUAL;

-- LAST_DAY => 입력 => 그달의 마지막
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- NEXT_DAY => 날짜, 요일
SELECT NEXT_DAY(SYSDATE, '목')
FROM DUAL;

SELECT ename, hiredate, sal,
       TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') AS "입사일",
       TO_CHAR(sal, 'L999,999,999') AS "급여"
FROM emp;

SELECT TO_NUMBER('10') -- Integer.parseInt("10")
FROM DUAL;

-- 묵시적 변환 '10' + '10' => 20
SELECT TO_CHAR(TO_DATE('26/11/25','YY/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

SELECT empno, ename, job, hiredate, sal, TO_CHAR(hiredate, 'DAY')
FROM emp;

SELECT ename, sal, comm, TO_CHAR(sal+NVL(comm,0), 'L99,999,999') "총급여"
FROM emp;

-- NVL null을 다른 값으로 대체한다
-- NVL(컬럼명, 값) => 값이 반드시 컬럼 데이터형과 일치
SELECT zipcode as "집 코드", sido as "시도", gugun as "구군", dong as "동", NVL(bunji, ' ') as "번지" 
FROM zipcode;

SELECT ename, sal, NVL(TO_CHAR(comm, 'L99,999,999'), '없음')
FROM emp;

DESC emp;

-- 별점 / 레이팅 => TRIGGER
-- CASE 다중조건문
SELECT ename, deptno,
       CASE
        WHEN deptno=10 THEN '영업부'
        WHEN deptno=20 THEN '개발부'
        WHEN deptno=30 THEN '자재부'
        WHEN deptno=40 THEN '총무부'
        WHEN deptno=50 THEN '기획부'
        ELSE '신입'
       END AS JOB
FROM emp;

-- DECODE => 선택문
SELECT ename, deptno, DECODE(deptno, 10, '영업부',
                                     20, '개발부',
                                     30, '자재부',
                                     40, '총무부',
                                     50, '기획부',
                                     '자제부') as job
FROM emp;


/*
    집계 함수 : 도메인 (컬럼단위) => 단일행 함수와 같이 사용이 안된다.
               만약에 필요한 경우는 반드시 GROUP BY 이용
    COUNT() => ROW의 갯수
        COUNT(컬럼) => NULL값을 제외
        COUNT(*) => NULL값을 포함
        로그인 / 아이디 중복 / 장바구니 / 검색 몇건 ...
    MAX / MIN => 최대값, 최소값
     | => 자동 증가 번호
    AVG => 평균
    SUM => 총합
    RANK => 순위
    = DENSE_RANK
        1 2 2 3 => 1 2 2 3
    = RANK
        1 2 2 3 => 1 2 2 4 
*/

-- 1. emp에 저장된 사원은 총 몇명 - NULL 값 포함
SELECT COUNT(*)
FROM emp;

-- 2. 커미션을 받는 사원 수 - NULL 값 제외
SELECT COUNT(comm)
FROM emp;

-- 3. 중복 없이 총 갯수
SELECT COUNT(DISTINCT deptno) 
FROM emp;

-- 3. 사원의 급여의 평균
SELECT AVG(sal)
FROM emp; 

-- 4. 월 지출되는 총 급여
SELECT SUM(sal)
FROM emp;

-- 5. 가장 작은 급여, 가장 큰 급여
SELECT MIN(sal), MAX(sal)
FROM emp;

-- 6. 급여 높은 순으로 순위를 출력
SELECT empno, ename, sal, hiredate, job, DENSE_RANK() OVER(ORDER BY sal DESC) AS rank
FROM emp;
    

    
    
    
    
    
    
    
    
    
    
