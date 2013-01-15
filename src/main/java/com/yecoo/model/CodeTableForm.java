package com.yecoo.model;

import java.util.HashMap;
/**
 * 公用BEAN
 * @author zhoujd
 */
public class CodeTableForm {

	public HashMap<String, Object> map = new HashMap<String, Object>();

	public Object getValue(String key) {
		return map.get(key);
	}

	public void setValue(String key, Object value) {
		map.put(key, value);
	}

	public HashMap<String, Object> getMap() {
		return map;
	}

	public void setMap(HashMap<String, Object> map) {
		this.map = map;
	}
}