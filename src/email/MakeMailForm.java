package email;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
 

// jsp 또는 html 형태의 파일을 읽어 들여 메일폼으로 사용할 수 있도록 하는 클래스
public class MakeMailForm {
	
	// 전달 받은 파일일 경로(시스템 풀 경로)의 메일 레터를 읽어와 String 형태로 반환한다.(순수 html일 경우 사용)
	public static String getMakeMailForm(String fullName) throws FileNotFoundException, IOException {
        try {
	        FileInputStream fis = new FileInputStream(fullName);
	        InputStreamReader isr = new InputStreamReader(fis);
	        BufferedReader br = new BufferedReader(isr);
	        
	        StringBuffer formLetter = new StringBuffer();
	        String line = null;
	        
	        while( ( (line = br.readLine()) != null )){
	            formLetter.append(line);
	        }
	        br.close();
	        return formLetter.toString();
        } catch ( FileNotFoundException fnfe ){
            throw fnfe;
        } catch ( IOException ioe ){
            throw ioe;
        }
    }
   
	// getFormLetter의 오버로딩(경로와 파일명 불리)
    public static String getMakeMailForm(String path, String fileName) throws FileNotFoundException, IOException {
        return getMakeMailForm(path+fileName);
    }
    
	// 전달 받은 파일일 URL(시스템 풀 경로)의 메일 레터를 읽어와 String 형태로 반환한다.(JSP, 원격경로일 경우 사용)
    public static String getURLMakeMailForm(String fullPath, String param) throws MalformedURLException, IOException {

		StringBuffer contents = new StringBuffer();
		try {
		    if ( param != null ){
		        param = "?"+param;
		    } else {
		        param = "";
		    }
		    URL url = new URL(fullPath+param);
		    DataInputStream dis = new DataInputStream(url.openStream());
		    
		    // dis에서는 UTF-8이 인코딩 깨짐
		    BufferedReader br = new  BufferedReader(new InputStreamReader(dis,"UTF-8"));
		    String inputLine;
		    while ((inputLine = br.readLine()) != null) {
                contents.append(inputLine);
           }
           dis.close();
		} catch (MalformedURLException me) {
            throw me;
        } catch (IOException ioe) {
            throw ioe;
        }
        //return Function.toKorean(contents.toString());
		return contents.toString();
	}
    
	// getURLContents의 오버로딩(주소와 하위경로 불리)
    public static String getURLMakeMailForm(String site, String path, String param) throws MalformedURLException, IOException {
        return getURLMakeMailForm(site+path, param);
    }
    
    public static void main(String[] args) throws Exception {
    	String a = MakeMailForm.getURLMakeMailForm(property.SiteProperty.COMPANY_URL, "/include/emailForm.jsp", "");	// 이메일폼을 읽어온다.
    	System.out.println(a.toString());
    }
}
