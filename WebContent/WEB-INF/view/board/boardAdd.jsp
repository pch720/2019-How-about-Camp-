<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	String Seq=(String)request.getAttribute("boardSeq");
%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>게시물 추가</title>

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

	<div style="width: 100%; padding-top: 1%; text-align:center; margin:0 auto">
		<a style="font-size:1.5rem;">글쓰기</a>
		<hr>
		<form onsubmit="return buhs();" action="boardAddproc.do" method="POST">
		<div class="form-group">
			<input type="text" class="form-control" style="width: 75%;margin:0 auto;max-width: 1000px;" placeholder="제목을 입력해주세요.(최대 50자)" id="title" name="boardTitle">
		</div>
		<div class="form-group">
			<select class="custom-select col-lg-3"style="width: 75%;max-width: 1000px;"id="notice"name="boardNotice">
               <option selected disabled>게시글 종류</option>
               <option value="캠핑의 기본지식">캠핑의 기본지식</option>
               <option value="경험자들의 팁">경험자들의 팁</option>
               <%if(userAss.equals("1")) {%>
               <option value="공지사항">공지사항</option>
               <%} %>
            </select>
		</div>
		<div style="margin:0 auto;text-align:justify;width: 75%;max-width: 1000px;">
			<textarea id="summernote" name="boardContent"></textarea>
		</div>
		<div>
		<button type="button" class="btn" style="background-color:rgba(235,70,70,0.7); color:white; margin-top: 2%;margin-right:2%;margin-bottom:2%;" onclick="location.href=ref">뒤로가기</button>
		<input type="submit" class="btn" style="background-color:rgb(129, 114, 242);margin-top:2%;margin-left:2%;margin-bottom:2%;; color:white;" value="작성하기">
		</div>
    <script type="text/javascript">
	document.querySelector('#summernote').value ='';
    $(document).ready(function() {
      $('#summernote').summernote({
    	  height:500,
    	  lang: 'ko-KR',
    	  fontNames : [ '맑은고딕' , 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
    	  fontNamesIgnoreCheck : ['맑은고딕' ],
    	  placeholder: '내용을 입력해주세요.(최대2000자)',
      });
    });
    </script>
		</form>
	</div>
	<script type="text/javascript">
	function buhs(){
		var title = document.getElementById("title");
		var notice = document.getElementById("notice");
		var content = document.getElementById("summernote");
		if(title.value==""){
			alert("제목을 입력해 주세요.");
			title.focus();
			return false;
		}else if(notice.value!="캠핑의 기본지식"&&notice.value!="경험자들의 팁"&&notice.value!="공지사항"){
			alert("게시글 종류를 선택해 주세요.");
			notice.focus();
			return false;
		}else if(content.value==""){
			alert("내용을 입력해 주세요.");
			$('#summernote').summernote('focus');
			return false;
		}
	}
	</script>
 <script type="text/javascript">
  var ref =  document.referrer;
	console.log(ref);
if(ref.startsWith("http://localhost:8080/board.do")){
$('#b').css({
	    color: "#1ABC9C"
	});
}else if(ref.startsWith("http://localhost:8080/boardDetail.do")){
$('#b').css({
	    color: "#1ABC9C"
	});
}else{
$('#ub').css({
	    color: "#1ABC9C"
	});
$('#navbardrop').css({
	    color: "#1ABC9C"
	});
}
  </script>
<%@ include file="/Include/footer.jsp"%>

</html>
