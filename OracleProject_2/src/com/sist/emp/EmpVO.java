package com.sist.emp;

import java.util.Date;

import lombok.Data;

/*
 * 	EMPNO    NOT NULL NUMBER(4)    
	ENAME    NOT NULL VARCHAR2(20) 
	JOB               VARCHAR2(20) 
	HIREDATE          DATE         
	COMM              NUMBER(10,2) 
	SAL               NUMBER(10,2) 
	DEPTNO            NUMBER(2)   
 */
@Data
public class EmpVO {
	
	private int empno, comm, sal, deptno;
	private String ename, job;
	private Date hiredate;

}
