package n_generic;

// 비교와 저장을 위하여 interface를 구현 (implements)
import java.util.*;
import java.io.*;
public class Student60 implements Comparator<Student60>, Comparable<Student60>, Serializable {
	// 데이터를 결정
	String name = "";
	int ban;
	int no;
	int kor;
	int math;
	int eng;
	int total;

	public Student60() {
		
	}
	
	public Student60(String name, int ban, int no, int kor, int math, int eng) {
		this.name = name;
		this.ban = ban;
		this.no = no;
		this.kor = kor;
		this.math = math;
		this.eng = eng;
		total = kor + math + eng;
	}
	
	// 데이터를 처리 (get/set)
	public void setName(String name) {
		this.name = name;
	}
	
	// 데이터를 출력
	public void showtitle() {
		System.out.println("이름" + "\t" + "반" + "\t" + "번호" + "\t" + "국어" + "\t" + 
												"수학" + "\t" + "영어" + "\t" + "합계");
	}
	
	public String toString() {		// Object를 통해 상속받아 오버라이딩하고 있음
		return name + "\t" + ban + "\t" + no + "\t" + kor + "\t" 
								 + math + "\t" + eng + "\t" + total; 
	}
	
	// 비교, 인터페이스를 오버라이딩
	public int compareTo(Student60 sampleStu1) {	// 문자열을 비교
		return name.compareTo(sampleStu1.name);
	}
	
	public int compare(Student60 sampleStu1, Student60 sampleStu2) {	// 숫자를 비교
		return sampleStu2.total - sampleStu1.total;
	}
}
