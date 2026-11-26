package com.sist.emp;

import java.util.Date;

import lombok.Data;
/*
 *    오라클 데이터형           자바 데이터형
 *    NUMBER(4)
 *    NUMBER(8, 2)
 *    --------------------> 결과값 : 정수면 => int, 실수 => double
 *    CHAR
 *    VARCHAR2
 *    CLOB
 *    --------------------> String
 *    DATE
 *    TIMESTAMP
 *    --------------------> java.util.Date
 */
@Data
public class EmpVO {

	private int empno, comm, sal, deptno;
	private String ename, job;
	private Date hiredate;
}
