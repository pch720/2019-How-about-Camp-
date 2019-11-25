package poly.controller;

import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.MailDTO;
import poly.service.IMailService;
import poly.util.CmmUtil;

@Controller
public class MailController {

   int sum=0;

   @Resource(name = "MailService")
   private IMailService mailService;
   
   @RequestMapping(value = "mail/mailMain")
   public String mailMain()throws Exception{
	   
	   return "/mail/mailMain";
   }

	/* 인증번호 전송 */
   @RequestMapping(value = "/mailSending", method = RequestMethod.POST)
   public @ResponseBody String mailSending(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
	   
	   Random R = new Random();
		int[] nums=new int[6];
		int num;
		for(int i=0;i<6;i++) {
			num=R.nextInt(8)+1;
			nums[i]=num;
		}
		sum=nums[0]*100000+nums[1]*10000+nums[2]*1000+nums[3]*100+nums[4]*10+nums[5];
		
      String toMail = CmmUtil.nvl(request.getParameter("email"));
      String title = "캠핑 어때 인증번호";
      String contents = "회원님이 입력하실 인증번호는 "+sum+"입니다.";

      MailDTO pDTO = new MailDTO();

      pDTO.setToMail(toMail);
      pDTO.setTitle(title);
      pDTO.setContents(contents);
      String result="0";

      int res = mailService.doSendMail(pDTO);
      if (res == 1) {
    	 result="1";
    	 System.out.println(sum);
      }
      return result;
   }

	/* 인증번호 확인 */
	@RequestMapping(value = "iCheck.do", method=RequestMethod.POST)
	public @ResponseBody String iCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ib=CmmUtil.nvl(request.getParameter("ib"));
		String s=""+sum;
		String result="0";
		if(s.equals(ib)) {
		result="1";
		}
		System.out.println(sum);
		return result;
	}
}
   