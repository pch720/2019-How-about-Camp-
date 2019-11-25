<%@page import="poly.dto.PagingDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<UserDTO> uList=(List<UserDTO>)request.getAttribute("uList");
	PagingDTO paging= (PagingDTO)request.getAttribute("paging");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>회원관리 페이지</title>

  <!-- Custom fonts for this theme -->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Theme CSS -->
  <link href="css/freelancer.min.css" rel="stylesheet">

  <link href="/css/board.css" rel="stylesheet">

</head>

<body id="page-top">
<%@ include file="/Include/header.jsp"%>

<div class="container d-flex align-items-center flex-column">
    <img src="/img/logo.png" style="margin-top: 25.6%;width: 112%;">
    </div>
<div style="width: 100%; padding-top: 1%;margin-bottom: 5%;">
		<div style="width:70%;margin:0 auto;text-align: center;">
			<div class="boardTitle nanum" style="font-size:3rem">회원관리</div>
			<div style="color: rgba(0,0,0,0.3); font-size:0.8rem">캠핑어때의 회원들의 정보입니다.</div>
			<hr style="margin: 1% 0px 3% 0px;">
		</div>
		<div class="listWrapper">
			<div></div>
			<div class="listHead">
				<div class="listReadCnt">이름</div>
				<div class="listemail">이메일 주소</div>
				<div class="listWhen">휴대폰 번호</div>
				<div class="listWhen">가입일</div>
				<div class="listWhen">정보 수정일</div>
				<div class="listReadCnt">상태</div>
				<div class="listReadCnt">관리</div>
			</div>
			<%for (int i=0; i<uList.size(); i++) {
				int number=paging.getListCnt()-i-((paging.getPage()-1)*15);
			%>
			<%if(uList.get(i).getUserAss().equals("2")) {%>
			<div class="listTag" style="color:red;background-color: #f5c6cb;"><%}else{ %>
			<div class="listTag"><%} %>
				<div class="listReadCnt"><%=uList.get(i).getUserName() %></div>
				<div class="listemail"><%=uList.get(i).getUserEmail() %></div>
				<div class="listWhen"><%=uList.get(i).getUserPhone() %></div>
				<div class="listWhen"><%=uList.get(i).getUserRegdate() %></div>
				<div class="listWhen"><%if(uList.get(i).getUserUpdate()==null){%>-<%}else{%><%=uList.get(i).getUserUpdate() %><%} %></div>
				<div class="listReadCnt"><%if(uList.get(i).getUserAss().equals("1")){%>관리자<%}else if(uList.get(i).getUserAss().equals("0")){%>사용자<%}else{ %>정지<%} %></div>
				<div class="listReadCnt">
				<form id="admin<%=number %>" action="/AdminMod.do"method="POST" class="user">
					<input type="hidden" name="userEmail" value="<%=uList.get(i).getUserEmail()%>">
					<input type="hidden" id="Aass<%=number%>" name="userAss" value="<%=uList.get(i).getUserAss()%>">
					<input type="hidden" id="Aname<%=number%>" name="userName" value="<%=uList.get(i).getUserName()%>">
					<input type="hidden" name="Pno" value="<%=paging.getPage()%>">
					
					<select name="job" onchange="return Admin(<%=number%>);" id="Ajob<%=number%>"style="min-width:80px;width:15%;border: none;<%if(uList.get(i).getUserAss().equals("2")){%>background-color: #f5c6cb;color: red;<%}%>">
					    <option value="0" selected disabled>선택</option>
					    <%if (uList.get(i).getUserAss().equals("1")) { %>
					    <option value="1">사용자</option>
					    <%}else if(uList.get(i).getUserAss().equals("0")){ %>
					    <option value="2">관리자</option>
					    <%} %>
					    <%if (uList.get(i).getUserAss().equals("2")){ %>
					    <option value="3">활성화</option>
					    <%}else {%>
					    <option value="4">비활성화</option>
					    <%} %>
				    	<option value="5">삭제</option>
					</select>
				</form>
				</div>
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
	</div>
	<script type="text/javascript">
	
	$(document).ready(function() { 
		if(<%=userAss%>!=1){
			alert("관리자만 이용할 수 있슴니다.");
			location.href="/index.do";
		}
		});
	
			function Admin(number){
				var job = $('#Ajob'+number).val();
				var name =$('#Aname'+number).val();
				var result;
				
				if (job == "1") {
					result = confirm(name + "님의 관리자 권한을 삭제하시겠습니까?");
				} else if (job == "2") {
					result = confirm(name + "님에게 관리자 권한을 추가하시겠습니까?");
				} else if (job == "3"){
					result = confirm(name + "님의 정지를 해제하시겠습니까?");
				} else if (job == "4"){
					result = confirm(name + "님을 정지 상태로 만드시겠습니까?");
				} else{
					result = confirm(name + "님의 계정을 삭제하시겠습니까?");
				}
				console.table(result)
				if (result) {
					$('#admin'+number).submit();
				} else {
					alert("취소되었습니다.");
					$('#Ajob'+number).val('0');
				}
			};
	</script>
  <script type="text/javascript">
  $('#admin').css({
	    color: "#1ABC9C"
	});
  </script>
<%@ include file="/Include/footer.jsp"%>
</body>
</html>