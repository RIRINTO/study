package common;

import java.util.regex.Pattern;

public class RegExClass {
	// 5~20자의 영문 소문자, 숫자와 특수기호 _ , - 만 사용 가능합니다.
		public static boolean checkUser_id(String user_id) {
			String patternUId = "^[a-zA-Z0-9_,-]{5,20}$";
			return Pattern.matches(patternUId, user_id);
		}

		// 8~20자 영문 대 소문자, 숫자, 특수문자를 사용하세요.
		public static boolean checkUser_pw(String user_pw) {
			String patternUPw = "\\S{8,20}$";
			return Pattern.matches(patternUPw, user_pw);
		}

		// 2~17자 한글만 사용가능합니다. (특수기호, 공백 사용 불가)
		public static boolean checkUser_name(String user_name) {
			String patternUName = "[가-힣]{2,17}";
			return Pattern.matches(patternUName, user_name);
		}
}
