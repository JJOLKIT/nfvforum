package util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.security.SecureRandom;
import java.util.regex.Pattern;

public class PasswordUtil extends BCryptPasswordEncoder {

    private Pattern BCRYPT_PATTERN = Pattern.compile("\\A\\$2a?\\$\\d\\d\\$[./0-9A-Za-z]{53}");
    private final Log logger = LogFactory.getLog(getClass());

    public boolean isBCrypt(String encodedPassword) {

        if (!BCRYPT_PATTERN.matcher(encodedPassword).matches()) {
            logger.debug("Encoded password does not look like BCrypt");
            return false;
        }

        return true;
    }

    /**
     * 임시비밀번호
     * @param str
     * @return
     * @throws Exception
     */
    public String getRamdomPassword(int len) throws Exception{

        String ramdomPassword = "";

        try {

            char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
                    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                    'U', 'V', 'W', 'X', 'Y', 'Z' };
            int idx = 0;
            StringBuffer sb = new StringBuffer();

            for(int i = 0; i < len; i++) {

                SecureRandom random = new SecureRandom ();
                idx = (int)(charSet.length * random.nextDouble());
                sb.append(charSet[idx]);

            }

            ramdomPassword = sb.toString();

        }catch(Exception e){
            throw new Exception("임시 비밀번호 발급중 에러가 발생하였습니다.");
        }

        return ramdomPassword;

    }
}
