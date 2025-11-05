package com.pro.utils;

import java.security.SecureRandom;

public class SecureRandomString {
	public String makeString(int stringLength) {
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
		StringBuilder sb = new StringBuilder();
		SecureRandom secureRandom = new SecureRandom();
		for (int i = 0; i < stringLength; i++) {
			int index = secureRandom.nextInt(characters.length());
			sb.append(characters.charAt(index));
		}
		return sb.toString();
	}
}