package com.yecoo.util.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.yecoo.dao.ParameterDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
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
			String sql = "SELECT substring(c.manuname,1,4) manuname, b.mark, b.property, b.materialname,"
					+ " a.remarkshow, b.price FROM sproductrow a, smaterial b, smanu c"
					+ " WHERE a.materialid = b.materialid AND b.manuid = c.manuid AND a.productid = '" + id
					+ "' AND (c.istobuy = '1' OR b.istobuy = '1') ORDER BY a.sort LIMIT 0,10";
			List<CodeTableForm> list = dbUtils.getListBySql(sql);
			
			for(CodeTableForm form : list) {
				buffer.append("<div style='float: left; color: blue;'>").append(form.getValue("manuname"))
					.append("</div>")
					.append("<div style='vertical-align: top; font-size: 6; float: left; color: red;'>")
					.append(form.getValue("materialname"));
				
				String remarkshow = StrUtils.nullToStr(form.getValue("remarkshow"));
				if(!remarkshow.equals("")) {// 采购备注不为空
					buffer.append("<span style='color: green;'>【")
						.append(StrUtils.nullToStr(form.getValue("remarkshow")))
						.append("】</span>");
				}
				
				String showFeatures = new ParameterDaoImpl().getParameterName("采购单显示物资特性");
				
				if(showFeatures.equals("Y")) {// 采购单显示物资特性
					
					String prop = StrUtils.nullToStr(form.getValue("property"))
							+ StrUtils.nullToStr(form.getValue("mark"));
					
					if(!prop.equals("")) {// 属性、标记不为空
						buffer.append("<span style='color: orange;'>〖")
							.append(StrUtils.nullToStr(form.getValue("property")))
							.append(StrUtils.nullToStr(form.getValue("mark")))
							.append("〗</span>");
					}
				}
				
				buffer.append(":").append(form.getValue("price"))
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