package net.yace.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Developpeur
 */
public class MD5Utils {
    private MD5Utils() {}
    
    public static String digest(String s) {
        
        String ret = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            md.reset();
            md.update(s.getBytes());
            byte[] digest = md.digest();
            
            StringBuilder sb = new StringBuilder();
            for(int i=0; i<digest.length; i++) {
                sb.append(Integer.toHexString(0xFF & digest[i]));
            }
            
            ret = sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(MD5Utils.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return ret;
    }
}
