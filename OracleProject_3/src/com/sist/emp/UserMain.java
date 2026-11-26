package com.sist.emp;

import java.util.List;
import java.util.Scanner;

public class UserMain {
	
	public static void main(String[] args) {
		
		Scanner scan = new Scanner(System.in);
		// 오라클 연결
		EmpDAO dao = EmpDAO.getInstance();
		
		while(true) {
			System.out.println("=============== Menu ===============");
			System.out.println("1. 사원 목록");
			System.out.println("2. 사원 검색");
			System.out.println("9. 종료");
			System.out.println("====================================");
			System.out.print("메뉴 입력 : ");
			int menu = scan.nextInt();
			
			if(menu == 9) {
				System.out.println("프로그램 종료");
				break;
			} else if(menu == 1) {
				int total = dao.empTotalPage();
				System.out.print("페이지 입력(1 ~ " + total +  ") : ");
				int page = scan.nextInt();
				List<EmpVO> list= dao.empListData(page);
				
				for(EmpVO vo : list) {
					System.out.println(vo.getEmpno() + " "
							+ vo.getEname() + " "
							+ vo.getJob() + " "
							+ vo.getHiredate().toString() + " "
							+ vo.getSal());
				}
			} else if(menu == 2) {
				System.out.print("이름 입력 : ");
				String name = scan.next();
				List<EmpVO> list = dao.empFindData(name);
				
				for(EmpVO vo : list) {
					System.out.println(vo.getEmpno() + " "
							+ vo.getEname() + " "
							+ vo.getJob() + " "
							+ vo.getHiredate().toString() + " "
							+ vo.getSal());
				}
			}
		}
	}

}
