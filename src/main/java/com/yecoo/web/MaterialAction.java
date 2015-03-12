package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yecoo.dao.FileDaoImpl;
import com.yecoo.dao.LogDaoImpl;
import com.yecoo.dao.MaterialDaoImpl;
import com.yecoo.dao.MaterialtypeDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 物资管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/material")
public class MaterialAction {

	DbUtils dbUtils = new DbUtils();
	private MaterialDaoImpl materialDaoImpl = new MaterialDaoImpl();
	private MaterialtypeDaoImpl materialtypeDaoImpl = new MaterialtypeDaoImpl();

	@RequiresPermissions("Material:view")
	@RequestMapping(value="/tree")
	public String tree(HttpServletRequest request) {

		String act = StrUtils.nullToStr(request.getParameter("act"));// 用于查找带回
		request.setAttribute("act", act);
		
		CodeTableForm form = materialtypeDaoImpl.getMaterialtypeById(1);
		request.setAttribute("form", form);
		return "material/tree";
	}
	
	@RequiresPermissions("Material:view")
	@RequestMapping(value="/list/{materialtype}")
	public String list(@PathVariable("materialtype") int materialtype, CodeTableForm form, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// 来自tree.jsp
		
		form.setValue("materialtype", materialtype); //物资类型
		materialDaoImpl.initAction(request);

		int totalCount = materialDaoImpl.getMaterialCount(form);
		List<CodeTableForm> materialList = materialDaoImpl.getMaterialList(form);
		request.setAttribute("curTime", curTime);
		request.setAttribute("totalCount", totalCount); //列表总数量
		request.setAttribute("materialList", materialList); //列表
		request.setAttribute("sn", "material"); //授权名称
		request.setAttribute("form", form);
		
		return "material/list";
	}

	@RequiresPermissions("Material:add")
	@RequestMapping(value="/add/{materialtype}", method=RequestMethod.GET)
	public String toAdd(@PathVariable("materialtype") int materialtype, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		CodeTableForm form = new CodeTableForm();
		
		CodeTableForm parentForm = dbUtils.getFormByColumn("smaterialtype", "materialtype",
				String.valueOf(materialtype));
		
		String materialno = StrUtils.getNO(StrUtils.nullToStr(parentForm.getValue("materialtypeno")),
				"materialno", "smaterial", 3);

		form.setValue("materialtype", materialtype);
		form.setValue("materialno", materialno); //物资类型编码
		form.setValue("materialtypename", StrUtils.nullToStr(parentForm.getValue("materialtypename")));
		form.setValue("unit", "1");// 默认单位：只

		request.setAttribute("form", form);
		request.setAttribute("curTime", curTime);
		return "material/add";
	}

	@RequiresPermissions("Material:add")
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public @ResponseBody String add(CodeTableForm form, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		AjaxObject ajaxObject = null;
		String createdate = StrUtils.getSysdate("yyyy-MM-dd HH:mm:ss"); //当前日期
		form.setValue("createdate", createdate);
		int iReturn = materialDaoImpl.addMaterial(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "新增成功！", "", "", "jbsxBox2material" + curTime, "closeCurrent");

			StrUtils.saveLog(request, "新增物资", form);
		} else {
			ajaxObject = new AjaxObject("新增失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Material:edi")
	@RequestMapping(value="/edi/{materialid}")
	public String toEdi(@PathVariable("materialid") int materialid, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		CodeTableForm form = null;
		form = materialDaoImpl.getMaterialById(materialid);
		
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		List<CodeTableForm> fileList = fileDaoImpl.getFileList(materialid, "'material'");// 附件列表
		
		request.setAttribute("form", form);
		request.setAttribute("fileList", fileList);
		request.setAttribute("curTime", curTime);
		return "material/edi";
	}

	@RequiresPermissions("Material:edi")
	@RequestMapping(value="/edi", method=RequestMethod.POST)
	public @ResponseBody String edi(CodeTableForm form, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		AjaxObject ajaxObject = null;
		int iReturn = materialDaoImpl.ediMaterial(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "修改成功！", "", "", "jbsxBox2material" + curTime, "closeCurrent");

			StrUtils.saveLog(request, "修改物资", form);
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	@RequiresPermissions("Material:delete")
	@RequestMapping(value="/delete/{materialid}")
	public @ResponseBody String delete(@PathVariable int materialid, HttpServletRequest request) {

		String curTime = StrUtils.nullToStr(request.getParameter("curTime"));// List的时间
		
		AjaxObject ajaxObject = null;
		int iReturn = materialDaoImpl.deleteMaterial(materialid);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject(200, "删除成功！", "", "", "jbsxBox2material" + curTime, "");

			LogDaoImpl.saveLog(request, "删除物资", materialid);
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}
	
	/**
	 * 查询物资
	 * @param keyword
	 * @return
	 */
    @RequestMapping(value = "/getSelectByKeyword")
    @ResponseBody
    public List<CodeTableForm> getSelectByKeyword(String keyword) {
		String sql = "SELECT t.*, b.manuid, b.manuname, b.manucontact, b.manutel"
				+ " FROM smaterial t LEFT JOIN smanu b ON t.manuid = b.manuid"
				+ " WHERE (t.materialno LIKE '%"
				+ keyword + "%' OR t.materialname LIKE '%" + keyword + "%')";
		List<CodeTableForm> list = dbUtils.getListBySql(sql);
        return list;
    }
}