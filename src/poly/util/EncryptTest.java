package poly.util;

public class EncryptTest {

	public static void main(String[] args)throws  Exception{
		
		System.out.println("----------------------------------");
		System.out.println("해시 암호화 알고리즘");
		
		String str = "암호화할 문자열";
		
		String hashEnc = EncryptUtil.encHashSHA256(str);
		
		System.out.println("hashEnc : "+hashEnc);
		
		System.out.println("----------------------------------");
		System.out.println("AES128-CBC 암, 복호화 알고리즘");
		
		String enc = EncryptUtil.encAES128CBC(str);
		
		System.out.println("enc : "+enc);
		
		String dec = EncryptUtil.decAES128CBC(enc);
		
		System.out.println("dec : "+dec);
		
		System.out.println("----------------------------------");
	}
}
