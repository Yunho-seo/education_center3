package com.mariadb.sungjuk;

public class SungjukDTO {
	private int bunho;
	private String name;
	private int kor;
	private int mat;
	private int eng;
	private int total;
	private float average;
	private String grade;
	private String schoolcode;
	private String chname;
	
	public SungjukDTO() {
		
	}
	// 배열 생성 시 에러가 발생하기 때문에 생성자 오버로딩을 하면 반드시 명시적으로 디폴트 생성자를 만들어야 한다.
	public SungjukDTO(int bunho, String name, int kor, int mat, int eng, 
			int total, float average, String grade, String schoolcode) {
		this.bunho = bunho;
		this.name = name;
		this.kor = kor;
		this.mat = mat;
		this.eng = eng;
		this.total = total;
		this.average = average;
		this.grade = grade;
		this.schoolcode = schoolcode;
	}
	
	public SungjukDTO(int bunho, String name, int kor, int mat, int eng, 
			String schoolcode) {
		this.bunho = bunho;
		this.name = name;
		this.kor = kor;
		this.mat = mat;
		this.eng = eng;
		this.schoolcode = schoolcode;
	}
	
	public String toString() {
		return "이름: " + name + " 국어: " + kor + " 수학: " + mat + " 영어: " + eng;
	}
	
	public int getBunho() {
		return bunho;
	}
	public void setBunho(int bunho) {
		this.bunho = bunho;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getMat() {
		return mat;
	}
	public void setMat(int mat) {
		this.mat = mat;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public float getAverage() {
		return average;
	}
	public void setAverage(float average) {
		this.average = average;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getSchoolcode() {
		return schoolcode;
	}
	public void setSchoolcode(String schoolcode) {
		this.schoolcode = schoolcode;
	}
	public String getChname() {
		return chname;
	}
	public void setChname(String chname) {
		this.chname = chname;
	}
	
	
}
