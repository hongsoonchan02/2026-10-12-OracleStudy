package com.sist.jdbc;

import java.util.Date;

import lombok.Data;

@Data
public class EmpVO {
	
	private int empno;
	private String ename;
	private Date hiredate;
	private String job;
	private int sal;
	private int comm;
	private int deptno;
}
