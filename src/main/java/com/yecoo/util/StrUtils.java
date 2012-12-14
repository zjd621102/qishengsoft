package com.yecoo.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class StrUtils {
	/**
	 * 写入日志
	 * @param classname
	 * @param obj
	 * @creadate 2012-3-31
	 */
	public static final void WriteLog(String classname, Object obj) {
		Logger logger = Logger.getLogger(classname);
		logger.error(obj);
	}
	/**
	 * 将sourceStr转换为指定长度输出，用‘0’补足
	 * @param sourceStr
	 * @param strLen
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String getLenStr(String sourceStr, int strLen) {
		String FullStr = "0000000000";
		String rstStr = "";
		rstStr = FullStr.substring(0, strLen - sourceStr.length()) + sourceStr;
		return rstStr;
	}
	/**
	 * NULL转为""
	 * @param sourceStr
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String nullToStr(String sourceStr) {
		if ((sourceStr == null) || sourceStr.equals("") || sourceStr.equals("null")) {
			sourceStr = "";
		}
		return sourceStr;
	}
	/**
	 * NULL转为""
	 * @param sourceStr1
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String nullToStr(Object sourceStr1) {
		String sourceStr = sourceStr1 + "";
		if ((sourceStr == null) || sourceStr.equals("") || sourceStr.equals("null")) {
			sourceStr = "";
		}
		return sourceStr;
	}
	/**
	 * 执行javascript操作,把内容显示到页面上
	 * @param response
	 * @param showContent
	 * @creadate 2012-3-31
	 */
	public static void printToPage(HttpServletResponse response, String showContent) {
		try {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().print(showContent);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 去除字符串line中的&nbsp;、全角空格、半角空格
	 * @param line
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String replaceBlank(String line) {
		String sResult = "";
		line = line.trim();
		for (int i = 0; i < line.length(); i++) {
			String str1 = line.substring(i, i + 1);
			byte[] hjl = str1.getBytes();
			if (hjl[0] != 63) { // 如果不是&nbsp;
				if (hjl.length == 2) { // 长度等于2说明是全角字符
					if (!(hjl[0] == -95 && hjl[1] == -95)) { // 如果不是全角空格
						sResult = sResult + str1; // 如果不是全角空格，则连接就可以了
					}
				} else if (hjl.length == 1) { // 说明是半角字符
					sResult = sResult + str1; // 直接连接就可以了
				}
			}
		}
		return sResult;
	}
	/**
	 * 去除字符串line中的数字、“.”、"-"以外的字符
	 * @param line
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String matchNumber(String line) {
		String sResult = "";
		line = line.trim();
		for (int i = 0; i < line.length(); i++) {
			String str1 = line.substring(i, i + 1);
			if (str1.equals("-") || str1.equals(".")) {
				sResult = sResult + str1;
			} else {
				byte[] hj = str1.getBytes();
				// 若字符为0到9的数字
				if ((hj[0] >= 48 && hj[0] <= 57)) {
					sResult = sResult + str1;
				}
			}
		}
		return sResult;
	}
	/**
	 * 将列表转换成以splitStr分隔的字符串
	 * @param list
	 * @param splitStr
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String listToStr(List<String> list, String splitStr) {
		String sFields = "";
		try {
			if (!list.isEmpty()) {
				sFields = (String) list.get(0);
				for (int i = 1; i < list.size(); i++) {
					sFields = sFields + splitStr + (String) list.get(i);
				}
			}
		} catch (Exception e) {
			sFields = "error";
			StrUtils.WriteLog("StrUtils.implode()", e);
		}
		return sFields;
	}
	/**
	 * 将数组转换成以splitStr分隔的字符串
	 * @param str
	 * @param splitStr
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String ArrayToStr(String[] str, String splitStr) {
		String sFields = "";
		try {
			if (str != null) {
				for (int i = 0; i < str.length; i++) {
					if (!"".equals(StrUtils.nullToStr(str[i]))) {
						sFields += splitStr + StrUtils.nullToStr(str[i]);
					}
				}
				if (!sFields.equals("")) {
					sFields = sFields.substring(splitStr.length());
				}
			}

		} catch (Exception e) {
			StrUtils.WriteLog("StrUtils.implode()", e);
		}
		return sFields;

	}
	/**
	 * 将list转换成string[]
	 * @param list
	 * @return string[]
	 */
	public static String[] listToStrs(List<Object> list) {
		String[] sArr = new String[list.size()];
		try {
			for (int i = 0; i < list.size(); i++) {
				sArr[i] = (String) list.get(i);
			}
		} catch (Exception e) {
			StrUtils.WriteLog("StrUtils.listToStr()", e);
		}
		return sArr;
	}
	/**
	 * 将字符串分割成字符串数组
	 * @param str 被分割字符串
	 * @param div 分割字符串
	 * @return 字符串数组
	 */
	public static String[] strToArray(String str, String div) {
		ArrayList<String> array = new ArrayList<String>();
		StringTokenizer fenxi = new StringTokenizer(str, div);
		while (fenxi.hasMoreTokens()) {
			String s1 = fenxi.nextToken();
			array.add(s1);
		}
		String[] result = new String[array.size()];
		for (int i = 0; i < result.length; i++)
			result[i] = (String) array.get(i);
		return result;
	}
	/**
	 * 根据random()与字典字符串产生随机字符串
	 * @param length 字串长度
	 * @return 随机字符串
	 */
	// 定义私有变量
	private static Random randGen = null;

	private static char[] numbersAndLetters = null;

	private static Object initLock = new Object();

	public static final String randomString(int length) {
		if (length < 1) {
			return null;
		}
		if (randGen == null) {
			synchronized (initLock) {
				if (randGen == null) {
					randGen = new Random();
					numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
						.toCharArray();
				}
			}
		}
		char[] randBuffer = new char[length];
		for (int i = 0; i < length; i++) {
			randBuffer[i] = numbersAndLetters[randGen.nextInt(71)];
		}
		return new String(randBuffer);
	}
	/**
	 * 封装SQL，获取分页SQL
	 * @param sSQL
	 * @param iCurrentPage 当前页
	 * @param iPageSize 每页数
	 * @return String
	 * @creadate 2012-3-31
	 */
	public static String getMultiPageSQL(String sSQL, int iCurrentPage, int iPageSize) {
		String sReturn = "";
		try {
			sReturn = "SELECT * FROM ("
					+ "SELECT ROWNUM AS FTEMP_INDEX,TEMP_TABLE_A.* FROM " + "("
					+ sSQL + ") TEMP_TABLE_A " + "WHERE ROWNUM<=" + iCurrentPage
					* iPageSize + ") TEMP_TABLE_B "
					+ "WHERE TEMP_TABLE_B.FTEMP_INDEX>" + (iCurrentPage - 1)
					* iPageSize;
		} catch (Exception e) {
			StrUtils.WriteLog("StrUtils.getMultiPageSQL()", e);
		} finally {

		}
		return sReturn;
	}
	/**
	 * 判断是否是字符是否数值型函数
	 * @param str 字符
	 * @return boolean
	 */
	public static boolean CheckFloat(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (Exception ex) {
			return false;
		}
	}
	/**
	 * 编码
	 * @param value
	 * @return String
	 * @creadate 2012-3-22
	 */
	public static String encode(String value) {
		String sReturn = "";
		try {
			if (value == null) {
				return sReturn;
			}
			sReturn = java.net.URLEncoder.encode(value, "UTF-8");
		} catch (Exception e) {
			StrUtils.WriteLog("StrUtils.encode()", e);
		}
		return sReturn;
	}
	/**
	 * 解码
	 * @param value
	 * @return String
	 * @creadate 2012-3-22
	 */
	public static String decode(String value) {
		String sReturn = "";
		try {
			if (value == null)
				return sReturn;
			sReturn = java.net.URLDecoder.decode(value, "UTF-8");
		} catch (Exception e) {
			StrUtils.WriteLog("StrUtils.encode()", e);
		}
		return sReturn;
	}
	/**
	 * XML字符转义
	 * @param str
	 * @return String
	 */
	public static String changeStrXML(String str) {
		str = nullToStr(str);
		str = str.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(
			"&", "&amp;").replaceAll("'", "&apos;").replaceAll("\"", "&quot;");
		return str;
	}
	/**
	 * 取得服务配置信息
	 * @return Properties
	 * @creadate 2012-3-31
	 */
	public static Properties getServerProperties() {
		Properties osPro = System.getProperties();
		String UserDir = "";
		InputStream is = null;
		try {
			// 获取当前用户的工作目录
			UserDir = osPro.getProperty("user.dir");
			is = new FileInputStream(UserDir + "/project_server.ini");
			osPro.load(is);
			is.close();
		} catch (Exception e) {
			StrUtils.WriteLog("StrUtils.getServerProperties()", e);
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception ignore) {
				}
			}
		}
		return osPro;
	}
	/**
	 * 字符串类型转Date类型
	 * @param date_str
	 * @return Date "yyyy-MM-dd"
	 * @creadate 2012-3-31
	 */
	public static Date strToDate(String date_str) {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			ParsePosition pos = new ParsePosition(0);
			java.util.Date current = formatter.parse(date_str, pos);
			return current;
		} catch (NullPointerException e) {
			return null;
		}
	}
	/**
	 * 日期格式化，返回字符串类型
	 * @param date
	 * @return String "yyyy-MM-dd"
	 * @creadate 2012-3-31
	 */
	public static String DateToStr(java.util.Date date) {
		try {
			return (new SimpleDateFormat("yyyy-MM-dd")).format(date);
		} catch (NullPointerException e) {
			return null;
		}
	}
	/**
	 * 获取当前时间
	 * @return String
	 * @creadate 2012-3-22
	 */
	public static String getSysdate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(new Date());
	}
	/**
	 * 获取当前时间
	 * @param format 日期格式
	 * @return String
	 * @creadate 2012-3-22
	 */
	public static String getSysdate(String format) {
		if("".equals(nullToStr(format))) {
			format = "yyyy-MM-dd";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date());
	}
}