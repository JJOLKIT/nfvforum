package util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

/**
 * 각종 메시지들을 msg.properties파일에서 읽어오는 클래스
 * @author withsky
 *
 */
public class UsingProperties {

	private Properties properties = null;
	private static UsingProperties instance;
	
	/**
	 * 인스턴스 싱글톤객체 생성
	 * @return UsingProperties
	 */
	public static UsingProperties getInstance() {
		if (instance == null) {
			instance = new UsingProperties();
		}
		return instance;
	}

	/**
	 * 생성자
	 * Properties 객체 생성
	 * 현재 컨텍스트 경로 가져와 msg.properties파일 로드
	 */
	public UsingProperties() {
		properties = new Properties();
		ClassLoader loader = Thread.currentThread().getContextClassLoader();

		try {
			FileInputStream file = new FileInputStream(loader.getResource("msg.properties").getFile()); 
			properties.load(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * key값에 따른 msg.properties파일 중 value 값 리턴
	 * @param key
	 * @return String key값의 value
	 */
	public static String getMsg(String key) {
		UsingProperties up = UsingProperties.getInstance();
		String result = up.getProperties().getProperty(key);
		return result;
	}

	/**
	 * Properties 객체 반환
	 * @return Properties
	 */
	public Properties getProperties() {
		return properties;
	}

	public static void main(String[] args) {

		UsingProperties test = new UsingProperties();
		Enumeration<String> e = (Enumeration<String>) test.getProperties().propertyNames();

		while (e.hasMoreElements()) {
			System.out.println(e.nextElement()+"  "+test.getProperties().getProperty("value1"));
		}
		


	}

}
