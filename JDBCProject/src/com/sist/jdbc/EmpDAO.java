package com.sist.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/*
 *   1. ~VO : 데이터베이스 테이블 매칭 => 데이터형
 *   2. ~DAO : 데이터베이스 연결
 *   3. ~Manager : 외부 라이브러리 = Jsoup, OPEN API
 *   4. ~Service : 윈도우 / 브라우저 전송
 */
public class EmpDAO {

	private Connection conn; // 오라클 연결 => Socket
	private PreparedStatement ps; // BufferedReader / OutputStream
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	// 1. 드라이버 설정
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
			e.printStackTrace();
		}
	}
	// 3. 오라클 닫기
	public void disConnection() {
		
		try {
			if(ps != null) {
				ps.close(); // in.close(), out.close()
			}
			if(conn != null) {
				conn.close(); // socket.close()
			}
			// => exit
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	// 4. SQL 전송 => 결과값 받기
	public List<EmpVO> empListData() {
		
		List<EmpVO> list = new ArrayList<EmpVO>();
		
		try {
			// 연결
			getConnection();
			// 요청 ==> SQL
			String sql = "SELECT empno, ename, job, sal FROM emp";
			ps = conn.prepareStatement(sql); // out.write
			// 값 저장
			ResultSet rs = ps.executeQuery(); // in.readLine()
			
			while(rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setSal(rs.getInt(4));
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
}
