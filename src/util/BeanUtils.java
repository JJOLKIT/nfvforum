package util;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

/**
 * 각 객체에 자동으로 값들을 바인드 해주는 클래스
 * get/post 방식과 multipart 방식으로 나뉨.
 * @author withsky
 *
 */
public class BeanUtils {

	/**
	 *  get/post 방식 바인드
	 * @param request HttpServletRequest
	 * @param obj	Object
	 * @return Object
	 * @throws Exception
	 */
	public static Object bind(HttpServletRequest request, Object obj) throws Exception {
		
		Enumeration params = request.getParameterNames();
		
		while (params.hasMoreElements()) {
			String name = (String)params.nextElement();
			String value = cleanXSS(request.getParameter(name));
			String[] values = cleanXSS(request.getParameterValues(name));
			
			if(values.length > 1){
			org.apache.commons.beanutils.BeanUtils.setProperty(obj, name, values);
			}else{
			org.apache.commons.beanutils.BeanUtils.setProperty(obj, name, value);	
			}
		}
		
		return obj;
	}
	
	public static HashMap<String, Object> bindHashMap(HttpServletRequest request, HashMap<String, Object> hmap) throws Exception {
		
		Enumeration params = request.getParameterNames();
		
		while (params.hasMoreElements()) {
			String name = (String)params.nextElement().toString();
			String value = cleanXSS(request.getParameter(name));
			String[] values = cleanXSS(request.getParameterValues(name));
			
			if(values.length > 1){
				hmap.put(name, values);
			}else{
				hmap.put(name, value);
			}
		}
		
		return hmap;

	}
	
	public static HashMap<String, Object> bindHashMap(HttpServletRequest request, HashMap<String, Object> hmap, int pageRows) throws Exception {
		
		Enumeration params = request.getParameterNames();
		
		while (params.hasMoreElements()) {
			String name = (String)params.nextElement().toString();
			String value = cleanXSS(request.getParameter(name));
			String[] values = cleanXSS(request.getParameterValues(name));
			
			if(values.length > 1){
				hmap.put(name, values);
			}else{
				hmap.put(name, value);
			}
		}
		
		if (!hmap.containsKey("reqPageNo")) {
			hmap.put("reqPageNo", 1);
		}
		
		hmap.put("pageRows", pageRows);
		hmap.put("startPageNo", Function.getStartPageNo(Function.getIntParameter(String.valueOf(hmap.get("reqPageNo"))), Function.getIntParameter(String.valueOf(hmap.get("pageRows")))));
		
		return hmap;
	}
	
	public static HashMap<String, Object> bindHashMap(HttpServletRequest request, HashMap<String, Object> hmap, int pageRows, String uploadPath, int maxSize) throws Exception {
		MultipartRequest multi = new MultipartRequest(request, request.getRealPath(uploadPath), maxSize, "utf-8",  new MyFileRenamePolicy());
		
		Enumeration params = multi.getParameterNames();
		
		while (params.hasMoreElements()) {
			String name = (String)params.nextElement().toString();
			String value = cleanXSS(multi.getParameter(name));
			String[] values = cleanXSS(multi.getParameterValues(name));
			
			if(values.length > 1){
				hmap.put(name, values);
			}else{
				hmap.put(name, value);
			}
		}
		
		if (!hmap.containsKey("reqPageNo")) {
			hmap.put("reqPageNo", 1);
		}
		
		hmap.put("uploadPath", request.getRealPath(uploadPath));
		
		// multipart 파일명 구하기
		Enumeration fileNameParams = multi.getFileNames();
		
		while (fileNameParams.hasMoreElements()) {
			int i=0;
			String fileName = (String)fileNameParams.nextElement();
			String value = multi.getFilesystemName(fileName);	// 실제이름
			if(value != null){
				if(value.indexOf(".dum") >= 0){
					File file = new File(request.getRealPath(uploadPath)+"/"+value);
					//file.delete();
				} else {
					String org_value = multi.getOriginalFileName(fileName);
					hmap.put(fileName, value);
					hmap.put(fileName+"_org", org_value);
				}
			}
		}
		
		hmap.put("pageRows", pageRows);
		hmap.put("startPageNo", Function.getStartPageNo(Function.getIntParameter(String.valueOf(hmap.get("reqPageNo"))), Function.getIntParameter(String.valueOf(hmap.get("pageRows")))));
		
		return hmap;
	}
	
	/**
	 *  multipart 방식 바인드
	 *  uploadPath는 realPath없이 config.jsp변수 그대로
	 * @param request HttpServletRequest
	 * @param obj Object
	 * @param uploadPath 업로드경로
	 * @param maxSize 최대사이즈
	 * @return
	 * @throws Exception
	 */
	public static Object bind(HttpServletRequest request, Object obj, String uploadPath, int maxSize) throws Exception {
		MultipartRequest multi = new MultipartRequest(request, request.getRealPath(uploadPath), maxSize, "utf-8",  new MyFileRenamePolicy());
		
		// multipart 파라미터 구하기
		Enumeration params = multi.getParameterNames(); 

		while (params.hasMoreElements()) {
			String name = (String)params.nextElement();
			//String value = request.getParameter(name);
			String value = cleanXSS(multi.getParameter(name));
			String[] values = cleanXSS(multi.getParameterValues(name));
			
			if(values.length > 1){
			org.apache.commons.beanutils.BeanUtils.setProperty(obj, name, values);
			}else{
			org.apache.commons.beanutils.BeanUtils.setProperty(obj, name, value);	
			}
		}
		org.apache.commons.beanutils.BeanUtils.setProperty(obj, "uploadPath", request.getRealPath(uploadPath));
		
		// multipart 파일명 구하기
		Enumeration fileNameParams = multi.getFileNames();
		
		while (fileNameParams.hasMoreElements()) {
			int i=0;
			String fileName = (String)fileNameParams.nextElement();
			String value = multi.getFilesystemName(fileName);	// 실제이름
			
			if(value != null){
				if(value.indexOf(".dum") >= 0){
					File file = new File(request.getRealPath(uploadPath)+"/"+value);
					//file.delete();
				} else {
					String org_value = multi.getOriginalFileName(fileName);
					org.apache.commons.beanutils.BeanUtils.setProperty(obj, fileName, value);
					org.apache.commons.beanutils.BeanUtils.setProperty(obj, fileName+"_org", org_value);
				}
			}
		}
		
		return obj;
	}
	
	// XSS 공격대비 script 문자치환
	private static String cleanXSS(String value) {
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		value = value.replaceAll("script", "");
		return value;
	}
	
	private static String[] cleanXSS(String[] value) {
		for (int i=0; i<value.length; i++) {
			value[i] = value[i].replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
			value[i] = value[i].replaceAll("script", "");
		}
		
		return value;
	}
	
	public static void main(String[] args) {
//		HttpServletRequest request = new HttpServletRequest();
//		HashMap<String, Object> param = new HashMap();
//
//		param = BeanUtils.bindHashMap(request, param);
	}

}
