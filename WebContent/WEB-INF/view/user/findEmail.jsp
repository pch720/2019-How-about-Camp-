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

  <title>이메일 찾기 페이지</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
 

  <!-- Custom styles for this template-->
  <link href="css/freelancer.min.css" rel="stylesheet">
</head>

<body class="bg-gradient-primary">

  <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5"style="width: 60%; margin: 0 auto;min-width: 320px;">
          <div class="card-body p-0">
            <div class="row">
              <div class="col-lg-12">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-2">이메일 주소 찾기</h1>
                    <p class="mb-4">이름과 휴대폰번호를<br/> 입력해주세요!</p>
                  </div>
                  <form class="user" onsubmit="return uhs();" action="/findE.do" method="POST">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="name" name="userName" placeholder="이름">
                    </div>
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="phone" name="userPhone" placeholder="휴대폰 번호">
                    </div>
                    <input type="submit" class="btn btn-primary btn-user btn-block" value="이메일 찾기">
                      	
                    
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="/findPw.do">비밀번호 변경</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="/userReg.do">캠핑어때 회원가입 하기</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="/index.do">메인화면으로 가기</a>
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
  <script type="text/javascript">
  function uhs(){
		var name = document.getElementById("name");
		var phone = document.getElementById("phone");
		var re=/^[0-9]{10,11}$/
		
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
		if(!re.test(phone.value)) {
			console.log(phone);
			alert("휴대폰 번호의 형식을 확인해주세요.");
			$("#phone").focus();
			return false;
		}
		
	}
  </script>
</body>

</html>