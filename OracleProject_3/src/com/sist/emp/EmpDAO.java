package com.sist.emp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// 오라클과 연결 => 송수신 (요청 => 결과값)
public class EmpDAO {
	// 연결 객체
	private Connection conn;
	// 송수신 객체
	private PreparedStatement ps;
	// URL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	// 메모리 한개 사용 => 메모리 정략 / 일관성 => 싱글턴 방식
	private static EmpDAO dao;
	
	// 1. 드라이버 등록
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	// 2. 오라클 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "hr", "happy");
		} catch(Exception e) {
			
		}
	}
	// 3. 오라클 닫기
	public void disConnection() {
		try {
			if(ps != null) ps.close();
			if(conn != null) conn.close();
		} catch(Exception e) {
			
		}
	}
	// 4. 싱글턴 패턴
	public static EmpDAO getInstance() {
		
		if(dao == null) {
			dao = new EmpDAO();
		}
		return dao;
	}
	// -------------------------- 모든 DAO의 공통 사항
	// DAO는 테이블당 한개씩 만든다 => 재사용  
	// 5. 기능 => EmpVO : 사원 한명
	public List<EmpVO> empListData(int page) {
		
		List<EmpVO> list = new ArrayList<EmpVO>();
		
		try {
			// 1. 연결
			getConnection();
			// 2. 오라클로 전송할 SQL문장
			String sql = "SELECT empno, ename, job, hiredate, sal"
					+ " FROM emp"
					+ " ORDER BY empno ASC"
					+ " OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
			// 오라클로 SQL문장 전송
			ps = conn.prepareStatement(sql); // 미리 문장을 보낸다
			int start = (page * 10) - 10;
			ps.setInt(1,  start);
			// ? 에 값을 채운다 => SQL Injection
			// 실행 요청 후에 결과값 받기
			ResultSet rs = ps.executeQuery();
			// => List에 이동
			while(rs.next()) {
				
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
				
				// 통째로 => List에 저장
				list.add(vo);
				
			}
			
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	
	// 총 페이지 구하기
	public int empTotalPage() {
		
		int total = 0;
		
		try {
			// 1. 연결
			getConnection();
			// 2. SQL 문장
			String sql = "SELECT CEIL(COUNT(*)/10.0) FROM emp";
			
			ps = conn.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			
			total = rs.getInt(1);
			
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return total;
	}
	
	// LIKE
	public List<EmpVO> empFindData(String name) {
		
		List<EmpVO> list = new ArrayList<EmpVO>();
		
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장
			String sql = "SELECT empno, ename, job, hiredate, sal"
					+ " FROM emp"
					+ " WHERE ename LIKE '%'||?||'%'";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1,  name);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
				
				// 통째로 => List에 저장
				list.add(vo);
			}
			rs.close();
			
		} catch(Exception e) {
			
		} finally {
			disConnection();
		}
		return list; 
	}

}
