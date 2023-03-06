package n_generic;
import java.util.*;
import java.io.*;
public class Tables {
	ArrayList<Student60> list = new ArrayList<Student60>();		// 자료구조 선언 (개수를 지정하지 않아도 된다)
	Scanner in = new Scanner(System.in);
	Iterator<Student60> itr;
	
	// CRUD
	// Student60 st1 = new Student60();				// 마지막에 입력한 데이터로 입력(함수 밖에서 선언시 값이 전부 같아짐)
	// 생성
	public void inputInfo() throws IOException {	// 1인분의 데이터 채우기
		Student60 st1 = new Student60();			// Stack에 변수가 만들어지고 = Heap 영역에 데이터 저장
		boolean re = false;							// while문을 참으로 실행하기 위해 false로 선언
		System.out.print("이름을 입력하세요: ");
		st1.name = in.nextLine();
		System.out.print("반을 입력하세요: ");
		st1.ban = Integer.parseInt(in.nextLine());
		
		System.out.print("번호를 입력하세요: ");
		st1.no = Integer.parseInt(in.nextLine());	// 버퍼에 엔터(Enter)가 남는 것을 방지
		
		// 점수 중 숫자가 아니거나, 범위를 벗어나서 입력한 경우 예외 처리 (while문, do while문 중첩사용)
		while (!re) {	// re가 참(T)인 경우, 참일 때 while문이 작동
			re = true;
			do {
				try {
					System.out.println("국어 점수를 입력하세요(0~100): ");
					st1.kor = Integer.parseInt(in.nextLine());
				} catch (NumberFormatException e) {
					System.out.println("숫자로 입력하세요");
					re = false;
				}
			} while (st1.kor < 0 || st1.kor > 100);		// OR 연산자 
		}
		
		System.out.print("수학 점수를 입력하세요: ");
		st1.math = Integer.parseInt(in.nextLine());
		System.out.print("영어 점수를 입력하세요: ");
		st1.eng = Integer.parseInt(in.nextLine());
		st1.total = (st1.kor + st1.math + st1.eng);
		list.add(st1);		// ArrayList에 1명 추가
	}
	
	// 출력
	public void display() {
		System.out.println("**** 입력된 값들을 출력 ****");
		System.out.println("======================");
		itr = list.iterator();						// 위치를 가리키는 반복자 (iterator : 데이터의 최선두를 가리킴)
		while (itr.hasNext()) {
			Student60 s = (Student60) itr.next();	// 캐스팅이 필요함
			System.out.println(s);					// toString()을 오버라이딩했기에 문자열을 출력
		}
	}
	
	// 삭제
	public void delete() throws IOException {
		System.out.print("** 삭제하려는 이름을 입력하세요 : ");
		String inputValue = in.nextLine();
		itr = list.iterator();
		while (itr.hasNext()) {
			Student60 s = (Student60) itr.next();
			if (s.name.equals(inputValue)) {
				itr.remove();
			}
		}
		System.out.println("** 삭제 완료 **");
	}
	
	// 수정
	// 여러 학생을 다루기 위한 기능을 기능별로 함수화(CRUD와 처리에 대한 함수들)
	public void edit() throws IOException {
		System.out.print("** 수정하려는 이름을 입력하세요: ");
		String inputValue = in.nextLine();
		itr = list.iterator();		// 반복자 초기화
		while (itr.hasNext()) {
			Student60 s = (Student60) itr.next();
			if(s.name.equals(inputValue)) {
				System.out.print("** 수정할 이름을 입력하세요: ");
				String ChangeValue = in.nextLine();
				s.setName(ChangeValue);		// 이름 수정
			}
		}
		System.out.println("** 수정 완료 **");
	}
	
	// 검색 후 출력
	// 삭제, 수정, 검색 기능별로 함수를 작성 : 설계 -> 구현 -> 호출
	public void searchAndShow() {
		System.out.print("** 검색하려는 이름을 입력하세요: ");
		String inputValue = in.nextLine();
		itr = list.iterator();
		while (itr.hasNext()) {
			Student60 s = (Student60) itr.next();
			if (s.name.equals(inputValue)) {
				System.out.println(s);
				break;
			}
		}
	}
	
	// 정렬
	// Collections / Map
	// Collections => list(ArrayList, LinkedList, Stack), queue, set(HashedSet, TreeSet)
	// Map : HashMap, TreeMap
	public void sort() throws IOException {
		Collections.sort(list);		// 상속관계에 있는 상위 부모인 Collections의 함수 사용
		display();
	}
	
	// 파일 저장, 로딩
	public void objectDataWrite() {
		try {
			FileOutputStream fos = new FileOutputStream("sungjuk");		// 바이트 단위 처리
			ObjectOutputStream oos = new ObjectOutputStream(fos);		// 객체 단위로 처리하는 클래스
			oos.writeObject(list);
			oos.close();
			fos.close();	// 반드시 close() 해주어야 함
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	public void objectDataRead() {
		try {
			FileInputStream fis = new FileInputStream("sungjuk");
			ObjectInputStream ois = new ObjectInputStream(fis);
			list = (ArrayList) ois.readObject();
			ois.close();
			fis.close();
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
			return;
		}
		catch (ClassNotFoundException c) {
			System.out.println("클래스를 찾을 수 없습니다.");
			c.printStackTrace();
			return;
		}
	}
	
	public int windowFor() throws IOException {
		System.out.println("====== 성적 관리 시스템 ======");
		System.out.println("------------------------");
		System.out.println("입력[1], 출력[2], 편집[3], 조회[4], 정렬[5], 삭제[6], 저장[7], 로딩[8], 종료[9]");
		System.out.println("------------------------");
		System.out.print("메뉴를 선택하세요: ");
		int ch = 0;
		try {
			ch = Integer.parseInt(in.nextLine());
		} catch (NumberFormatException e) {
		}
		switch(ch) {
		case 1:
			inputInfo();
			return 1;
		case 2:
			display();
			return 1;
		case 3:
			edit();
			return 1;
		case 4:
			searchAndShow();
			return 1;
		case 5:
			sort();
			return 1;
		case 6:
			delete();
			return 1;
		case 7:
			objectDataWrite();
			return 1;
		case 8:
			objectDataRead();
			return 1;
		case 9:
			System.out.println("프로그램을 종료합니다.");
			in.close();
			return 0;		// 0이면 종료 (main()에서 break;)
		default:
			System.out.println("잘못된 입력입니다.");
			return 1;
		}
	}
}
