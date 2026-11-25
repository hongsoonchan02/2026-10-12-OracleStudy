package com.sist.book;

import lombok.Data;

/*
 * CUSTID  NOT NULL NUMBER(3)    
   NAME             VARCHAR2(40) 
   ADDRESS          VARCHAR2(50) 
   PHONE            VARCHAR2(20)
   
   오라클 데이터형
   CHAR / VARCHAR2 / CLOB => String
   NUMBER = int / double
   DATE => java.util.Date
   TIMESTAMP => LocalDateTime
   ------------------------------
   BLOB => InputStream
   BFILE => InputStream
 */
@Data
public class CustomerVO {

	private int custId;
	private String name;
	private String address;
	private String phone;
}
