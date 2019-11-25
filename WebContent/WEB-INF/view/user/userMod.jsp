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

  <title>회원정보 수정 페이지</title>

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
                <h1 class="h4 text-gray-900 mb-4">회원정보 수정</h1>
              </div>
             	<p class="mb-4"style="text-align: center;">새로운 회원 정보를 입력하시고<br/> 정보를 변경해주세요!</p>
              <div class="mb-3 mb-sm-0" style="margin-top: 15%;">
	<!-- 이름변경 form -->
	
			<form action="/userModproc.do" method="POST" class="user">
			<input type="hidden" id="seq" name="userSeq" value="<%=userSeq%>">
			<div class="form-group">
                		이름
                </div>
			<div class="form-group" style="display:flex;">
                	<input type="text" class="form-control form-control-user" id="name" name="userName" value="<%=userName%>">
                	<input type="submit"class="btn btn-primary btn-user btn-block col-lg-3"style="width: 25%;min-width: 92px;"value="이름변경" onclick="return NC();">
                </div>
    <!-- 휴대폰 번호 변경 form -->           
                <div class="form-group">
                		휴대폰 번호
                </div>
                <div class="form-group"style="display:flex;">
                	<input type="text" class="form-control form-control-user  col-lg-9" id="phone" name="userPhone" value="<%=userPhone%>" >
                	<input type="button"class="btn btn-primary btn-user " id="pCheck" style="width: 25%;min-width: 92px;"value="중복확인">
                	<input type="hidden"class="btn btn-primary btn-user " id="pChange" style="width: 25%;min-width: 92px;"value="번호변경">
                </div>
    <!-- 이메일 변경 form -->
                <div class="form-group">
                		이메일 주소
                </div>
                <div class="form-group">
                <input type="text" class="form-control form-control-user" id="email1" name="userEmail" value="<%=userEmail%>" >
               	</div>
               <div class="form-group">
                	<input type="button" class="btn btn-primary btn-user btn-block" id="eCheck" value="이메일 중복확인">
                </div>
                <div class="form-group">
                <input type="hidden" class='btn btn-primary btn-user btn-block' id="showreq" value="인증번호 요청">
                </div>
                <div class="form-group">
                	<input type="hidden" class="form-control form-control-user" id="ib" name="" placeholder="인증번호 6자리 입력">
                </div>
                <div class="form-group">
                	<input type="hidden" class="btn btn-primary btn-user btn-block" id="ic" value="인증번호 확인">
                	<input type="hidden" class="btn btn-primary btn-user btn-block" id="eChange" value="이메일 변경">
                </div>
                </form> 
                	<hr>
                  <div class="text-center">
                    <a class="btn btn-primary btn-user btn-block" href="/findPw.do">비밀번호 변경</a>
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
<%@ include file="/Include/footer.jsp"%>

<script type="text/javascript">
$(function(){
	
	$("#pCheck").click(function(){
		var phone=$("#phone").val();
		var re1=/^[0-9]{10,11}$/
		console.log(phone);
		if(phone==""){
			alert("새로 사용하실 휴대폰 번호를 입력해 주세요.");
			$("#phone").focus();
		}else if(phone=="<%=userPhone%>"){
			alert("회원님께서 이미 사용중인 번호 입니다.");
			phone.focus();
			return false;
			
		}
		
		else{
		$.ajax({
			url : "/pCheck.do",
			type : 'POST',
			data : {'phone':phone},
			success : function(data){
				console.log(data);
				if(!re1.test(phone)) {
					alert("휴대폰 번호 형식을 확인해주세요.");
					$("#phone").focus();
				}else{
					
					if(data == 0){
						alert("사용 가능한 휴대폰 번호 입니다.");
						$("#pCheck").attr('value','번호변경')
						$("#pCheck").attr('type','hidden')
						$("#pChange").attr('type','submit')
					}else{
						alert("이미 사용중인 휴대폰 번호 입니다.");
						$("#phone").focus();
						}
					}
				},
			error : function(error){
					alert("error : " + error);
			}
		});
		}});
});
$(function(){
	
	$("#eCheck").click(function(){
		var email=$("#email1").val();
		var eCheck=$("#eCheck").val();
		var re2 =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		console.log(email);
		if(email==""){
			alert("새로 사용하실 이메일을 입력해 주세요.");
			$("#email").focus();
		}else if(email=="<%=userEmail%>"){
			alert("회원님께서 이미 사용중인 이메일 입니다.");
			phone.focus();
			return false;
		}
		
		else{
		$.ajax({
			url : "/eCheck.do",
			type : 'POST',
			data : {'email':email},
			success : function(data){
				console.log(data);
				if(!re2.test(email)) {
					alert("이메일 형식을 확인해주세요.");
					$("#email").focus();
					return false;
				} else {
						if(data == 0){
							alert("사용 가능한 이메일 입니다.");
							$("#ib").focus();
							$('#showreq').attr('type','button')
						}else{
							alert("이미 사용중인 이메일 입니다.");
							$("#email").focus();
							}
						}
			},
			error : function(error){
					alert("error : " + error);
			}
		});
		}});
});
$(function(){

	$("#showreq").click(function(){
		var email=$("#email1").val();
		
		console.log(email);
	
		$.ajax({
			url : "/mailSending.do",
			type : 'POST',
			data : {'email':email},
			success : function(data){
				console.log(data);
				
						if(data=="0"){
							alert("인증번호전송에 실패했습니다.");
						}else{
							alert("입력하신 이메일로 인증번호를 전송했습니다.");
							$('#showreq').attr('type','hidden')
							$('#ib').attr('type','text')
							$('#ic').attr('type','button')
							$("#ib").focus();
							}
						
			},
			error : function(error){
					alert("error : " + error);
			}
		});
		});
});
$(function(){
	
	$("#ic").click(function(){
		var ib=$("#ib").val();
		var eCheck=$("#eCheck").val();
		
		console.log(ib);
		if(ib==""){
			alert("인증번호를 입력해 주세요.");
			$("#ib").focus();
		}else{
		$.ajax({
			url : "/iCheck.do",
			type : 'POST',
			data : {'ib':ib},
			success : function(data){
				console.log(data);
				
					if(data == 1){
						alert("인증에 성공하였습니다.");
						$("#pw").focus();
						$('#ic').attr('type','hidden')
						$('#eCheck').attr('type','hidden')
						$('#ib').attr('type','hidden')
						$('#email').prop('readonly',true);
						$('#eChange').attr('type','submit')
					}else{
						alert("인증에 실패하였습니다.");								
						$("#ib").focus();
						}
					},
			
			error : function(error){
					alert("error : " + error);
			}
		});
	}});
});	
function NC(){
	var name = document.getElementById("name");
	
	if(name.value==""){
		alert("새로 사용하실 이름을 입력해 주세요.")
		name.focus();
		return false;
	}
	else if(name.value=="<%=userName%>") {
		alert("회원님께서 이미 사용중인 이름입니다.");
		name.focus();
		return false;
	}
}
</script>
  <script type="text/javascript">
  $('#um').css({
	    color: "#1ABC9C"
	});
  $('#navbardrop').css({
	    color: "#1ABC9C"
	});
  </script>
</body>

</html>
