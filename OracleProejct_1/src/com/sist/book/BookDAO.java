package com.sist.book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

// 테이블당 한개 생성 = 필요시에 재사용
/*
 *     자바 =======> 오라클 (자바 = txt)
 *           SQL
 *     자바 ======= 브라우저 (자바 = txt)
 *          HTML
 *     자바 ======= 자바스크립트
 *          JSON
 *     ----------------------------------+ 웹 사이트
 *     
 *     GIT ====== AWS (우분투)
 *          우분투 명령어(CI / CD)
 *     
 *     => Spring-Boot / MyBatis (JPA) / Oracle (MySQL)
 *     => GIT (Branch), Git Action, Pull Request
 *     	  => 명령어 이용
 *     => Docker / 쿠버네티스 / 젠킨스
 *     --------------------------------------------------
 *     => Spring AI / 파이썬 / LLM
 *     => React / Next
 *     
 *     1. 오라클 연동
 *     = 드라이버 등록 => 한번만 수행 => 생성자
 *     = 오라클 연결 => URL / UserName / Password
 *     = SQL 문장 전송 => SQL문장 작성 가능
 *     = 실행 결과값 받기 => 레코드 => 한줄씩 => ~VO
 *     2. 브라우저 / JavaScript / 자바 자체 처리
 *     
 *     Connection : 오라클 연결
 *       getConnection()
 *     PreparedStatement : SQL문장을 보내고 실행 결과 받기
 *       prepareStatement() : SQL문장으로 오라클 전송
 *       executeQuery() : 실행후에 결과값 읽기
 *     ResultSet : 오라클에 가지고 온 데이터가 저장
 *       커서의 위치 변경
 *          next() => 처음부터 => 밑으로 내려가면서 데이터 읽기
 *          prevous() => 밑에서부터 위로 올라온다
 *          데이터 읽을때
 *            getInt() / getDouble() / getString() / getDate()
 *       
 *       => rs.close()
 *          ps.close()
 *          conn.close()
 */

// 웹 => VO / DAT => 80%
public class BookDAO {
	
	// 연결 객체
	private Connection conn;
	//SQL 송신 / 수신
	private PreparedStatement ps;
	// URL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	// 1. 드라이버 등록
	public BookDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 2. 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "hr", "happy");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 3. 닫기
	public void disConnection() {
		try {
			if(ps != null) {
				ps.close();
			}
			if(conn != null) {
				conn.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 기능
	public void bookAllData() {
		try {
			// 1. 연결
			getConnection();
			// 2. 오라클로 보낼 SQL 문장
			String sql = "SELECT * FROM book";
			ps = conn.prepareStatement(sql,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY); // SQL로 전송 메소드
			// 3. 결과값을 받는다
			ResultSet rs = ps.executeQuery();
			rs.last();
			// ResultSet => 결과값을 저장하는 메모리 공간
			do {
				System.out.println(
						rs.getInt("bookId") + " "
						+ rs.getString("bookName") + " "
						+ rs.getString("publisher") + " "
						+ rs.getInt("price")
						);
			} while(rs.previous());
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disConnection(); // 무조건 닫기
		}
	}
	
	public void find() {
		
		Scanner scan = new Scanner(System.in);
		System.out.print("책 제목 : ");
		String name = scan.next();
		try {
			getConnection();
			String sql = "SELECT bookname, publisher FROM book WHERE bookname LIKE '%' || ? || '%'";
			ps = conn.prepareStatement(sql);
			// ? 에 값을 채운다
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println(rs.getString(1) + " "
						+ rs.getString(2));
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	
	public static void main(String[] args) {
		BookDAO dao = new BookDAO();
//		dao.bookAllData();
		dao.find();
	}
	
	

}
