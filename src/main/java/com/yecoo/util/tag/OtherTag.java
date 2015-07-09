package com.yecoo.util.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
/**
 * 自定义标签
 * @author zhoujd
 * @date   2015年07月04日
 */
public class OtherTag extends SimpleTagSupport {

	private String btype = "";// 类型
	private String id = "";// ID

	@Override
	public void doTag() throws JspException, IOException {
		
		JspWriter out = getJspContext().getOut();
		String str = getBuy(btype, id);
		out.write(str);
		
		super.doTag();
	}
	
	private String getBuy(String btype, String id) {
		
		DbUtils dbUtils = new DbUtils();
		StringBuffer buffer = new StringBuffer();
		
		if(btype.equals("tobuy")) {
			String sql = "SELECT substring(c.manuname,1,4) manuname, b.materialname, b.price FROM sproductrow a, smaterial b, smanu c"
					+ " WHERE a.materialid = b.materialid AND b.manuid = c.manuid AND a.productid = '" + id
					+ "' AND (c.istobuy = '1' OR b.istobuy = '1') ORDER BY a.sort LIMIT 0,3";
			List<CodeTableForm> list = dbUtils.getListBySql(sql);
			
			for(CodeTableForm form : list) {
				buffer.append("<div style='float: left; color: blue;'>").append(form.getValue("manuname"))
					.append("</div>")
					.append("<div style='vertical-align: top; font-size: 6; float: left; color: red;'>")
					.append(form.getValue("materialname")).append(":").append(form.getValue("price"))
					.append("</div>");
			}
		}
		
		return buffer.toString();
	}

	public String getBtype() {
		return btype;
	}

	public void setBtype(String btype) {
		this.btype = btype;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}