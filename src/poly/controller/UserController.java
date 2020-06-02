package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.UserDTO;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Controller
public class UserController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserService")
	private IUserService userservice;

	@RequestMapping(value = "/userReg")
	public String userReg() throws Exception {
		return "/user/userReg";
	}

	// 메인화면
	@RequestMapping(value = "index")
	public String Index() throws Exception {
		return "/index";
	}

	// 회원가입
	@RequestMapping(value = "/userRegProc")
	public String userRegProc(HttpServletRequest request, Model model) throws Exception {

		String userEmail = request.getParameter("userEmail");
		String userName = request.getParameter("userName");
		String userPassword = request.getParameter("userPassword");
		String userPhone = request.getParameter("userPhone");
		String str = userPassword;

		String hashEnc = EncryptUtil.encHashSHA256(str);
		
		log.info("userEmail 확인:" + userEmail);
		log.info("userName 확인:" + userName);
		log.info("userPassword 확인:" + userPassword);
		log.info("userPassword 암호화 확인:" + hashEnc);
		log.info("userPhone 확인:" + userPhone);

		UserDTO uDTO = new UserDTO();
		uDTO.setUserEmail(userEmail);
		uDTO.setUserName(userName);
		uDTO.setUserPassword(hashEnc);
		uDTO.setUserPhone(userPhone);

		int result = 0;

		result = userservice.userRegProc(uDTO);
		log.info("결과값:" + result);

		String msg, url;
		if (result == 1) {
			msg = "회원가입에 성공하였습니다.";
			url = "/index.do";
		} else {
			msg = "회원가입에 실패하였습니다.";
			url = "/userReg.do";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/redirect";
	}

	// 휴대폰 중복확인
	@RequestMapping(value = "/pCheck.do", method = RequestMethod.POST)
	public @ResponseBody String pCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String phone = CmmUtil.nvl(request.getParameter("phone"));
		log.info(phone);
		String count = userservice.pCheck(phone);
		log.info(count);

		return count;
	}

	// 이메일 중복확인
	@RequestMapping(value = "/eCheck.do", method = RequestMethod.POST)
	public @ResponseBody String eCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = CmmUtil.nvl(request.getParameter("email"));
		String count = userservice.eCheck(email);
		return count;
	}

	// 로그인 하기&회원인증 하기
	@RequestMapping(value = "/userReceive")
	public String receive(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");
		String Email = (String) session.getAttribute("SS_userEmail");
		String str = userPassword;
		String msg, url;
		String referer = CmmUtil.nvl(request.getHeader("Referer"));
		
		String hashEnc = EncryptUtil.encHashSHA256(str);
		log.info("userEmail 확인:" + userEmail);
		log.info("Email 확인:" + Email);
		log.info("userPassword 확인:" + userPassword);

		if (userEmail != null) {
			UserDTO uDTO = new UserDTO();
			uDTO.setUserEmail(userEmail);
			uDTO.setUserPassword(hashEnc);

			uDTO = userservice.getUserInfo(uDTO);
			if (uDTO == null) {
				msg = "로그인에 실패하였습니다.";
				url = referer;
				log.info("로그인 실패");
			}else { 
			String userAss=uDTO.getUserAss();
			
			if(userAss.equals("2")) {
				msg = "관리자에 의해 정지된 아이디입니다.";
				url = referer;
			}else {

				session.setAttribute("SS_userSeq", uDTO.getUserSeq());
				session.setAttribute("SS_userEmail", uDTO.getUserEmail());
				session.setAttribute("SS_userName", uDTO.getUserName());
				session.setAttribute("SS_userPhone", uDTO.getUserPhone());
				session.setAttribute("SS_userRegdate", uDTO.getUserRegdate());
				session.setAttribute("SS_userUpdate", uDTO.getUserUpdate());
				session.setAttribute("SS_userUpnum", uDTO.getUserUpnum());
				session.setAttribute("SS_userAss", uDTO.getUserAss());

				log.info(" session : " + session);
				
				msg = "로그인 성공하였습니다.";
				url = referer;

			}
			
			}
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
		} else {
			UserDTO uDTO = new UserDTO();
			uDTO.setUserEmail(Email);
			uDTO.setUserPassword(hashEnc);

			uDTO = userservice.getUserInfo(uDTO);

			if (uDTO == null) {
				msg = "비밀번호 인증에 실패하였습니다.";
				url = "/index.do";
			} else {

				msg = "비밀번호 인증에 성공하였습니다.";
				url = "/userMod.do";

			}
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
		}
		return "redirect";
	}

	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		session.invalidate();
		String msg, url;
		msg = "로그아웃에 성공하였습니다.";
		url = "/index.do";

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "redirect";
	}

	// 회원탈퇴
	@RequestMapping(value = "/userDelete")
	public String userDelete(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		String userEmail = (String) session.getAttribute("SS_userEmail");
		log.info(userEmail);

		int result = 0;
		String msg, url;

			UserDTO uDTO = new UserDTO();
			uDTO.setUserEmail(userEmail);
			result = userservice.userDelete(uDTO);
			log.info(result);

			if (result == 1) {
				msg = "회원탈퇴에 성공하였습니다.";
				url = "/index.do";
				session.invalidate();
			} else {
				msg = "회원탈퇴에 실패하였습니다.";
				url = "/index.do";
			}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/redirect";
	}

	// 이메일 찾기 페이지
	@RequestMapping(value = "/findEmail")
	public String findEmail() throws Exception {
		return "/user/findEmail";
	}

	// 비밀번호 찾기 페이지
	@RequestMapping(value = "/findPw")
	public String findPw() throws Exception {
		return "/user/findPw";
	}

	// 이메일 찾기 기능
	@RequestMapping(value = "/findE")
	public String findE(HttpServletRequest request, Model model) throws Exception {
		String userName = request.getParameter("userName");
		String userPhone = request.getParameter("userPhone");

		log.info("userName 확인:" + userName);
		log.info("userPhone 확인:" + userPhone);

		UserDTO uDTO = new UserDTO();
		uDTO.setUserName(userName);
		uDTO.setUserPhone(userPhone);
		String email1, email2;

		email1 = userservice.email1(uDTO);
		email2 = userservice.email2(uDTO);
		String msg, url;
		if (email1 == null) {
			msg = "입력하신 정보의 회원이 없습니다.";
			url = "/findEmail.do";
		} else {
			msg = "회원님의 이메일은 " + email1 + "*****" + email2 + "입니다.";
			url = "/index.do";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "redirect";
	}

	// 비밀번호 변경 기능
	@RequestMapping(value = "/findP")
	public String findP(HttpServletRequest request, Model model) throws Exception {
		String userPassword = request.getParameter("userPassword");
		String userEmail = request.getParameter("userEmail");
		String str = userPassword;
		String hashEnc = EncryptUtil.encHashSHA256(str);
		log.info("userEmail 확인: " + userEmail);
		log.info("userPassword 확인: " + userPassword);
		String msg, url;
		String pw = userservice.pw(userEmail);
		log.info(pw);
		if (pw.equals(hashEnc)) {
			msg = "회원님께서 이미 사용중인 비밀번호입니다.";
			url = "/findPw.do";
		} else {

			UserDTO uDTO = new UserDTO();
			uDTO.setUserPassword(hashEnc);
			uDTO.setUserEmail(userEmail);

			int result = 0;
			result = userservice.changeP(uDTO);

			if (result == 1) {
				msg = "비밀번호가 변경되었습니다.";
				url = "/index.do";
			} else {
				msg = "비밀번호 변경이 실패하였습니다.";
				url = "/findPw.do";
			}
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "redirect";
	}

	// 회원정보 상세 페이지
	@RequestMapping(value = "/userDetail")
	public String userDetail() throws Exception {
		return "/user/userDetail";
	}

	// 회원정보 수정 페이지
	@RequestMapping(value = "/userMod")
	public String userMod(HttpServletRequest request,Model model) throws Exception {
		return "/user/userMod";
	}

	// 회원정보 변경 기능
	@RequestMapping(value = "/userModproc")
	public String userModproc(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String userPhone = request.getParameter("userPhone");
		String userEmail = request.getParameter("userEmail");
		String userName = request.getParameter("userName");
		String userSeq = request.getParameter("userSeq");
		String upnum = (String) session.getAttribute("SS_userSeq");
		log.info("userEmail 확인: " + userEmail);
		log.info("userPhone 확인: " + userPhone);
		log.info("userName 확인: " + userName);
		log.info("userSeq 확인: " + userSeq);
		log.info("upnum 확인: " + upnum);
		String msg, url;
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");

		Date time = new Date();

		String time1 = format1.format(time);

		System.out.println(time1);
		UserDTO uDTO = new UserDTO();
		uDTO.setUserUpdate(time1);
		uDTO.setUserEmail(userEmail);
		uDTO.setUserPhone(userPhone);
		uDTO.setUserName(userName);
		uDTO.setUserSeq(userSeq);
		uDTO.setUserUpnum(upnum);

		int result = 0;
		result = userservice.userMod(uDTO);
		log.info(uDTO.getUserUpdate());
		if (result == 1) {
			msg = "회원정보가 변경되었습니다.";
			url = "/index.do";
			session.setAttribute("SS_userEmail", uDTO.getUserEmail());
			session.setAttribute("SS_userName", uDTO.getUserName());
			session.setAttribute("SS_userPhone", uDTO.getUserPhone());
			session.setAttribute("SS_userUpnum", uDTO.getUserUpnum());
			session.setAttribute("SS_userUpdate", uDTO.getUserUpdate());
		} else {
			msg = "회원정보 변경이 실패하였습니다.";
			url = "/userMod.do";
		}
		log.info(session.getAttribute("SS_userUpdate"));
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "redirect";
	}
	
}
