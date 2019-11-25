<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>


  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>회원 가입 페이지</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
 

  <!-- Custom styles for this template-->
  <link href="css/freelancer.min.css" rel="stylesheet">
<script type="text/javascript">
function pwCheck(){
	var pw = $("#pw").val();
	var pwc = $("#pwc").val();
	console.log(pw);
	console.log(pwc);
	var contents = ""
	if(pw == pwc) {
		contents += "<div class='alert alert-success'>일치합니다.</div>";
		$('#showPwCheck').html(contents);
	} else {
		contents += "<div class='alert alert-danger'>일치하지 않습니다.</div>";
		$('#showPwCheck').html(contents);
	}
}

</script>
</head>

<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5"style="width: 60%; margin: 0 auto;min-width: 320px;max-width: 500px;">
      <div class="card-body p-0">
        <div class="row">
          <div class="col-lg-12">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
              </div>
              <form id="userReg" action="/userRegProc.do" method="POST" class="user">
              	<div class="form-group">
                	<input type="text" class="form-control form-control-user" id="name" name="userName" placeholder="이름">
                </div>
                <div class="form-group">
                	<input type="text" class="form-control form-control-user" id="phone" name="userPhone" placeholder="휴대폰 번호">
                </div>
                <div class="form-group">
                	<input type="button" class="btn btn-primary btn-user btn-block" id="pCheck" value="휴대폰 번호 중복확인">
                	<input type="hidden" id="conf" value="0">
                </div>
                <div class="form-group">
                  <input type="text" class="form-control form-control-user" id="email" name="userEmail" placeholder="이메일 주소">
                </div>
                <div class="form-group">
                	<input type="button" class="btn btn-primary btn-user btn-block" id="eCheck" value="이메일 중복확인">
                	<input type="hidden" id="conf1" value="0">	
                </div>
                <div class="form-group">
                <input type="hidden" class='btn btn-primary btn-user btn-block' id="showreq" value="인증번호 요청">
                </div>
                <div class="form-group">
                	<input type="hidden" class="form-control form-control-user" id="ib" name="" placeholder="인증번호 6자리 입력">
                </div>
                <div class="form-group">
                	<input type="hidden" class="btn btn-primary btn-user btn-block" id="ic" value="인증번호 확인">
               		<input type="hidden" id="conf2" value="0">
                </div>
                
                	
                
                
                <div class="form-group">
                    <input type="password" class="form-control form-control-user" id="pw" name="userPassword" placeholder="비밀번호">
                </div>
                  <div class="form-group">
                    <input type="password" class="form-control form-control-user" id="pwc" placeholder="비밀번호 확인" onkeyup="pwCheck()">
                  </div>
                
                <div id="showPwCheck" style="text-align: center;"></div>
              
                <button id="uhs" class="btn btn-primary btn-user btn-block">회원가입하기 </button>
              </form>
              
              <hr>
              <div class="text-center">
                <a class="small" href="findEmail.do">아이디/비밀번호 찾기</a>
              </div>
              <div class="text-center">
                <a href="index.do" class="small">메인화면으로 가기</a>
              </div>
                
            </div>
          </div>
        </div>
      </div>
    </div>
  
  </div>
  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</body>
<script type="text/javascript">
	
	var pCheck=0;
	$(function(){
		
		$("#pCheck").click(function(){
			var phone=$("#phone").val();
			var re1=/^[0-9]{10,11}$/
			console.log(phone);
			if(phone==""){
				alert("휴대폰 번호를 입력해 주세요.");
				$("#phone").focus();
			}else{
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
							$('#conf').val("1");
							$("#email").focus();
							pCheck=1;
							
						}else{
							alert("이미 사용중인 휴대폰 번호 입니다.");
							$('#conf').val("0");
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
	var eCheck=0;
	$(function(){
		
		$("#eCheck").click(function(){
			var email=$("#email").val();
			var eCheck=$("#eCheck").val();
			var re2 =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			console.log(email);
			if(email==""){
				alert("이메일 주소를 입력해 주세요.");
				$("#email").focus();
			}else{
			$.ajax({
				url : "/eCheck.do",
				type : 'POST',
				data : {'email':email},
				success : function(data){
					console.log(data);
					if(!re2.test(email)) {
						alert("이메일 주소 형식을 확인해주세요.");
						$("#email").focus();
						return false;
					} else {
							if(data == 0){
								alert("사용 가능한 이메일 입니다.");
								$('#conf1').val("1");
								$("#ib").focus();
								pCheck=1;
								$('#showreq').attr('type','button')
							}else{
								alert("이미 사용중인 이메일 입니다.");
								$('#conf1').val("0");
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
			var email=$("#email").val();
			
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
							$('#conf2').val("1");
							$("#pw").focus();
							$('#ic').attr('type','hidden')
							$('#eCheck').attr('type','hidden')
							$('#ib').attr('type','hidden')
							$('#email').prop('readonly',true);
						}else{
							alert("인증에 실패하였습니다.");								
							$('#conf1').val("0");
							$("#ib").focus();
							}
						},
				
				error : function(error){
						alert("error : " + error);
				}
			});
		}});
	});	
	
	$(function(){
		$("#uhs").click(function(){

			var  name = document.getElementById("name");
			var  phone = document.getElementById("phone");
			var  email = document.getElementById("email");
			var  pw = document.getElementById("pw");			
			var  pwc = document.getElementById("pwc");
			
		 	if(name.value==""){
				alert("이름을 입력해 주세요.")
				name.focus();
				return false;
			}
			if(phone.value==""){
				alert("휴대폰 번호를 입력해 주세요.")
				phone.focus();
				return false;
			}
			if(email.value==""){
				alert("이메일을 입력해 주세요.")
				email.focus();
				return false;
			} 
			 if(pw.value==""){
				alert("비밀번호를 입력해 주세요.")
				pw.focus();
				return false;
			}
			if(pwc.value==""){
				alert("비밀번호 확인을 입력해 주세요.")
				pwc.focus();
				return false;
			}
			if(pwc.value!=pw.value){
				alert("비밀번호와 똑같이 입력해 주세요.")
				pwc.focus();
				return false;
			}
			if(conf.value==0){
				alert("휴대폰 중복확인을 해주세요.")
				return false;
			}
			if(conf1.value==0){
				alert("이메일 중복확인을 해주세요.")
				return false;
			}
			if(conf2.value==0){
				alert("인증번호 확인을 해주세요.")
				return false;
			}
			$("#userReg").submit()
		})
	})
</script>
</html>