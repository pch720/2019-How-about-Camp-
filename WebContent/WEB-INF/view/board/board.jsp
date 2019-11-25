<%@page import="poly.dto.PagingDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	List<BoardDTO> bList=(List<BoardDTO>)request.getAttribute("bList");
	PagingDTO paging= (PagingDTO)request.getAttribute("paging");
	
	SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
			
	Date time = new Date();
			
	String time1 = format1.format(time);
%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>게시물 보기</title>

  <!-- Custom fonts for this theme -->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Theme CSS -->
  <link href="css/freelancer.min.css" rel="stylesheet">

  <link href="/css/board.css" rel="stylesheet">
  <link href="/summernote/summernote-bs4.css" rel="stylesheet">
</head>

<body id="page-top">
<%@ include file="/Include/header.jsp"%>
<script src="/summernote/summernote-bs4.min.js"></script>
<script src="/summernote/summernote-bs4.js"></script>
<script src="/summernote/lang/summernote-ko-KR.js"></script>

    <div class="container d-flex align-items-center flex-column">
    <img src="/img/logo.png" style="margin-top: 25.6%;width: 112%;">
    </div>

	<div style="width: 100%; padding-top: 1%;margin-bottom: 5%;">
		<div style="width:70%;margin:0 auto;text-align: center;">
			<div class="boardTitle nanum" style="font-size:3rem">게시판</div>
			<div style="color: rgba(0,0,0,0.3); font-size:0.8rem">캠핑어때의 소식과 캠핑의 정보를 보여드립니다.</div>
			<hr style="margin: 1% 0px 3% 0px;">
		</div>
		
		<div class="listWrapper">
			<% 
			//로그인 안한경우
			if (userEmail==null) {%>
				<div></div>
			<% }
			//로그인한경우
			else {
			%>
			<div><button style="float:right; color:white; margin-bottom:1%; background-color:#1ABC9C" class="btn" onclick="location.href='boardAdd.do'">글쓰기</button></div>		
				<div></div>
			<% }%>
			<div class="listHead">
				<div class="listNum">번호</div>
				<div class="listTitle">제목</div>
				<div class="listWriter">게시글 종류</div>
				<div class="listWriter">작성자</div>
				<div class="listReadCnt">조회수</div>
				<div class="listWhen">작성일</div>
			</div>
			<%for (int i=0; i<bList.size(); i++) {
				int number=paging.getListCnt()-i-((paging.getPage()-1)*15);
			%>
			
			<div class="listTag">
				<div class="listNum"><%=number%></div>
				<div class="listTitle" onclick="location.href='boardDetail.do?no=<%=bList.get(i).getBoardSeq() %>&Pno=1'"><a href="#"><%=bList.get(i).getBoardTitle().replace(">","&gt;").replace("<","&lt;").replace("'","&#39;").replace("script", "")  %>
				<%if(bList.get(i).getBoardWritedate().equals(time1)) {%> <img src='img/new.jpg'  style="vertical-align: super;"/><%} %></a></div>
				<div class="listWriter"><%=bList.get(i).getBoardNotice() %></div>
				<div class="listWriter"><%=bList.get(i).getBoardWriter() %></div>
				<div class="listReadCnt"><%=bList.get(i).getBoardCount() %></div>
				<div class="listWhen"><%=bList.get(i).getBoardWritedate() %></div>
			</div>
			<% } %>
			<div class="listHead"></div>
			<div id="pNumWraaper">
			<%
				if(paging.isPrev()==true) { %>
					<a class="pNumStart" href="/board.do?Pno=<%=paging.getStartPage()-10%>">이전</a>
			<%}	%>
			
			<% for(int a= paging.getStartPage(); a <= paging.getEndPage(); a++){
				if(paging.getPage()==a) { %>
					<div class='pNum' style="background-color:#1abc9c;color:white;"><%=a%></div>
			<%} else {%>
					<a class='pNum' href="/board.do?Pno=<%=a%>"><%=a%></a>
			<%}}%>
			<%
				if(paging.isNext()==true) { %>
					<a class="pNumEnd" href="/board.do?Pno=<%=paging.getEndPage()+1%>">다음</a>
			<%}	%>
			</div>
		</div>
	</div>
  <script type="text/javascript">
  $('#b').css({
	    color: "#1ABC9C"
	});
  </script>
<%@ include file="/Include/footer.jsp"%>

</html>
