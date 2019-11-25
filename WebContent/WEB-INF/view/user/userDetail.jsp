<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userSeq=(String)session.getAttribute("SS_userSeq");
	String userName=(String)session.getAttribute("SS_userName");
	String userPhone=(String)session.getAttribute("SS_userPhone");
	String userRegdate=(String)session.getAttribute("SS_userRegdate");
	String userUpdate=(String)session.getAttribute("SS_userUpdate");
	String userUpnum=(String)session.getAttribute("SS_userUpnum");
%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>회원정보 상세 페이지</title>

  <!-- Custom fonts for this theme -->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Theme CSS -->
  <link href="css/freelancer.min.css" rel="stylesheet">

</head>

<body id="page-top">

 <%@ include file="/Include/header.jsp"%>
  
<!--컨텐츠 -->
		
		<div class="container"style="margin-top:7rem;">

    <div class="card o-hidden border-0 shadow-lg my-5"style="width: 60%; margin: 0 auto;min-width: 320px;max-width: 500px;">
      <div class="card-body p-0">
        <div class="row">
          <div class="col-lg-12">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">회원정보 상세</h1>
              </div>
             
              <div class="mb-3 mb-sm-0" style="margin-top: 15%;">
              <div class="form-group">
                		회원 번호
                </div>
                  
                    <input type="text" class="form-control form-control-user" id="" name="userSeq" placeholder="<%=userSeq %>" readonly>
			<div class="form-group">
                		이름
                </div>
			<div class="form-group">
                	<input type="text" class="form-control form-control-user" id="name" name="userName" placeholder="<%=userName%>" readonly>
                </div>
                <div class="form-group">
                		휴대폰 번호
                </div>
                <div class="form-group">
                	<input type="text" class="form-control form-control-user pch" id="phone" name="userPhone" placeholder="<%=userPhone%>" readonly>
                </div>
                <div class="form-group">
                		이메일 주소
                </div>
                <div class="form-group">
                  <input type="text" class="form-control form-control-user" id="email1" name="userEmail" placeholder="<%=userEmail%>" readonly>
                </div>
                <div class="form-group">
                		회원 가입일
                </div>
                <div class="form-group">  
                    <input type="text" class="form-control form-control-user" id="ur" name="userRegdate" placeholder="<%=userRegdate %>" readonly>
            	</div>
            	<div class="form-group">
                		최근 회원 정보 수정일
                </div>
                <div class="form-group">
                  <%if(userUpdate==null){ %>
                  	<input type="text" class="form-control form-control-user" id="nud" name="userUpdate" placeholder="아직 회원정보를 한번도 수정하지 않았습니다." readonly>
                  	<%}else{ %>
                    <input type="text" class="form-control form-control-user" id="ud" name="userUpdate" placeholder="<%=userUpdate %>" readonly>
 	              	<%} %>
 	            </div>
               <div class="form-group">
                		최근 정보를 수정한 회원의 번호
                </div>
                  <%if(userUpnum==null){ %>
                  	<input type="text" class="form-control form-control-user" id="nun" name="userUpnum" placeholder="아직 회원정보를 한번도 수정하지 않았습니다." readonly>
                  	<%}else{ %>
                    <input type="text" class="form-control form-control-user" id="un" name="userUpnum" placeholder="<%=userUpnum %>" readonly>     
                  	<%} %>
                
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
  $('#ud').css({
	    color: "#1ABC9C"
	});
  $('#navbardrop').css({
	    color: "#1ABC9C"
	});
  </script>
<%@ include file="/Include/footer.jsp"%>
</body>


</html>
