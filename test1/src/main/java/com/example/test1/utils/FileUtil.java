package com.example.test1.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class FileUtil {

    // 파일 이름 생성 메서드
    public static String generateFileName() {
        // 현재 시간을 기반으로 파일 이름 생성
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = dateFormat.format(new Date());

        // 랜덤한 문자열을 추가하여 중복을 방지하는 파일 이름 생성
        String randomString = UUID.randomUUID().toString().replace("-", "");

        // 최종 파일 이름 생성
        String fileName = "file_" + timestamp + "_" + randomString;

        return fileName;
    }
}
