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

  <title>메일 전송폼</title>

  <!-- Custom fonts for this template-->
  <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-12">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">메일 보내기</h1>
                  </div>
                  <form class="user" action="/mail/sendMail.do"method="POST">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="toMail" aria-describedby="emailHelp" placeholder="받는사람">
                    </div>
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="title" placeholder="메일제목">
                    </div>
                   <div class="form-group">
                      <textarea class="form-control form-control-user" name="contents" placeholder="메일내용" style="height:20rem; border-radius:2rem;"></textarea>
                    </div>
                    <div style="display: flex;">
                    	<div class="col-lg-6">
                    	<input type="reset" class="btn btn-primary btn-user btn-block" value="다시쓰기">
                   		</div>
                   		<div class="col-lg-6">
                    	<input type="submit" class="btn btn-primary btn-user btn-block" value="전송하기">
                   		</div>
                  	</div>
                  </form>
                  
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/vendor/jquery/jquery.min.js"></script>
  <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/js/sb-admin-2.min.js"></script>

</body>

</html>
