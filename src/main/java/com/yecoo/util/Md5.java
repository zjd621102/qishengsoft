package com.yecoo.util;

import java.security.*;

public class Md5 {
	public String md5(String plainText) {
		
		StringBuffer buf = new StringBuffer("");
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes());
			byte b[] = md.digest();
			int i;
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
//			System.out.println("result: " + buf.toString());// 32位的加密
//			System.out.println("result: " + buf.toString().substring(8, 24));// 16位的加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return buf.toString();
	}

	public static void main(String[] args) {
		Md5 md5 = new Md5();
		System.out.println(md5.md5("888888"));
	}
}