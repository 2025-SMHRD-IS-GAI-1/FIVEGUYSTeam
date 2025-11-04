package com.pro.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtils {

    /**
     * 비밀번호와 사용자 ID(Salt 역할)를 조합하여 SHA-512 해시를 생성합니다.
     *
     * @param password 원본 비밀번호
     * @param userId   Salt 역할을 할 사용자 ID
     * @return 16진수 문자열로 변환된 해시
     */
    public static String hashPassword(String password, String userId) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            
            // 1. Salt(userId)를 먼저 해시에 추가
            md.update(userId.getBytes(StandardCharsets.UTF_8));
            
            // 2. 그다음 비밀번호를 해시
            byte[] hashBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
            
            // 3. 16진수 문자열로 변환하여 반환
            return bytesToHex(hashBytes);
            
        } catch (NoSuchAlgorithmException e) {
            // SHA-512는 거의 모든 JVM에 존재하므로 이 예외는 거의 발생 안 함
            throw new RuntimeException("SHA-512 알고리즘을 찾을 수 없습니다.", e);
        }
    }

    /**
     * 바이트 배열을 16진수 문자열로 변환합니다.
     */
    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}