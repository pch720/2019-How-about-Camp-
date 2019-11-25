<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String userAss=(String)session.getAttribute("SS_userAss");
 	if(userAss==null)
 		userAss="3";
	String userEmail=(String)session.getAttribute("SS_userEmail");
%>
<!DOCTYPE html>


 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="index.do"><i class="fas fa-campground"></i>캠핑어때<%if(userAss.equals("1")) {%>&nbsp;관리자<%} %></a>
     
      <button class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        Menu
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <%if(userAss.equals("1")) {%>
           <li class="nav-item mx-0 mx-lg-1">
           <a class="nav-link py-3 px-0 px-lg-3 rounded" id=admin href="/UserList.do?Pno=1">
            <i class="fas fa-crown fa-sm fa-fw mr-2 text-gray-400"></i> 
            	회원관리
          </a>
          </li>
          <%} %>
           <li class="nav-item mx-0 mx-lg-1">
            <a class="nav-link py-3 px-0 px-lg-3 rounded " id="c" href="/CampMain.do">
            <i class="fas fa-search-location fa-sm fa-fw mr-2 text-gray-400"></i>
            	캠핑장 검색
            </a>
            
          </li>
          <li class="nav-item mx-0 mx-lg-1 dropdown">
            <a class="nav-link py-3 px-0 px-lg-3 rounded" href="/board.do?Pno=1"id="b">
       		<i class="far fa-clipboard fa-fw mr-2 text-gray-400"></i>     
            	게시판
            </a>
          </li>
          <%if(userEmail!=null) {%>
          <li class="nav-item mx-0 mx-lg-1 dropdown">
            <a class="nav-link dropdown-toggle py-3 px-0 px-lg-3 rounded" href="#" id="navbardrop" data-toggle="dropdown">
            <i class="fas fa-user fa-fw mr-2 text-gray-400"></i>
            	마이페이지</a>
            <div class="dropdown-menu"style="background-color: #2c3e50;border: #2c3e50;padding-left: 4%;padding-top: 0%;min-width: 175px;">
				<a class="nav-link" href="/userDetail.do" id="ud">
				<i class="fas fa-user-check fa-fw mr-2 text-gray-400"></i>
				회원정보 상세</a>
				<a class="nav-link" href="#"data-toggle="modal" data-target="#userMod"id="um">
				<i class="fas fa-user-edit fa-fw mr-2 text-gray-400"></i>
				회원정보 수정</a>
				<a class="nav-link" href="/userBoard.do?Pno=1"id="ub">
				<i class="fas fa-clipboard-check fa-fw mr-2 text-gray-400"></i>
				작성게시글 확인
				</a>
          		<a class="nav-link" href="#" data-toggle="modal" data-target="#deleteModal">
                  <i class="fas fa-user-times fa-fw mr-2 text-gray-400"></i>
                  	회원 탈퇴
                </a>
            </div>
          </li>
          <%} %>
          <%if(userEmail==null) {%>
           <li class="nav-item mx-0 mx-lg-1">
           <a class="nav-link py-3 px-0 px-lg-3 rounded" href="#" data-toggle="modal" data-target="#loginModal">
            <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i> 
            	로그인
          </a>
          </li>
          <%}else{ %>
          <li class="nav-item mx-0 mx-lg-1">
          <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#" data-toggle="modal" data-target="#logoutModal">
           <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> 	
            	로그아웃
          </a>
          </li>
          
          <%} %>
        </ul>
      </div>
    </div>
  </nav>
<!-- 로그인 창 -->
  <div class="portfolio-modal modal fade" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content"style="max-width: 684px;margin: 0px auto;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">
            <i class="fas fa-times"></i>
          </span>
        </button>
        <div class="modal-body text-center">
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-lg-8">
                <!-- Portfolio Modal - Title -->
                <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0">로그인 하기</h2>
                <!-- Icon Divider -->
                <div class="divider-custom">
                  <div class="divider-custom-line"></div>
                  <div class="divider-custom-icon">
                    <i class="fas fa-campground"></i>
                  </div>
                  <div class="divider-custom-line"></div>
                </div>
               
                <form class="user" onsubmit="return uhs();" action="/userReceive.do" method="POST">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="email" name="userEmail" placeholder="이메일 주소">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="pw" name="userPassword" placeholder="비밀번호">
                    </div>
                    
                    <input type="submit" class="btn btn-primary btn-user btn-block" value="로그인">
                  
                  </form>
                	<hr>
                  <div class="text-center">
                    <a class="small" href="/findEmail.do">아이디/비밀번호 찾기</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="/userReg.do">캠핑어때 회원가입 하기</a>
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
    <!-- 회원정보 수정 인증창 -->
  <div class="portfolio-modal modal fade" id="userMod" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content"style="max-width: 684px;margin: 0px auto;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">
            <i class="fas fa-times"></i>
          </span>
        </button>
        <div class="modal-body text-center">
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-lg-8">
                <!-- Portfolio Modal - Title -->
                <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0">회원정보 수정하기</h2>
                <!-- Icon Divider -->
                <div class="divider-custom">
                  <div class="divider-custom-line"></div>
                  <div class="divider-custom-icon">
                    <i class="fas fa-campground"></i>
                  </div>
                  <div class="divider-custom-line"></div>
                </div>
               	<p>회원정보를 수정하기 위해 비밀번호 인증을 해주세요.</p>
                <form class="user" onsubmit="return uhs2()" action="/userReceive.do" method="POST">
                  
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="ipw" name="userPassword" placeholder="비밀번호">
                    </div>
                    <input type="submit" class="btn btn-primary btn-user btn-block" value="회원정보 수정">
                  </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

   <!--로그아웃 창-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">로그아웃을 하시겠습니까?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body"style="padding-top: 0;padding-bottom: 0;">"로그아웃" 버튼을 누르셨습니다. 로그아웃을 하시려면 로그아웃 버튼을 눌러주세요.</div>
        <div class="modal-footer"style="padding-top: 5%;padding-bottom: 5%;">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
          <button class="btn btn-primary" type="button" onclick="location.href='/logout.do'">로그아웃</button>
        </div>
      </div>
    </div>
  </div>
  
    <!--회원 탈퇴 창-->
  <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">회원탈퇴를 하시겠습니까?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body"style="padding-top: 0;padding-bottom: 0;">"회원탈퇴" 버튼을 누르셨습니다. 회원탈퇴를 하시려면 회원탈퇴 버튼을 눌러주세요.</div>
        <div class="modal-footer"style="padding-top: 5%;padding-bottom: 5%;">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
          <button class="btn btn-primary" type="button" onclick="location.href='/userDelete.do'">회원탈퇴</button>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript">
	
	function uhs(){
		var email = document.getElementById("email");
		var pw = document.getElementById("pw");
		var re =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(email.value==""){
			alert("이메일 주소를 입력해 주세요.")
			email.focus();
			return false;
		}
		if(!re.test(email.value)) {
			console.log(email);
			alert("이메일 주소의 형식을 확인해주세요.")
			$("#email").focus();
			return false;
		}
		if(pw.value==""){
			alert("비밀번호를 입력해 주세요.")
			pw.focus();
			return false;
		}

	}
	function uhs2(){
		var ipw=document.getElementById("ipw");
		
		if(ipw.value==""){
			alert("비밀번호를 입력해 주세요.")
			ipw.focus();
			return false;
		}
	}
</script>
