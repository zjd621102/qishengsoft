package com.yecoo.util.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
/**
 * 自定义SELECT标签
 * @author zhoujd
 * @date   2014年8月22日 上午10:53:08
 */
public class SelectTag extends SimpleTagSupport {

	private String dictType = "";// 字典类型
	private String id = "";// ID
	private String name = "";// NAME
	private String value = "";// 值
	private String expStr = "";// 其他属性

	@Override
	public void doTag() throws JspException, IOException {
		
		JspWriter out = getJspContext().getOut();
		String str = getSelect(dictType, id, name, value, expStr);
		out.write(str);
		
		super.doTag();
	}
	
	private String getSelect(String dictType2, String id2, String name2, String value2, String expStr2) {
		
		DbUtils dbUtils = new DbUtils();
		StringBuffer buffer = new StringBuffer();
		
		String sql = "SELECT b.* FROM cdict a, cdictrow b WHERE a.dictid = b.dictid AND a.dicttype = '"
				+ dictType2 + "' ORDER BY b.sordid";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
		
		buffer.append("<select");
		
		if(!id2.isEmpty()) {
			buffer.append(" id='").append(id2).append("'");
		}

		if(!name2.isEmpty()) {
			buffer.append(" name='").append(name2).append("'");
		}
		
		if(!expStr2.isEmpty()) {
			buffer.append(" ").append(expStr2);
		}
		
		buffer.append(" >");
		
		buffer.append("<option></option>");
		
		for(CodeTableForm form : list) {
			buffer.append("<option value='").append(form.getValue("dictvalue")).append("'");
			
			if(value2.equals(form.getValue("dictvalue"))) {
				buffer.append(" selected='selected'");
			}
			
			buffer.append(">").append(form.getValue("dictname")).append("</option>");
		}
		
		buffer.append("</select>");
		
		return buffer.toString();
	}

	public String getDictType() {
		return dictType;
	}

	public void setDictType(String dictType) {
		this.dictType = dictType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getExpStr() {
		return expStr;
	}

	public void setExpStr(String expStr) {
		this.expStr = expStr;
	}
}