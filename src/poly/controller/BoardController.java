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

import poly.dto.BoardDTO;
import poly.dto.PagingDTO;
import poly.service.IBoardService;

@Controller
public class BoardController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="BoardService")
	private IBoardService boardservice;
	//게시판 
	@RequestMapping(value="/board")
	public String board(HttpServletRequest request, Model model)throws Exception{
		// 페이징
		int page = Integer.parseInt(request.getParameter("Pno"));		
		int listCnt = boardservice.TotalCount(); // 총 게시글 개수

		PagingDTO paging = new PagingDTO();
		
		paging.pageInfo(page, listCnt);
		HashMap<String, Integer> hMap = new HashMap<>();
		int i = paging.getStartList();
		int j = paging.getListSize();
		hMap.put("startlist", i);
		hMap.put("listsize", j);
		
		List<BoardDTO> bList = new ArrayList<>();
		try {
			bList = boardservice.getBoardList(hMap);
			log.info(bList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("bList",bList);
		model.addAttribute("paging",paging);
		
		return "/board/board";
	}
	//게시글 추가
	@RequestMapping(value="/boardAdd")
	public String boardAdd(HttpServletRequest request,Model model)throws Exception{
		String boardSeq=(String)request.getParameter("boardSeq");
		if(boardSeq==null)
			boardSeq="0";
		log.info(boardSeq);
		model.addAttribute(boardSeq);
		return "/board/boardAdd";
	}
	@RequestMapping(value="/boardAddproc")
	public String boardAddproc(HttpServletRequest request,Model model,HttpSession session)throws Exception{
		String boardTitle=request.getParameter("boardTitle");
		String boardContent=request.getParameter("boardContent");
		String boardNotice=request.getParameter("boardNotice");
		String boardWriter=(String)session.getAttribute("SS_userEmail");
		String userSeq=(String)session.getAttribute("SS_userSeq");
		log.info(boardNotice);
		log.info(boardContent);
		log.info(boardTitle);
		log.info(boardWriter);
		
		BoardDTO bDTO =new BoardDTO();
		bDTO.setBoardTitle(boardTitle.replace("script",""));
		bDTO.setBoardContent(boardContent);
		bDTO.setBoardNotice(boardNotice);
		bDTO.setBoardWriter(boardWriter);
		bDTO.setUserSeq(userSeq);
		int result = 0;
		
		String msg, url;
		result=boardservice.boardAddproc(bDTO);
		log.info(result);
		if(result ==1) {
			msg="게시물 등록 성공";
			url="/board.do?Pno=1";
		}else {
			msg="게시물 등록 실패";
			url="/boardAdd.do";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/redirect";
	}
	//게시글 상세보기
	@RequestMapping(value="/boardDetail")
	public String boardDetail(HttpServletRequest request,Model model,HttpSession session)throws Exception{
		String boardSeq=request.getParameter("no");
		log.info(boardSeq);
		BoardDTO bDTO =new BoardDTO();
		bDTO.setBoardSeq(boardSeq);
		bDTO = boardservice.boardDetail(bDTO);
		int count=Integer.parseInt(bDTO.getBoardCount());
		count++;
		bDTO.setBoardCount(Integer.toString(count));
		int result=boardservice.count(bDTO);
		log.info(result);
		log.info(bDTO.getBoardContent());
		log.info(bDTO.getBoardTitle());
		log.info(bDTO.getBoardCount());
		log.info(bDTO.getBoardWritedate());
		model.addAttribute("boardTitle",bDTO.getBoardTitle());
		model.addAttribute("boardContent",bDTO.getBoardContent());
		model.addAttribute("boardCount",bDTO.getBoardCount());
		model.addAttribute("boardWritedate",bDTO.getBoardWritedate());
		model.addAttribute("boardWriter",bDTO.getBoardWriter());
		model.addAttribute("boardSeq",bDTO.getBoardSeq());
		model.addAttribute("boardUpdate",bDTO.getBoardUpdate());
		
		// 페이징
				int page = Integer.parseInt(request.getParameter("Pno"));		
				int listCnt = boardservice.TotalCount(); // 총 게시글 개수

				PagingDTO paging = new PagingDTO();
				
				paging.pageInfo(page, listCnt);
				HashMap<String, Integer> hMap = new HashMap<>();
				int i = paging.getStartList();
				int j = paging.getListSize();
				hMap.put("startlist", i);
				hMap.put("listsize", j);
				
				List<BoardDTO> bList = new ArrayList<>();
				try {
					bList = boardservice.getBoardList(hMap);
					log.info(bList);
				} catch(Exception e) {
					e.printStackTrace();
				}
		
		model.addAttribute("bList",bList);
		model.addAttribute("paging",paging);
		
		return "/board/boardDetail";
	}
	
	@RequestMapping(value="/boardDelete")
	public String boardDelete(HttpServletRequest request,Model model,HttpSession session)throws Exception{
		String boardSeq=request.getParameter("boardSeq");
		log.info(boardSeq);
		BoardDTO bDTO=new BoardDTO();
		bDTO.setBoardSeq(boardSeq);
		String msg, url;
			int result=0;
			result=boardservice.boardDelete(bDTO);
			log.info(result);
			if(result==1) {
				msg="글이 삭제되었습니다.";
				url="/board.do?Pno=1";				
			}else {
				msg="글 삭제에 실패하었습니다.";
				url="/boardDetail.do?no="+boardSeq+"&Pno=1";
			}
			
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/redirect";
	
	}
	//게시글 수정
		@RequestMapping(value="/boardMod")
		public String boardMod(HttpServletRequest request,Model model)throws Exception{
			String boardSeq=request.getParameter("boardSeq");
			log.info(boardSeq);
			BoardDTO bDTO =new BoardDTO();
			bDTO.setBoardSeq(boardSeq);
			bDTO=boardservice.boardDetail(bDTO);
			model.addAttribute("boardTitle",bDTO.getBoardTitle());
			model.addAttribute("boardContent",bDTO.getBoardContent());
			model.addAttribute("baordNotice",bDTO.getBoardNotice());
			model.addAttribute("boardSeq",bDTO.getBoardSeq());
			log.info(bDTO.getBoardSeq());
			return "/board/boardMod";
		}
		@RequestMapping(value="/boardModproc")
		public String boardModproc(HttpServletRequest request,HttpSession session,Model model)throws Exception{
			String boardSeq=request.getParameter("boardSeq");
			String boardTitle=request.getParameter("boardTitle");
			String boardContent=request.getParameter("boardContent");
			String boardNotice=request.getParameter("boardNotice");
			String userSeq=(String)session.getAttribute("SS_userSeq");
			BoardDTO bDTO=new BoardDTO();
			bDTO.setBoardSeq(boardSeq);
			bDTO.setBoardTitle(boardTitle);
			bDTO.setBoardContent(boardContent);
			bDTO.setBoardNotice(boardNotice);
			bDTO.setBoardUpnum(userSeq);
			log.info(boardSeq);
			log.info(boardTitle);
			log.info(boardContent);
			log.info(boardNotice);
			log.info(userSeq);
			
			String msg,url;
			int result=0;
			
				
			result=boardservice.boardMod(bDTO);
			log.info(result);
			if(result==1) {
				msg="글이 수정되었습니다.";
				url="/boardDetail.do?no="+boardSeq+"&Pno=1";
			}else {
				msg="글 수정에 실패하었습니다.";
				url="/boardDetail.do?no="+boardSeq;
			}
				
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			return "/redirect";
		
		}
		//작성 게시물
		@RequestMapping(value="/userBoard")
		public String userBoard(Model model,HttpSession session,HttpServletRequest request)throws Exception{
			String userSeq=(String)session.getAttribute("SS_userSeq");
			// 페이징
			int page = Integer.parseInt(request.getParameter("Pno"));		
			int listCnt = boardservice.myTotalCount(userSeq); // 총 게시글 개수

			PagingDTO paging = new PagingDTO();
			
			paging.pageInfo(page, listCnt);
			HashMap<String, Integer> hMap = new HashMap<>();
			int i = paging.getStartList();
			int j = paging.getListSize();
			hMap.put("startlist", i);
			hMap.put("listsize", j);
			hMap.put("userSeq",Integer.parseInt(userSeq));
			List<BoardDTO> bList = new ArrayList<>();
			try {
				bList = boardservice.userBoard(hMap);
				log.info(bList);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("bList",bList);
			model.addAttribute("paging",paging);
			
			return "/user/userBoard";
		}
		//작성 게시물 상세
		@RequestMapping(value="/userBoardDetail")
		public String userboardDetail(HttpServletRequest request,Model model,HttpSession session)throws Exception{
			String userSeq=(String)session.getAttribute("SS_userSeq");
			String boardSeq=request.getParameter("no");
			log.info(boardSeq);
			BoardDTO bDTO =new BoardDTO();
			bDTO.setBoardSeq(boardSeq);
			bDTO = boardservice.boardDetail(bDTO);
			int count=Integer.parseInt(bDTO.getBoardCount());
			count++;
			bDTO.setBoardCount(Integer.toString(count));
			int result=boardservice.count(bDTO);
			log.info(result);
			log.info(bDTO.getBoardContent());
			log.info(bDTO.getBoardTitle());
			log.info(bDTO.getBoardCount());
			log.info(bDTO.getBoardWritedate());
			model.addAttribute("boardTitle",bDTO.getBoardTitle());
			model.addAttribute("boardContent",bDTO.getBoardContent());
			model.addAttribute("boardCount",bDTO.getBoardCount());
			model.addAttribute("boardWritedate",bDTO.getBoardWritedate());
			model.addAttribute("boardWriter",bDTO.getBoardWriter());
			model.addAttribute("boardSeq",bDTO.getBoardSeq());
			model.addAttribute("boardUpdate",bDTO.getBoardUpdate());
			
			
			
			// 페이징
			int page = Integer.parseInt(request.getParameter("Pno"));						
			int listCnt = boardservice.myTotalCount(userSeq); // 총 게시글 개수

			PagingDTO paging = new PagingDTO();
						
			paging.pageInfo(page, listCnt);
			HashMap<String, Integer> hMap = new HashMap<>();
			int i = paging.getStartList();
			int j = paging.getListSize();
			hMap.put("startlist", i);				
			hMap.put("listsize", j);
			hMap.put("userSeq",Integer.parseInt(userSeq));
			List<BoardDTO> bList = new ArrayList<>();
			try {
				bList = boardservice.userBoard(hMap);
				log.info(bList);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("bList",bList);
			model.addAttribute("paging",paging);
			
			return "/user/userBoardDetail";
		}
}

