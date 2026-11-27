<details>
  <summary><h2>데이터 조작어 - 검색</h2></summary>

### SELECT 문 문법

- 기본 문법
```sql
SELECT [ALL | DISTINCT] 속성이름(들)
FROM 테이블이름(들)
[WHERE 검색조건(들)]
[GROUP BY 속성이름]
[HAVING 검색조건(들)]
[ORDER BY 속성이름 [ASC | DESC]]
--------------------------------------------------
[] : 대괄호 안의 SQL 예약어들은 선택적으로 사용한다.
| : 선택 가능한 문법들 중 한 개를 사용할 수 있다.
```

#### WHERE 조건 검색

- 조건에 맞는 검색을 할 때는 WHERE 절을 사용한다.
- 조건으로 사용할 수 있는 술어는 비교, 범위, 집합, 패턴, NULL로 구분할 수 있다.

| 연산자 | 의미 | 예시 |
|:---:|---|---|
| `=` | 같다 | `WHERE deptno = 10` |
| `<>`, `!=`, `^=` | 같지 않다 | `WHERE deptno <> 10` |
| `>` | 크다 | `WHERE sal > 3000` |
| `<` | 작다 | `WHERE sal < 3000` |
| `>=` | 크거나 같다 | `WHERE sal >= 3000` |
| `<=` | 작거나 같다 | `WHERE sal <= 3000` |
| `ANY` / `SOME` | 목록·서브쿼리 결과 중 **하나라도** 만족하면 참 | `WHERE sal > ANY (1000, 2000)` |
| `ALL` | 목록·서브쿼리 결과를 **모두** 만족하면 참 | `WHERE sal > ALL (SELECT sal FROM emp WHERE deptno = 30)` |

- 예시 쿼리문
```sql
SELECT *
FROM emp
WHERE sal >= 4000000;
```

#### GROUP BY 검색, HAVING 절

- SQL 문에서 GROUP BY 절을 사용하면 같은 속성값끼리 그룹을 만들 수 있다.
- HAVING 절은 GROUP BY 절의 결과 나타나는 그룹을 제안하는 역할을 한다.

- GROUP BY 주의사항

| 항목 | 내용 |
|---|---|
| SELECT 절 제약 | SELECT에는 **GROUP BY에 있는 컬럼** 또는 **집계함수**만 쓸 수 있음 (위반 시 `ORA-00979`) |
| 별칭 사용 불가 | GROUP BY에는 SELECT 별칭을 쓸 수 없음 (원래 컬럼/표현식 사용) |
| 표현식 가능 | `GROUP BY TO_CHAR(hiredate, 'YYYY')`처럼 표현식 사용 가능 (SELECT의 표현식과 동일해야 함) |
| NULL 처리 | NULL 값도 하나의 그룹으로 묶임 |
| 집계함수와 NULL | `COUNT(컬럼)`, `SUM`, `AVG` 등은 NULL을 제외하고 계산 (`COUNT(*)`는 NULL 포함) |
| 정렬 보장 안 됨 | GROUP BY 결과의 순서는 보장되지 않으므로 필요하면 `ORDER BY` 명시 |
| 다중 컬럼 | 컬럼을 여러 개 쓰면 조합이 같은 행끼리 그룹화 |
| 확장 기능 | `ROLLUP`, `CUBE`, `GROUPING SETS`로 소계/총계 생성 가능 |

- HAVING 주의사항

| 항목 | 내용 |
|---|---|
| 용도 | 그룹 결과(집계값)에 대한 조건 지정 |
| 집계함수 사용 | HAVING에서는 집계함수 사용 가능 (`HAVING SUM(sal) > 5000`) |
| GROUP BY 없이 사용 | 가능하지만 테이블 전체가 하나의 그룹으로 처리됨 |
| 별칭 사용 불가 | SELECT 별칭을 HAVING에서 쓸 수 없음 |
| 작성 위치 | GROUP BY 앞뒤 어느 쪽에 써도 동작하지만 **GROUP BY 뒤에 쓰는 것이 관례** |

- 예시 쿼리문
```sql
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) >= 50000000;
```

#### 조인

- 여러 개의 테이블을 연결하여 하나의 테이블을 만드는 과정을 조인이라고 한다.
-------

1. INNER JOIN
- 두 테이블에서 조인 조건을 만족하는 행만 결합해 반환한다.
- JOIN만 써도 INNER JOIN으로 동작한다.
```sql
-- ANSI ON (권장)
SELECT e.ename, d.dname
FROM   emp e
INNER JOIN dept d ON e.deptno = d.deptno
WHERE  e.sal > 2000;

-- USING
SELECT ename, dname, deptno
FROM   emp INNER JOIN dept USING (deptno);

-- Oracle 전통 문법
SELECT e.ename, d.dname
FROM   emp e, dept d
WHERE  e.deptno = d.deptno;
```
--------
2. LEFT / RIGHT OUTER JOIN
- LEFT는 왼쪽 테이블의 모든 행 + 조건에 맞는 오른쪽 행 (없으면 NULL) 반환
- RIGHT는 오른쪽 테이블의 모든 행 + 조건에 맞는 왼쪽 행 (없으면 NULL) 반환
- OUTER 키워드는 생략 가능

```sql
-- 모든 부서를 출력 (사원이 없는 부서도 포함)
-- ANSI LEFT
SELECT d.dname, e.ename
FROM   dept d
LEFT OUTER JOIN emp e ON d.deptno = e.deptno;

-- ANSI RIGHT (위와 같은 결과)
SELECT d.dname, e.ename
FROM   emp e
RIGHT OUTER JOIN dept d ON d.deptno = e.deptno;

-- Oracle 전통 문법
SELECT d.dname, e.ename
FROM   dept d, emp e
WHERE  d.deptno = e.deptno(+);
```
</details>
