<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>메인페이지</title>

  <!-- Custom fonts for this theme -->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Theme CSS -->
  <link href="css/freelancer.min.css" rel="stylesheet">

</head>

<body id="page-top">

<%@ include file="/Include/header.jsp"%>
  
  <!-- 메인화면 -->
    <div class="container d-flex align-items-center flex-column">
    <img src="/img/logo.png" style="margin-top: 25.6%;width: 112%;">
    </div>

  <section class="page-section">
  
  <h2 class="page-section-heading text-center text-uppercase">캠핑어때의 주요 기능 </h2>

      <div class="divider-custom divider-light">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon">
		<i class="fas fa-campground"></i>
        </div>
        <div class="divider-custom-line"></div>
      </div>
  <div class="col-lg-12" style="text-align-last: center;">
  <img src="/img/캠핑.PNG"style="width: 20%; max-width: 260px;">
  <img src="/img/map.png"style="width: 48%; max-width: 624px;">
   <h3>캠핑장의 위치와 정보를 주는 캠핑장 검색</h3>
  </div>
  <div class="col-lg-12" style="text-align-last: center;">
  <img src="/img/소통1.jpg"style="width: 68%; max-width: 884px;">
  <h3>공지사항과 캠핑기본지식과 캠핑장 추천 등 다양한 소통이 가능한 게시판</h3>
  </div>
   <div class="col-lg-12" style="text-align-last: center;">
  <img src="/img/공유.png"style="width: 68%; max-width: 884px;">
  <h3>캠핑장의 정보와 리뷰를 SNS에 공유 할 수 있는 기능</h3>
  </div>
  </section>

  <!-- 캠핑어때를 만든 이유 -->
  <section class="page-section bg-primary text-white mb-0" id="about">
    <div class="container">

      <h2 class="page-section-heading text-center text-uppercase text-white">캠핑어때가 만들어진 이유</h2>

      <div class="divider-custom divider-light">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon">
		<i class="fas fa-campground"></i>
        </div>
        <div class="divider-custom-line"></div>
      </div>

      <div class="row">
        <div class="col-lg-4 ml-auto">
          <p class="lead">캠핑어때는 캠핑장의 위치, 크기, 근처 편의시설, 가격 등의 정보들을 제공함으로써 캠핑을 하려하는 사람들에게 조금이나마 도움이 될 수 있도록 하기 위해서 만들어졌다.</p>
          
        </div>
        <div class="col-lg-4 mr-auto">
          <p class="lead">캠핑어때는 캠핑을 처음 시도해보는 사람들과 캠핑을 많이 가봐서 캠핑장이나 캠핑에 대한 정보를 공유하고자 하는 사람들을 위해서 만들어졌다.</p>
        </div>
      </div>

    </div>
  </section>
<%@ include file="/Include/footer.jsp"%>
</body>
</html>
