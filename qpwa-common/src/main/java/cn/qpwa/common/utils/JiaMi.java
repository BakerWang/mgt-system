package cn.qpwa.common.utils;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;

public class JiaMi {
 
    private String iv = "feie91o96t2q2p0p";
    private IvParameterSpec ivspec;
    private SecretKeySpec keyspec;
    private Cipher cipher;
     
    private String SecretKey = "8d0bfe2fb0311fd7";
     
    public JiaMi()
    {
        ivspec = new IvParameterSpec(iv.getBytes());
 
        keyspec = new SecretKeySpec(SecretKey.getBytes(), "AES");
         
        try {
            cipher = Cipher.getInstance("AES/CBC/NoPadding");
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
     
    public byte[] encrypt(String text) throws Exception
    {
        if(text == null || text.length() == 0)
            throw new Exception("Empty string");
         
        byte[] encrypted = null;
 
        try {
            cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
 
            encrypted = cipher.doFinal(padString(text).getBytes());
        } catch (Exception e)
        {           
            throw new Exception("[encrypt] " + e.getMessage());
        }
         
        return encrypted;
    }
     
    public byte[] decrypt(String code) throws Exception
    {
        if(code == null || code.length() == 0)
            throw new Exception("Empty string");
         
        byte[] decrypted = null;
 
        try {
            cipher.init(Cipher.DECRYPT_MODE, keyspec, ivspec);
             
            decrypted = cipher.doFinal(hexToBytes(code));
        } catch (Exception e)
        {
            throw new Exception("[decrypt] " + e.getMessage());
        }
        return decrypted;
    }
     
 
     
    public static String bytesToHex(byte[] data)
    {
        if (data==null)
        {
            return null;
        }
         
        int len = data.length;
        String str = "";
        for (int i=0; i<len; i++) {
            if ((data[i]&0xFF)<16)
                str = str + "0" + Integer.toHexString(data[i]&0xFF);
            else
                str = str + Integer.toHexString(data[i]&0xFF);
        }
        return str;
    }
     
         
    public static byte[] hexToBytes(String str) {
        if (str==null) {
            return null;
        } else if (str.length() < 2) {
            return null;
        } else {
            int len = str.length() / 2;
            byte[] buffer = new byte[len];
            for (int i=0; i<len; i++) {
                buffer[i] = (byte) Integer.parseInt(str.substring(i*2,i*2+2),16);
            }
            return buffer;
        }
    }
     
     
 
    private static String padString(String source)
    {
      char paddingChar = ' ';
      int size = 16;
      int x = source.length() % size;
      int padLength = size - x;
 
      for (int i = 0; i < padLength; i++)
      {
          source += paddingChar;
      }
 
      return source;
    }
}

/**
 * 说明
 * 
 * 使用方法：
	//加密
	String encrypted = JiaMi.bytesToHex(jm.encrypt("你要加密的内容"));
	//解密
	String decrypted = new String(JiaMi.decrypt(encrypted));
 */
