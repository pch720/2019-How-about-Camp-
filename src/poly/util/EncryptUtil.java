package poly.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

public class EncryptUtil {
	
	final static String addMessage = "PolyDataAnalysis";
	
	final static byte[] ivBytes= {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	
	final static String key = "PolyTechnic12345";
	
	public static String encHashSHA256(String str)throws Exception{
	
		String	res="";
		String plantText = addMessage +str;
		
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			
			sh.update(plantText.getBytes());
			
			byte byteData[] = sh.digest();
			
			StringBuffer sb = new StringBuffer();
			
			for(int i=0;i<byteData.length; i++) {
				sb.append(Integer.toString((byteData[i]& 0xff)+ 0x100, 16).substring(1));
				
			}
			res = sb.toString();
			
		}catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			
			res= "";
		}
		return res;
	}
	public static String encAES128CBC(String str)
			throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException{
		
		byte[] textBytes = str.getBytes("UTF-8");
		
		AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
		SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
		Cipher cipher=null;
		cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE,newKey,ivSpec);
		return Base64.encodeBase64String(cipher.doFinal(textBytes));
	}
	
	public static String decAES128CBC(String str)
			throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException{
		
		byte[] textBytes = Base64.decodeBase64(str);
		
		AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
		SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE,newKey, ivSpec);
		return new String(cipher.doFinal(textBytes),"UTF-8");
	}
}
