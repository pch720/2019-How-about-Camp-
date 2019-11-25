package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.ReviewDTO;
import poly.service.IReviewService;

@Controller
public class CampController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "ReviewService")
	private IReviewService reviewservice;

	@RequestMapping(value = "/CampMain")
	public String CampMain() throws Exception {
		return "/camp/CampMain";
	}

	@RequestMapping(value = "/CampDetail")
	public String CampDetail(HttpServletRequest request, Model model) throws Exception {
		String LAT = request.getParameter("LAT");
		String LON = request.getParameter("LON");
		String FNAME = request.getParameter("FNAME");

		log.info(LAT);
		log.info(LON);
		log.info(FNAME);

		ReviewDTO rDTO = new ReviewDTO();
		rDTO.setCampName(FNAME);
		HashMap<String, String> rMap = new HashMap<>();
		rMap.put("campName", FNAME);
		List<ReviewDTO> rList = new ArrayList<>();
		
		try {
			rList = reviewservice.getReviewList(rMap);
			log.info(rList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("LAT", LAT);
		model.addAttribute("LON", LON);
		model.addAttribute("rList", rList);
		
		return "/camp/CampDetail";
	}

	@RequestMapping(value = "/ReviewAdd")
	public String ReviewAdd(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String point = request.getParameter("point");
		String reviewContent = request.getParameter("reviewContent");
		String reviewWriter = (String) session.getAttribute("SS_userEmail");
		String userSeq = (String) session.getAttribute("SS_userSeq");
		String camp = request.getParameter("camp");
		String lat = request.getParameter("lat");
		String lon = request.getParameter("lon");
		log.info(point);
		log.info(reviewContent);
		log.info(reviewWriter);
		log.info(userSeq);
		log.info(camp);
		log.info(lat);
		log.info(lon);
		ReviewDTO rDTO = new ReviewDTO();

		rDTO.setReviewContent(reviewContent);
		rDTO.setReviewSp(point);
		rDTO.setReviewWriter(reviewWriter);
		rDTO.setCampName(camp);
		rDTO.setUserSeq(userSeq);

		int result = 0;

		String msg, url;
		result = reviewservice.reviewAdd(rDTO);
		log.info(result);
		if (result == 1) {
			msg = "리뷰를 등록하였습니다.";
			url = "/CampDetail.do?LAT=" + lat + "&LON=" + lon+"&FNAME="+camp;
		} else {
			msg = "리뷰 등록 실패";
			url = "/CampDetail.do?LAT=" + lat + "&LON=" + lon+"&FNAME="+camp;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/redirect";
	}
	
	@RequestMapping(value = "/reviewDel")
	public String reviewDel(HttpServletRequest request,Model model) throws Exception {
		ReviewDTO rDTO = new ReviewDTO();

		rDTO.setReviewSeq(request.getParameter("Rno"));
		int res=0;
		String camp = request.getParameter("camp1");
		String lat = request.getParameter("lat1");
		String lon = request.getParameter("lon1");
		log.info(camp);
		log.info(lat);
		log.info(lon);
		log.info(request.getParameter("Rno"));
		String msg,url;
		res=reviewservice.reviewDel(rDTO);
		if(res==1) {
			msg = "리뷰를 삭제하였습니다.";
			url ="/CampDetail.do?LAT=" + lat + "&LON=" + lon+"&FNAME="+camp;
		} else {
			msg = "리뷰 삭제를 실패하였습니다.";
			url = "/CampDetail.do?LAT=" + lat + "&LON=" + lon+"&FNAME="+camp;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "redirect";
	}
	@RequestMapping(value = "/reviewMod")
	public String reviewMod(HttpServletRequest request,Model model,HttpSession session) throws Exception {
		ReviewDTO rDTO = new ReviewDTO();

		String reviewContent = request.getParameter("reviewContent");
		rDTO.setReviewSeq(request.getParameter("reviewSeq"));
		rDTO.setReviewSp(request.getParameter("point"));
		rDTO.setReviewUpnum((String)session.getAttribute("SS_userSeq"));
		rDTO.setReviewContent(reviewContent);
		int res=0;
		String camp = request.getParameter("camp1");
		String lat = request.getParameter("lat1");
		String lon = request.getParameter("lon1");
		log.info(camp);
		log.info(lat);
		log.info(lon);
		log.info(request.getParameter("point"));
		log.info(reviewContent);
		String msg,url;
		res=reviewservice.reviewMod(rDTO);
		if(res==1) {
			msg = "리뷰를 수정하였습니다.";
			url ="/CampDetail.do?LAT=" + lat + "&LON=" + lon+"&FNAME="+camp;
		} else {
			msg = "리뷰 수정을 실패하였습니다.";
			url = "/CampDetail.do?LAT=" + lat + "&LON=" + lon+"&FNAME="+camp;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "redirect";
	}
	
}
