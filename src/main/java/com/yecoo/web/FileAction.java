package com.yecoo.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.yecoo.dao.FileDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DateUtils;
import com.yecoo.util.DbUtils;
import com.yecoo.util.IdSingleton;
import com.yecoo.util.StrUtils;
/**
 * 附件管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/file")
public class FileAction {

	private DbUtils dbUtils = new DbUtils();
	private FileDaoImpl fileDaoImpl = new FileDaoImpl();
	
	/**
	 * 上传附件
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/uploadFile")
	@ResponseBody
	public String uploadFile(HttpServletRequest request, HttpServletResponse response) {

		String res = "上传成功";
		int iRes = -1;
		try {
			CodeTableForm userInfo = (CodeTableForm) request.getSession().getAttribute(Constants.USER_INFO_SESSION);
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			
			// 获取前台传值
			String[] pids = multipartRequest.getParameterValues("pid");
			String[] btypes = multipartRequest.getParameterValues("btype");
			String pid = "";
			String btype = "";
			if (pids != null) {
				pid = pids[0];
			}
			if (btypes != null) {
				btype = btypes[0];
			}
			
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
			String filePath = request.getSession().getServletContext().getRealPath("/")
					+ Constants.PATH_FILE;
			
			// 创建文件夹
			File file = new File(filePath);
			if (!file.exists()) {
				file.mkdirs();
			}
			String fileName = null;
			String fileid = null;
			String newFileName = null;
			CodeTableForm form = null;
			for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
				
				form = new CodeTableForm();
				
				// 上传文件名
				MultipartFile mf = entity.getValue();
				fileName = mf.getOriginalFilename();
	
				String suffix = fileName.indexOf(".") != -1
						? fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()) : null;
	
				fileid = IdSingleton.getInstance().getNewId();;
				newFileName = fileid + (suffix != null ? ("." + suffix) : "");// 构成新文件名。
				
				form.setValue("fileid", fileid);
				form.setValue("pid", pid);
				form.setValue("btype", btype);
				form.setValue("filename", fileName);
				form.setValue("suffix", suffix);
				form.setValue("createuser", userInfo.getValue("userid"));
				form.setValue("createtime", DateUtils.getNowDateTime());

				iRes = dbUtils.setInsert(form, "sfile");
	
				if(iRes >= 1) {
					File uploadFile = new File(filePath + newFileName);
					FileCopyUtils.copy(mf.getBytes(), uploadFile);
				} else {
					res = "上传失败";
				}
			}
		} catch(Exception e) {
			res = "上传失败";
			StrUtils.WriteLog(this.getClass().getName() + ".uploadFile()", e);
		}

		return res;
	}
    
	/**
	 * 删除附件
	 * @param fileid	附件ID
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/deleteFile/{fileid}")
	public @ResponseBody String deleteFile(@PathVariable int fileid, HttpServletRequest request) {
		String res = null;
		
		String filePath = request.getSession().getServletContext().getRealPath("/") + Constants.PATH_FILE;
		int iRes = fileDaoImpl.delFile(fileid, filePath);
		
		if(iRes >= 1) {
			res = "true";
		} else {
			res = "false";
		}
		
		return res;
	}
	
	/**
	 * 下载文件
	 * @param fileid
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/downloadFile/{fileid}")
	public @ResponseBody void downloadFile(@PathVariable int fileid, HttpServletRequest request,
			HttpServletResponse response) {

		try {
			String filePath = request.getSession().getServletContext().getRealPath("/") + Constants.PATH_FILE;
			CodeTableForm form = dbUtils.getFormByColumn("sfile", "fileid", String.valueOf(fileid));
			String fileName = fileid + "." + form.getValue("suffix");
			String fileFullPath = filePath + fileName;

			// 创建要下载的文件的对象(参数为要下载的文件在服务器上的路径)
			File serverFile = new File(fileFullPath);

			// 设置要显示在保存窗口的文件名，如果文件名中有中文的话，则要设置字符集，否则会出现乱码。另外，要写上文件后缀名
			String downloadFileName = java.net.URLEncoder.encode(StrUtils.nullToStr(form.getValue("filename"), fileName), "utf-8");
			// 该步是最关键的一步，使用setHeader()方法弹出"是否要保存"的对话框，打引号的部分都是固定的值，不要改变
			response.setHeader("Content-disposition", "attachment;filename=" + downloadFileName);

			/*
			 * 以下四行代码经测试似乎可有可无，可能是我测试的文件太小或者其他什么原因。。。
			 */
			response.setContentType("application/msword");
			// 定义下载文件的长度 /字节
			long fileLength = serverFile.length();
			// 把长整形的文件长度转换为字符串
			String length = String.valueOf(fileLength);
			// 设置文件长度(如果是Post请求，则这步不可少)
			response.setHeader("content_Length", length);

			/*
			 * 以上内容仅是下载一个空文件以下内容用于将服务器中相应的文件内容以流的形式写入到该空文件中
			 */
			// 获得一个 ServletOutputStream(向客户端发送二进制数据的输出流)对象
			OutputStream servletOutPutStream = response.getOutputStream();
			// 获得一个从服务器上的文件myFile中获得输入字节的输入流对象
			FileInputStream fileInputStream = new FileInputStream(serverFile);

			byte bytes[] = new byte[1024];// 设置缓冲区为1024个字节，即1KB
			int len = 0;
			// 读取数据。返回值为读入缓冲区的字节总数,如果到达文件末尾，则返回-1
			while ((len = fileInputStream.read(bytes)) != -1) {
				// 将指定 byte数组中从下标 0 开始的 len个字节写入此文件输出流,(即读了多少就写入多少)
				servletOutPutStream.write(bytes, 0, len);
			}

			servletOutPutStream.close();
			fileInputStream.close();
		} catch (Exception e) {

		}
	}
}