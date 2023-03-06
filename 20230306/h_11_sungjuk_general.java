package n_generic;
import java.util.*;		// generic 자료구조
import java.io.*;		// 파일

public class h_11_sungjuk_general {
	public static void main(String[] args) throws Exception {	// 예외처리
		Tables tb = new Tables();		// 클래스를 인스턴스
		int i=0;
		while (true) {
			i = tb.windowFor();			// 함수를 호출 (입출력)
			if (i == 0) {
				break;
			}
		}
	}
}
