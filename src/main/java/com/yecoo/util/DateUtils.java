package com.yecoo.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

public class DateUtils {

	static final String DATEPATTERN = "yyyy-MM-dd HH:mm:ss";
	static final SimpleDateFormat SF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	long nowtime = System.currentTimeMillis();

	/**
	 * 以当前系统时间构造DateTime对象
	 */
	public DateUtils() {

	}

	/**
	 * 以指定时间构造DateTime对象,如果指定的时间不符合格式，将使用 系统当前时间构造对象
	 * 
	 * @param String
	 *            time 时间格式为yyyy-MM-dd HH:mm:ss的字符串
	 */
	public DateUtils(String time) {
		this(time, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 以指定时间和指定时间格式构造DateTime对象. 如果指定的时间不符合格式，将使用系统当前时间构造对象
	 * 
	 * @param String
	 *            time 指定的时间
	 * @param String
	 *            timePattern 指定的日间格式
	 */
	public DateUtils(String time, String timePattern) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(timePattern);
			Date d = sdf.parse(time);
			nowtime = d.getTime();
		} catch (Exception e) {
			nowtime = System.currentTimeMillis();
		}
	}

	/**
	 * 取回系统当前时间 时间格式yyyy-MM-dd hh:mm:ss
	 * 
	 * @return String yyyy-MM-dd hh:mm:ss格式的时间字符串
	 */

	public String getNowTime() {
		String retValue = null;
		retValue = SF.format(new Date(nowtime));
		return retValue;
	}

	/**
	 * 按指定日期、时间格式返回当前日期
	 * 
	 * @param String
	 *            datePattern 格式字符串
	 * @return String 格式化的日期、时间字符串
	 */
	public String getNowTime(String datePattern) {
		String retValue = null;
		SimpleDateFormat sf = new SimpleDateFormat(datePattern);
		retValue = sf.format(new Date(nowtime));
		return retValue;
	}

	/**
	 * 返回4位的年份,如'2004'
	 * 
	 * @return String 返回4位的年份
	 */
	public String getYear() {
		return getNowTime("yyyy");
	}

	/**
	 * 返回月份. 一位的月份数字，如8月将返回8
	 * 
	 * @return String 月份 如果8月返回8，12月返回12
	 */
	public String getMonth() {
		return getNowTime("M");
	}

	/**
	 * 返回一个月中的第几天
	 * 
	 * @return String 天 一位的天数，如当前是4月1日将返回'1'
	 */
	public String getDay() {
		return getNowTime("d");
	}

	/**
	 * 返回24小时制的小时
	 * 
	 * @return String 小时
	 */
	public String getHour() {
		return getNowTime("HH");
	}

	/**
	 * 返回分钟
	 * 
	 * @return String 分钟 一位的分钟数
	 */
	public String getMinute() {
		return getNowTime("m");
	}

	/**
	 * 返回秒
	 * 
	 * @return String 秒 一位的秒数
	 */
	public String getSecond() {
		return getNowTime("s");
	}

	/**
	 * 返回星期几
	 * 
	 * @return String 数字的星期几，如星期二将返回"星期二"
	 */
	public String getDayInWeek() {
		return getNowTime("E");
	}

	/**
	 * 只返回日期 如2004-08-12.月份和日期都是两位，不足的在前面补0
	 * 
	 * @return String 日期
	 */
	public String getDateOnly() {
		return getNowTime("yyyy-MM-dd");
	}

	/**
	 * 只返回时间 如12:20:30.时间为24小时制,分钟和秒数都是两位，不足补0
	 * 
	 * @return String 时间
	 */
	public String getTimeOnly() {
		return getNowTime("HH:mm:ss");
	}

	/**
	 * 调整年份
	 * 
	 * @param int i 要调整的基数，正表示加，负表示减
	 */
	public void adjustYear(int i) {
		adjustTime(i, 0, 0, 0, 0);
	}

	/**
	 * 调整月份
	 * 
	 * @param int i 要调整的基数，正表示加，负表示减
	 */
	public void adjustMonth(int i) {
		adjustTime(0, i, 0, 0, 0);
	}

	/**
	 * 调整天数
	 * 
	 * @param int i 要调整的基数，正表示加，负表示减
	 */
	public void adjustDay(int i) {
		adjustTime(0, 0, i, 0, 0);
	}

	/**
	 * 调整小时
	 * 
	 * @param int i 要调整的基数，正表示加，负表示减
	 */
	public void adjustHour(int i) {
		adjustTime(0, 0, 0, i, 0);
	}

	/**
	 * 调整分数
	 * 
	 * @param int i 要调整的基数，正表示加，负表示减
	 */
	public void adjustMinute(int i) {
		adjustTime(0, 0, 0, 0, i);
	}

	/**
	 * 调整时间
	 * 
	 * @param int y 年
	 * @param int m 月
	 * @param int d 日
	 * @param int h 小时
	 * @param int mm 分钟
	 */
	protected void adjustTime(int y, int m, int d, int h, int mm) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTimeInMillis(nowtime);
		cal.add(1, y);
		cal.add(2, m);
		cal.add(5, d);
		cal.add(11, h);
		cal.add(12, mm);
		nowtime = cal.getTimeInMillis();
	}

	/**
	 * 返回当前日期.
	 * 
	 * @return yyyy-MM-dd HH:mm:ss格式的日期／时间
	 */
	public static String getNowDateTime() {
		DateUtils dt = new DateUtils();
		return dt.getNowTime();
	}

	/**
	 * 按指定格式返回当前日期.
	 * 
	 * @param String
	 *            pattern 时间格式
	 * @return String 格式化的日期／时间
	 */
	public static String getNowDateTime(String pattern) {
		DateUtils dt = new DateUtils();
		return dt.getNowTime(pattern);
	}

	/**
	 * 获取当前时间yyyy-MM-dd
	 * 
	 * @return String
	 */
	public static String getNowDate() {
		return getNowDateTime("yyyy-MM-dd");
	}

	/**
	 * 返回中文格式的日期.如"二零零零年八月六日星期五18点4分"
	 * 
	 * @return String
	 */
	public static String getNowDateTimeChinese() {
		return getNowDateTimeChinese("yyyy年M月d日E") + getNowDateTime("H点mm分");
	}

	/**
	 * 根据自定义输出中文日期格式输出字符串。
	 * 
	 * @param String
	 *            pattern 日期、时间格式. 'yyyy年MM月dd日E'将输出'2004年8月16日星期六'
	 * @return String 时间、日期字符串
	 */
	public static String getNowDateTimeChinese(String pattern) {
		return numberToChinese(getNowDateTime(pattern));
	}

	/**
	 * 返回中文的数字，把12345678转成'零','一','二','三','四','五','六','七','八','九'
	 * 
	 * @param String
	 *            n 要转的字符串
	 * @return String 转换后的字符串
	 */
	public static String numberToChinese(String n) {
		char[] chars = n.toCharArray();
		for (int i = 0; i < chars.length; i++) {
			switch (chars[i]) {
			case '1':
				chars[i] = '一';
				break;
			case '2':
				chars[i] = '二';
				break;
			case '3':
				chars[i] = '三';
				break;
			case '4':
				chars[i] = '四';
				break;
			case '5':
				chars[i] = '五';
				break;
			case '6':
				chars[i] = '六';
				break;
			case '7':
				chars[i] = '七';
				break;
			case '8':
				chars[i] = '八';
				break;
			case '9':
				chars[i] = '九';
				break;
			case '0':
				chars[i] = '零';
				break;
			}
		}
		return new String(chars);
	}

	/**
	 * 按指定格式转换输出指定的日期
	 * 
	 * @param Date
	 *            date 要输出的日期
	 * @param String
	 *            datePattern 要输出的时间格式
	 * @return String 格式化后的字符串
	 */
	public static String getTime(Date date, String datePattern) {
		String retValue = null;
		SimpleDateFormat sf = new SimpleDateFormat(datePattern);
		retValue = sf.format(date);
		return retValue;
	}

	/**
	 * 把日期字符串转换为Date类型。
	 * 
	 * @param String
	 *            s 日期字符串
	 * @param String
	 *            datePattern 要输出的时间格式
	 * @return Date 返回Date类型日期
	 */
	public static Date parseDate(String s, String datePattern) {
		if (s == null || s.equals("")) {
			return null;
		}
		Date d = null;
		SimpleDateFormat sf = new SimpleDateFormat(datePattern);
		try {
			d = sf.parse(s);
		} catch (ParseException parseexception) {
			
		}
		return d;
	}

	/**
	 * 返回字符串
	 * 
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return getNowTime();
	}

	/**
	 * 取得与当前日子相隔n天的日期
	 * 
	 * @param n
	 *            为正则加，为负则减
	 * @return String-格式为yyyy-MM-dd的日期
	 */
	public String getStepDateTime(int n) {
		String dt = new String();
		adjustDay(n);
		dt = getDateOnly();
		adjustDay(-1 * n);
		return dt;
	}

	/**
	 * 返回两个日期相差几天
	 * 
	 * @param String
	 *            begin 日期字符串的格式 "yyyy-MM-dd"
	 * @param String
	 *            end 日期字符串的格式 "yyyy-MM-dd"
	 * @return
	 */
	public static long getDifferDay(String begin, String end) {
		long result = 0;
		if (begin == null || end == null || begin.equals("") || end.equals("")) {
			return 0;
		}
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date beginDate = formatter.parse(begin);
			Date endDate = formatter.parse(end);
			result = (endDate.getTime() - beginDate.getTime()) / (3600 * 24 * 1000);

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 返回指定日期中一周的所有日期,从周一开始
	 * 
	 * @param String
	 *            date 具体日期yyyy-MM-dd
	 * @return List<String>
	 */
	public static List<String> getWeekDate(String date) {
		List<String> list = new ArrayList<String>();
		Calendar cal = new GregorianCalendar();
		cal.setTime(parseDate(date, "yyyy-MM-dd"));
		cal.add(Calendar.DAY_OF_WEEK, (1 - cal.get(Calendar.DAY_OF_WEEK)));
		SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < 8; i++) {
			if (i != 0) {
				list.add(d.format(cal.getTime()));
			}
			cal.roll(Calendar.DAY_OF_YEAR, true);
		}
		return list;
	}

	/**
	 * 获取月份所有日期
	 * @param date
	 * @return
	 */
	public static List<String> getMonthDate(String date) {
		List<String> list = new ArrayList<String>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(parseDate(date, "yyyy-MM"));
		cal.set(Calendar.DATE, 1);

		SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
		
		int month = cal.get(Calendar.MONTH);
		while(cal.get(Calendar.MONTH) == month){
			list.add(d.format(cal.getTime()));
			cal.add(Calendar.DATE, 1);
		}
		return list;
	}

	/**
	 * add by wuqingshun at 2009-5-25 把日期字符串转换为指定的日期格式类型。
	 * 
	 * @param String
	 *            s 日期字符串
	 * @param String
	 *            datePattern 源字符串的时间格式
	 * @param String
	 *            datePattern 要输入的时间格式
	 * @return
	 */
	public static String formatDate(String s, String srcPattern, String datePattern) {
		Date d = null;
		if (s == null || s.equals(""))
			return "";
		else {
			d = parseDate(s, srcPattern);
		}
		SimpleDateFormat sf = new SimpleDateFormat(datePattern);
		return sf.format(d);

	}

	/**
	 * add by zbh at 2010-12-24 获取日期所在月天数
	 * 
	 * @param String
	 *            date 日期字符串
	 * @param int
	 */
	public static int getMonthNum(String date) {
		int num = 31;
		int year = Integer.parseInt(date.substring(0, 4));
		int mouth = Integer.parseInt(date.substring(5, 7));
		switch (mouth) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			num = 31;
			break;
		case 2:
			if (year % 4 == 0 && (year % 100) != 0) {
				num = 29;
			} else if (year % 400 == 0) {
				num = 29;
			} else {
				num = 28;
			}
			System.out.println(mouth);
			break;
		case 4:
		case 6:
		case 9:
		case 11:
			num = 30;
			break;
		}
		return num;
	}

	/**
	 * 
	 * @param Date
	 *            date 需转换的日期 add yelochina 2011-08-09
	 * @param String
	 *            datePattern 要转换的格式
	 * @return String 返回需要的格式
	 */
	public static String dateParseString(Date date, String datePattern) {
		String rs = "";
		if (null != date) {
			rs = new SimpleDateFormat(datePattern).format(date);
		}
		return rs;
	}

	/**
	 * 字符串转换成Date
	 * 
	 * @param String
	 *            date 转换的时间
	 * @param String
	 *            standardDatePattern 国家标准格式
	 * @param String
	 *            datePattern 返回结果的格式
	 * @return Date 转换的时间
	 */
	public static Date stringParseDate(String date, String standardDatePattern, String datePattern) {

		String rs = "";
		Date d = null;
		if (null != date && !"".equals(date)) {
			try {
				SimpleDateFormat sdfString = new SimpleDateFormat(standardDatePattern, Locale.US);// 日期格式转化
				SimpleDateFormat sdfFinal = new SimpleDateFormat(datePattern);// 日期格式转化
				rs = sdfFinal.format(sdfString.parse(date));

				if (rs == null || rs.equals("")) {
					return null;
				}
				SimpleDateFormat sf = new SimpleDateFormat(datePattern);
				d = sf.parse(rs);

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return d;
	}

	/**
	 * 获取调整之后的时间
	 * 
	 * @param dataTime
	 *            String 时间字符串
	 * @param timeType
	 *            String 时间类型:月、日、时、分、秒
	 * @param adjustType
	 *            String 调整类型:加、减
	 * @param intervalValue
	 *            int 间隔时间值
	 * @return String
	 */
	public static String getAdjustTime(String dataTime, String timeType, String adjustType, int intervalValue) {
		Calendar c = Calendar.getInstance();
		Date date = null;
		int timeUnit = 0;
		if (timeType.equals("minute")) {
			timeUnit = Calendar.MINUTE;
		} else if (timeType.equals("second")) {
			timeUnit = Calendar.SECOND;
		} else if (timeType.equals("hour")) {
			timeUnit = Calendar.HOUR;
		} else if (timeType.equals("date")) {
			timeUnit = Calendar.DATE;
		} else if (timeType.equals("month")) {
			timeUnit = Calendar.MONTH;
		}

		try {
			date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dataTime);
			c.setTime(date);
			int day = c.get(timeUnit);
			if (adjustType.equals("add")) {
				c.set(timeUnit, day + intervalValue);
			} else {
				c.set(timeUnit, day - intervalValue);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		String adjustTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(c.getTime());
		return adjustTime;
	}

	/**
	 * 返回两个日期相差几分钟
	 * 
	 * @param String
	 *            begin 日期字符串的格式 "yyyy-MM-dd"
	 * @param String
	 *            end 日期字符串的格式 "yyyy-MM-dd"
	 * @param String
	 *            type 获取类型
	 * @return
	 */
	public static long getDifferTime(String begin, String end, String type) {
		long result = 0;
		if (begin == null || end == null || begin.equals("") || end.equals("")) {
			return 0;
		}

		long dayNum = 1000 * 24 * 60 * 60;// 一天的毫秒数
		long hourNum = 1000 * 60 * 60;// 一小时的毫秒数
		long minuteNum = 1000 * 60;// 一分钟的毫秒数
		long secondNum = 1000;// 一秒钟的毫秒数

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date beginDate = formatter.parse(begin);
			Date endDate = formatter.parse(end);
			long diff = endDate.getTime() - beginDate.getTime();
			if (type.equals("day")) {
				result = diff / dayNum;
			} else if (type.equals("hour")) {
				result = diff / hourNum;
			} else if (type.equals("minute")) {
				result = diff / minuteNum;
			} else if (type.equals("second")) {
				result = diff / secondNum;
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 获取某年某月的最后一天 传入月份格式为'2011-12'
	 * 
	 * @param months
	 * @return
	 */

	public static String getLastDayOfMonth(String months) {
		int year = Integer.parseInt(months.substring(0, 4));
		int month = Integer.parseInt(months.substring(5, 7));
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DATE));
		return new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	}

	/**
	 * 获取某年某月的第一天 传入月份格式为'2011-12' 返回的日期后面会加一个空格，如果不需要的话要自己去掉空格不然匹配可能会出错
	 * 
	 * @param months
	 * @return
	 */
	public static String getFirstDayOfMonth(String months) {
		int year = Integer.parseInt(months.substring(0, 4));
		int month = Integer.parseInt(months.substring(5, 7));
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.DAY_OF_MONTH, cal.getMinimum(Calendar.DATE));
		return new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	}

	/**
	 * 获取两个日期间的所有月份列表
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	public static List<String> getMonthList(String beginTime, String endTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
		List<String> monthList = new ArrayList<String>();
		try {
			Calendar calendarBegin = Calendar.getInstance();
			Calendar calendarEnd = Calendar.getInstance();
			Date begin = format.parse(beginTime);
			Date end = format.parse(endTime);
			calendarBegin.setTime(begin);
			calendarEnd.setTime(end);
			int months = (calendarEnd.get(Calendar.YEAR) - calendarBegin.get(Calendar.YEAR)) * 12 + (calendarEnd.get(Calendar.MONTH) - calendarBegin.get(Calendar.MONTH));

			for (int i = 0; i <= months; i++) {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(begin);
				calendar.add(Calendar.MONTH, i);
				monthList.add(monthFormat.format(calendar.getTime()));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return monthList;
	}

	public static void main(String[] args) {
//		List<String> list = DateUtils.getMonthList("2012-04-28", "2012-11-05");
//		System.out.println(list.toString());
//		System.out.println(DateUtils.getNowDate());
	}
}