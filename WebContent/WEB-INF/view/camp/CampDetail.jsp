<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userSeq=(String)session.getAttribute("SS_userSeq");
	if(userSeq==null)
		userSeq="0";
	
	Object LAT = request.getAttribute("LAT");
	Object LON = request.getAttribute("LON");
	List<ReviewDTO> rList = (List<ReviewDTO>)request.getAttribute("rList");
	SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
	
	Date time = new Date();
			
	String time1 = format1.format(time);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>캠핑장 상세보기 페이지</title>
<!-- Custom fonts for this theme -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- Theme CSS -->
<link href="css/freelancer.min.css" rel="stylesheet">
<style>
.starR1 {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat -52px 0;
	background-size: auto 100%;
	width: 15px;
	height: 30px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}

.starR2 {
	background:
		url('http://miuu227.godohosting.com/images/icon/ico_review.png')
		no-repeat right 0;
	background-size: auto 100%;
	width: 15px;
	height: 30px;
	float: left;
	text-indent: -9999px;
	cursor: pointer;
}

.starR1.on {
	background-position: 0 0;
}

.starR2.on {
	background-position: -15px 0;
}

.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 350px;
}

#category {
	position: absolute;
	top: 10px;
	left: 10px;
	border-radius: 5px;
	border: 1px solid #909090;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
	background: #fff;
	overflow: hidden;
	z-index: 2;
}

#category li {
	float: left;
	list-style: none;
	width: 50px; px;
	border-right: 1px solid #acacac;
	padding: 6px 0;
	text-align: center;
	cursor: pointer;
}

#category li.on {
	background: #eee;
}

#category li:hover {
	background: #ffe6e6;
	border-left: 1px solid #acacac;
	margin-left: -1px;
}

#category li:last-child {
	margin-right: 0;
	border-right: 0;
}

#category li span {
	display: block;
	margin: 0 auto 3px;
	width: 27px;
	height: 28px;
}

#category li .category_bg {
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
		no-repeat;
}

#category li .bank {
	background-position: -10px 0;
}

#category li .mart {
	background-position: -10px -36px;
}

#category li .pharmacy {
	background-position: -10px -72px;
}

#category li .oil {
	background-position: -10px -108px;
}

#category li .cafe {
	background-position: -10px -144px;
}

#category li .store {
	background-position: -10px -180px;
}

#category li.on .category_bg {
	background-position-x: -46px;
}

.placeinfo_wrap {
	position: absolute;
	bottom: 28px;
	left: -150px;
	width: 300px;
}

.placeinfo {
	position: relative;
	width: 100%;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
	background: #fff;
}

.placeinfo:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
	content: '';
	position: relative;
	margin-left: -12px;
	left: 50%;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
	color: #fff;
	text-decoration: none;
}

.placeinfo a, .placeinfo span {
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.placeinfo span {
	margin: 5px 5px 0 5px;
	cursor: default;
	font-size: 13px;
}

.placeinfo .title {
	font-weight: bold;
	font-size: 14px;
	border-radius: 6px 6px 0 0;
	margin: -1px -1px 0 -1px;
	padding: 10px;
	color: #fff;
	background: #d95050;
	background: #d95050
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.placeinfo .tel {
	color: #0f7833;
}

.placeinfo .jibun {
	color: #999;
	font-size: 11px;
	margin-top: 0;
}
</style>
<link href="/summernote/summernote-bs4.css" rel="stylesheet">
</head>
<body id="page-top">
	<%@ include file="/Include/header.jsp"%>
	<div>
		<div class="map_wrap"
			style="margin-top: 10%; display: inline-flex; width: 83%; margin-left: 8%; margin-bottom: 5%">
			<div id="map"
				style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			<ul id="category">
				<li id="BK9" data-order="0"><span class="category_bg bank"></span>
					은행</li>
				<li id="MT1" data-order="1"><span class="category_bg mart"></span>
					마트</li>
				<li id="PM9" data-order="2"><span class="category_bg pharmacy"></span>
					약국</li>
				<li id="OL7" data-order="3"><span class="category_bg oil"></span>
					주유소</li>
				<li id="CE7" data-order="4"><span class="category_bg cafe"></span>
					카페</li>
				<li id="CS2" data-order="5"><span class="category_bg store"></span>
					편의점</li>
			</ul>
		</div>

		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5bb32a063c253eb98bfdec5e4b579917&libraries=services"></script>
		<script>
			// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
			var placeOverlay = new kakao.maps.CustomOverlay({
				zIndex : 1
			}), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
			markers = [], // 마커를 담을 배열입니다
			currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
			console.log(
		<%=LAT%>
			);
			console.log(
		<%=LON%>
			);
			var lat =
		<%=LAT%>
			, // 위도
			lon =
		<%=LON%>
			; // 경도

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
				level : 4
			// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			var imageSrc = '/img/tq.png', // 마커이미지의 주소입니다
			imageSize = new kakao.maps.Size(40, 48), // 마커이미지의 크기입니다
			imageOption = {
				offset : new kakao.maps.Point(27, 48)
			}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imageOption), markerPosition = new kakao.maps.LatLng(
		<%=LAT%>
			,
		<%=LON%>
			); // 마커가 표시될 위치입니다

			//마커를 생성합니다
			var marker = new kakao.maps.Marker({
				position : markerPosition,
				image : markerImage
			// 마커이미지 설정 
			});

			//마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			$(function(){
				$.getJSON('/json/camp.json',function(data){
					console.log(data)
				
					
					$.each(data.campdata,function(index,item){
						if(item.LAT==<%=LAT%>&&item.LON==<%=LON%>){
							console.log(item.FNAME)
							var iwContent = '<div style="padding:5px;">'+item.FNAME+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
							iwPosition = new kakao.maps.LatLng(lat, lon); //인포윈도우 표시 위치입니다

							// 인포윈도우를 생성합니다
							var infowindow = new kakao.maps.InfoWindow({
								position : iwPosition,
								content : iwContent
							});

							// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
							infowindow.open(map, marker);
						}
					})
				})
			})

			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places(map);

			// 지도에 idle 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', searchPlaces);

			// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
			contentNode.className = 'placeinfo_wrap';

			// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
			// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
			addEventHandle(contentNode, 'mousedown',
					kakao.maps.event.preventMap);
			addEventHandle(contentNode, 'touchstart',
					kakao.maps.event.preventMap);

			// 커스텀 오버레이 컨텐츠를 설정합니다
			placeOverlay.setContent(contentNode);

			// 각 카테고리에 클릭 이벤트를 등록합니다
			addCategoryClickEvent();

			// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
			function addEventHandle(target, type, callback) {
				if (target.addEventListener) {
					target.addEventListener(type, callback);
				} else {
					target.attachEvent('on' + type, callback);
				}
			}

			// 카테고리 검색을 요청하는 함수입니다
			function searchPlaces() {
				if (!currCategory) {
					return;
				}

				// 커스텀 오버레이를 숨깁니다 
				placeOverlay.setMap(null);

				// 지도에 표시되고 있는 마커를 제거합니다
				removeMarker();

				ps.categorySearch(currCategory, placesSearchCB, {
					useMapBounds : true
				});
			}

			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
				if (status === kakao.maps.services.Status.OK) {

					// 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
					displayPlaces(data);
				} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
					// 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

				} else if (status === kakao.maps.services.Status.ERROR) {
					// 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

				}
			}

			// 지도에 마커를 표출하는 함수입니다
			function displayPlaces(places) {

				// 몇번째 카테고리가 선택되어 있는지 얻어옵니다
				// 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
				var order = document.getElementById(currCategory).getAttribute(
						'data-order');

				for (var i = 0; i < places.length; i++) {

					// 마커를 생성하고 지도에 표시합니다
					var marker = addMarker(new kakao.maps.LatLng(places[i].y,
							places[i].x), order);

					// 마커와 검색결과 항목을 클릭 했을 때
					// 장소정보를 표출하도록 클릭 이벤트를 등록합니다
					(function(marker, place) {
						kakao.maps.event.addListener(marker, 'click',
								function() {
									displayPlaceInfo(place);
								});
					})(marker, places[i]);
				}
			}

			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, order) {
				var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
				imgOptions = {
					spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
					spriteOrigin : new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					offset : new kakao.maps.Point(11, 28)
				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
				}, markerImage = new kakao.maps.MarkerImage(imageSrc,
						imageSize, imgOptions), marker = new kakao.maps.Marker(
						{
							position : position, // 마커의 위치
							image : markerImage
						});

				marker.setMap(map); // 지도 위에 마커를 표출합니다
				markers.push(marker); // 배열에 생성된 마커를 추가합니다

				return marker;
			}

			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
				for (var i = 0; i < markers.length; i++) {
					markers[i].setMap(null);
				}
				markers = [];
			}

			// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
			function displayPlaceInfo(place) {
				var content = '<div class="placeinfo">'
						+ '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
						+ place.place_name + '</a>';

				if (place.road_address_name) {
					content += '    <span title="' + place.road_address_name + '">'
							+ place.road_address_name
							+ '</span>'
							+ '  <span class="jibun" title="' + place.address_name + '">(지번 : '
							+ place.address_name + ')</span>';
				} else {
					content += '    <span title="' + place.address_name + '">'
							+ place.address_name + '</span>';
				}

				content += '    <span class="tel">' + place.phone + '</span>'
						+ '</div>' + '<div class="after"></div>';

				contentNode.innerHTML = content;
				placeOverlay
						.setPosition(new kakao.maps.LatLng(place.y, place.x));
				placeOverlay.setMap(map);
			}

			// 각 카테고리에 클릭 이벤트를 등록합니다
			function addCategoryClickEvent() {
				var category = document.getElementById('category'), children = category.children;

				for (var i = 0; i < children.length; i++) {
					children[i].onclick = onClickCategory;
				}
			}

			// 카테고리를 클릭했을 때 호출되는 함수입니다
			function onClickCategory() {
				var id = this.id, className = this.className;

				placeOverlay.setMap(null);

				if (className === 'on') {
					currCategory = '';
					changeCategoryClass();
					removeMarker();
				} else {
					currCategory = id;
					changeCategoryClass(this);
					searchPlaces();
				}
			}

			// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
			function changeCategoryClass(el) {
				var category = document.getElementById('category'), children = category.children, i;

				for (i = 0; i < children.length; i++) {
					children[i].className = '';
				}

				if (el) {
					el.className = 'on';
				}
			}
		</script>
		<script src="/summernote/summernote-bs4.min.js"></script>
		<script src="/summernote/summernote-bs4.js"></script>
		<script src="/summernote/lang/summernote-ko-KR.js"></script>
		<div class="card o-hidden border-0 shadow-lg "
			style="width: 83%; margin: 0 auto; min-width: 320px; margin-bottom: 5%;">
			<div class="p-5">
				<div class="text-center">
					<div id="CI"></div>
					<input type="button" class="btn btn-primary btn-user btn-block"
						id="rw" value="리뷰 작성하기">
					<input type="hidden" class="btn btn-primary btn-user btn-block"
						id="rw1" value="리뷰 작성창 닫기">
					<form onsubmit="return buhs();" action="/ReviewAdd.do"
							method="POST" id="review" style="display:none;">
					<div
						style="width: 100%; padding-top: 1%; text-align: center; margin: 0 auto">
						<a style="font-size: 1.5rem;">리뷰 작성하기</a>
						<hr>
						<div style="display: inline-flex;">
							<input type=text class="h4 text-gray-900" id="pg"
								value="0.0/5   평점을 정해 주세요 "
								style="border: none; margin-top: 0.2rem;" readonly
								onfocus='this.blur();'>
							<div class="starRev">
								<span class="starR1" id="s05">별1_왼쪽</span> <span class="starR2"
									id="s10">별1_오른쪽</span> <span class="starR1" id="s15">별2_왼쪽</span>
								<span class="starR2" id="s20">별2_오른쪽</span> <span class="starR1"
									id="s25">별3_왼쪽</span> <span class="starR2" id="s30">별3_오른쪽</span>
								<span class="starR1" id="s35">별4_왼쪽</span> <span class="starR2"
									id="s40">별4_오른쪽</span> <span class="starR1" id="s45">별5_왼쪽</span>
								<span class="starR2" id="s50">별5_오른쪽</span>
								<input type="hidden" id="SP" name="point" value="0">
								<input type="hidden" id="camp" name="camp" value="0">					
								<input type="hidden" id="lat" name="lat" value="0">					
								<input type="hidden" id="lon" name="lon" value="0">
							</div>
						</div>
							<div
								style="margin: 0 auto; text-align: justify; width: 75%; max-width: 1000px;">
								<textarea id="summernote" name="reviewContent"></textarea>
							</div>
							<div>
								<input type="submit" class="btn"
									style="background-color: rgb(129, 114, 242); margin-top: 2%; margin-left: 2%; margin-bottom: 2%;; color: white;"
									value="작성하기">
							</div>
						</div>
						<hr/>
					</form>
					
					<%for (int i=0; i<rList.size(); i++) {
					 String Spoint=rList.get(i).getReviewSp();
					 float spoint= Float.parseFloat(Spoint);%>
				<div class="listTag" style="margin-top:2%;">
				<div class="listWriter" style="margin-bottom: 3%;">
				<%if(userSeq.equals(rList.get(i).getUserSeq())||userAss.equals("1")) {%>
				<div style="float: right;display: flex;">
				
				<form action="/reviewMod.do" id="rm<%=i%>">
				<input type="hidden" name="Rno" value="<%=rList.get(i).getReviewSeq()%>">
				<a style="text-decoration-line: none;"onclick="return rmod(<%=i%>)" id="ma<%=i%>">수정</a>
				<a style="display:none;"onclick="return rmodd(<%=i%>)"id="md<%=i%>">수정</a>
				</form>
				&nbsp;/&nbsp;
				<form action="/reviewDel.do" id="rd<%=i%>">
					<input type="hidden"  name="camp1" value="0">					
					<input type="hidden"  name="lat1" value="0">					
					<input type="hidden"  name="lon1" value="0">
				<input type="hidden" name="Rno" value="<%=rList.get(i).getReviewSeq()%>">
				<input type="hidden" id="cont<%=i %>" value="<%=rList.get(i).getReviewContent().replace("& gt;", ">").replace("& lt;", "<").replace("& #39;", "'").replace("script", "") %>">
				<a style="text-decoration-line: none;"onclick="return rDel(<%=i%>);">삭제</a></form></div><%} %>
				<div style="display:inline-flex;margin-left: 1.2%;float: left;">
								<span class="starR1 on">별1_왼쪽</span>
								<span class="starR2<%if(spoint>=1.0) {%> on<%} %>" >별1_오른쪽</span> 
								<span class="starR1<%if(spoint>=1.5) {%> on<%} %>" >별2_왼쪽</span>
								<span class="starR2<%if(spoint>=2.0) {%> on<%} %>" >별2_오른쪽</span>
								<span class="starR1<%if(spoint>=2.5) {%> on<%} %>" >별3_왼쪽</span>
								<span class="starR2<%if(spoint>=3.0) {%> on<%} %>" >별3_오른쪽</span>
								<span class="starR1<%if(spoint>=3.5) {%> on<%} %>" >별4_왼쪽</span>
								<span class="starR2<%if(spoint>=4.0) {%> on<%} %>" >별4_오른쪽</span>
								<span class="starR1<%if(spoint>=4.5) {%> on<%} %>" >별5_왼쪽</span>
								<span class="starR2<%if(spoint>=5.0) {%> on<%} %>" >별5_오른쪽</span>
									<div style="margin-top:3%;margin-left:0%;"><%=rList.get(i).getReviewSp() %>점</div>	
							</div>
				</div>
				<div style="float:left;margin-left:2%;clear:both;margin-top: 20px;"><%=rList.get(i).getReviewContent().replace("& gt;", ">").replace("& lt;", "<").replace("& #39;", "'").replace("script", "") %></div>
				</div>
				<div style="clear:both;margin-bottom: 30px;">
				<div style="font-size: small; display: inline-flex;float:left;margin-left:1.5%;">
				<div>작성자 : <%=rList.get(i).getReviewWriter() %>&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<div>작성일 : <%=rList.get(i).getReviewWritedate() %>
				<%if(rList.get(i).getReviewWritedate().equals(time1)) {%> <img src='img/new.jpg'  style="vertical-align: super;"/><%} %>&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<%if(rList.get(i).getReviewUpdate()!=null){ %><div>최근 수정일 :<%=rList.get(i).getReviewUpdate()%></div><%} %>
				</div>
				</div>
				<form onsubmit="return Muhs(<%=i%>);" action="/reviewMod.do"
							method="POST" id="reviewMod<%=i %>" style="display:none;">
					<div style="width: 100%; padding-top: 1%; text-align: center; margin: 0 auto">
						<hr>
						<div style="display: inline-flex;">
							<input type=text class="h4 text-gray-900" id="pg<%=i %>"
								value="0.0/5   평점을 재설정 주세요 "
								style="border: none; margin-top: 0.2rem;" readonly
								onfocus='this.blur();'>
							<div class="starRev">
								<span class="starR1 on"id="s05<%=i %>">별1_왼쪽</span>
								<span class="starR2<%if(spoint>=1.0) {%> on<%} %>" id="s10<%=i %>" >별1_오른쪽</span> 
								<span class="starR1<%if(spoint>=1.5) {%> on<%} %>" id="s15<%=i %>">별2_왼쪽</span>
								<span class="starR2<%if(spoint>=2.0) {%> on<%} %>" id="s20<%=i %>">별2_오른쪽</span>
								<span class="starR1<%if(spoint>=2.5) {%> on<%} %>" id="s25<%=i %>">별3_왼쪽</span>
								<span class="starR2<%if(spoint>=3.0) {%> on<%} %>" id="s30<%=i %>">별3_오른쪽</span>
								<span class="starR1<%if(spoint>=3.5) {%> on<%} %>" id="s35<%=i %>">별4_왼쪽</span>
								<span class="starR2<%if(spoint>=4.0) {%> on<%} %>" id="s40<%=i %>">별4_오른쪽</span>
								<span class="starR1<%if(spoint>=4.5) {%> on<%} %>" id="s45<%=i %>">별5_왼쪽</span>
								<span class="starR2<%if(spoint>=5.0) {%> on<%} %>" id="s50<%=i %>">별5_오른쪽</span>
								<input type="hidden" id="SP<%=i %>" name="point" value="0">
								<input type="hidden"  name="camp1" value="0">					
								<input type="hidden"  name="lat1" value="0">					
								<input type="hidden"  name="lon1" value="0">
								<input type="hidden"  name="reviewSeq" value="<%=rList.get(i).getReviewSeq()%>">
							</div>
						</div>
							<div
								style="margin: 0 auto; text-align: justify; width: 75%; max-width: 1000px;">
								<textarea id="Msummernote<%=i %>" name="reviewContent"></textarea>
							</div>
							<div>
								<input type="submit" class="btn"
									style="background-color: rgb(129, 114, 242); margin-top: 2%; margin-left: 2%; margin-bottom: 2%;; color: white;"
									value="수정하기">
							</div>
						</div>
					</form>
			<hr/>
			<% } %>
               
				</div>
			</div>
		</div>


		<script type="text/javascript">
			document.querySelector('#summernote').value = '';
			$(function(){
				$.getJSON('/json/camp.json',function(data){
					console.log(data)
				
					
					$.each(data.campdata,function(index,item){
						if(item.LAT==<%=LAT%>&&item.LON==<%=LON%>){
							var html = '';
							  html += '<h1 class="h3 text-gray-900 mb-2">'+item.FNAME+'</h1>';
					    	  html += '<p class="mb-4"><h5 style="margin-bottom: 5%;"><div style="display:inline-flex;float: left;margin-left: 1%;">주소 : ' +item.ADDR+'</div>';
					    	  html += '<br/><div style="display:inline-flex;float: left;margin-left: 1%;">전화번호 : ' +item.PHONE+'</div>';
					    	  html += '<br/><div style="display:inline-flex;float: left;margin-left: 1%;">편의시설 : ' +item.COMF.replace(/\+/gi,", ")+'</div>';
					    	  html += '<br/><div style="display:inline-flex;float: left;margin-left: 1%;">안전시설 : ' +item.SAFE.replace(/\+/gi,", ")+'</div>';
					    	  html += '<br/><div style="display:inline-flex;float: left;margin-left: 1%;">기타 부대시설  : ' +item.BS+'</div>';
					    	  html += '<br/><div style="display:inline-flex;float: left;margin-left: 1%;">요금 : ' +item.PAY+'</div>';
					    	  html += '<br/><div style="display:inline-flex;float: left;margin-left: 1%;">시간 : ' +item.TIME+'</div></h5></p>';
					    	  $('#CI').html(html);
					    	  $('#camp').attr('value',item.FNAME);
					    	  $('#lat').attr('value',item.LAT);
					    	  $('#lon').attr('value',item.LON);
					    	  $('input[name=camp1]').attr('value',item.FNAME);
					    	  $('input[name=lat1]').attr('value',item.LAT);
					    	  $('input[name=lon1]').attr('value',item.LON);
					      }});
						
					});
				})
			$(document).ready(
					function() {
						$('#summernote').summernote(
								{
									height : 200,
									lang : 'ko-KR',
									fontNames : [ '맑은고딕', 'Arial',
											'Arial Black', 'Comic Sans MS',
											'Courier New', ],
									fontNamesIgnoreCheck : [ '맑은고딕' ],
									placeholder : '내용을 입력해주세요.(최대2000자)',
								});
					});
		</script>

	</div>
	<script type="text/javascript">
		function buhs() {
			var content = document.getElementById("summernote");
			var sp=$('#SP').val();
			if (sp == "0") {
				alert("평점을 정해 주세요.");
				return false;
			}
			if (content.value == "") {
				alert("내용을 입력해 주세요.");
				$('#summernote').summernote('focus');
				return false;
			}
		}
		function Muhs(i) {
			var content = document.getElementById("Msummernote"+i);
			var sp=$('#SP'+i).val();
			
			if (sp == "0") {
				alert("평점을 정해 주세요.");
				return false;
			}
			if (content.value == "") {
				alert("내용을 입력해 주세요.");
				$('#Msummernote'+i).summernote('focus');
				return false;
			}
		}
	</script>
	<script>
		$('.starRev span').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
			return false;
		});
		$('#s05').click(function() {
			$('#pg').attr('value', '0.5/5   별로에요');
			$('#SP').attr('value', '0.5');
		});
		$('#s10').click(function() {
			$('#pg').attr('value', '1.0/5   별로에요');
			$('#SP').attr('value', '1.0');
		});
		$('#s15').click(function() {
			$('#pg').attr('value', '1.5/5   아쉬워요');
			$('#SP').attr('value', '1.5');
		});
		$('#s20').click(function() {
			$('#pg').attr('value', '2.0/5   아쉬워요');
			$('#SP').attr('value', '2.0');
		});
		$('#s25').click(function() {
			$('#pg').attr('value', '2.5/5   보통이에요');
			$('#SP').attr('value', '2.5');
		});
		$('#s30').click(function() {
			$('#pg').attr('value', '3.0/5   보통이에요');
			$('#SP').attr('value', '3.0');
		});
		$('#s35').click(function() {
			$('#pg').attr('value', '3.5/5   좋아요');
			$('#SP').attr('value', '3.5');
		});
		$('#s40').click(function() {
			$('#pg').attr('value', '4.0/5   좋아요');
			$('#SP').attr('value', '4.0');
		});
		$('#s45').click(function() {
			$('#pg').attr('value', '4.5/5   최고에요');
			$('#SP').attr('value', '4.5');
		});
		$('#s50').click(function() {
			$('#pg').attr('value', '5.0/5   최고에요');
			$('#SP').attr('value', '5.0');
		});
		
		function rDel(i){
			var result;
			console.log(i);
			result = confirm("리뷰를 삭제하시겠습니까?");
			console.log(result);
			if (result){
				$('#rd'+i).submit();
			}else{ 
				alert("취소되었습니다.");
			}
		};
		function rmod(i){
			$('#reviewMod'+i).attr('style','display:block;');
			$('#ma'+i).attr('style','display:none;');
			$('#md'+i).attr('style','text-decoration-line: none;')
			var content=$('#cont'+i).val();
			document.querySelector('#Msummernote'+i).value =content;
		    $(document).ready(function() {
		      $('#Msummernote'+i).summernote({
		    	  height:200,
		    	  lang: 'ko-KR',
		    	  fontNames : [ '맑은고딕' , 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		    	  fontNamesIgnoreCheck : ['맑은고딕' ],
		      });
		    });
		    $('#s05'+i).click(function() {
				$('#pg'+i).attr('value', '0.5/5   별로에요');
				$('#SP'+i).attr('value', '0.5');
			});
			$('#s10'+i).click(function() {
				$('#pg'+i).attr('value', '1.0/5   별로에요');
				$('#SP'+i).attr('value', '1.0');
			});
			$('#s15'+i).click(function() {
				$('#pg'+i).attr('value', '1.5/5   아쉬워요');
				$('#SP'+i).attr('value', '1.5');
			});
			$('#s20'+i).click(function() {
				$('#pg'+i).attr('value', '2.0/5   아쉬워요');
				$('#SP'+i).attr('value', '2.0');
			});
			$('#s25'+i).click(function() {
				$('#pg'+i).attr('value', '2.5/5   보통이에요');
				$('#SP'+i).attr('value', '2.5');
			});
			$('#s30'+i).click(function() {
				$('#pg'+i).attr('value', '3.0/5   보통이에요');
				$('#SP'+i).attr('value', '3.0');
			});
			$('#s35'+i).click(function() {
				$('#pg'+i).attr('value', '3.5/5   좋아요');
				$('#SP'+i).attr('value', '3.5');
			});
			$('#s40'+i).click(function() {
				$('#pg'+i).attr('value', '4.0/5   좋아요');
				$('#SP'+i).attr('value', '4.0');
			});
			$('#s45'+i).click(function() {
				$('#pg'+i).attr('value', '4.5/5   최고에요');
				$('#SP'+i).attr('value', '4.5');
			});
			$('#s50'+i).click(function() {
				$('#pg'+i).attr('value', '5.0/5   최고에요');
				$('#SP'+i).attr('value', '5.0');
			});
		}
		function rmodd(i){
			$('#reviewMod'+i).attr('style','display:none;');
			$('#ma'+i).attr('style','text-decoration-line: none;');
			$('#md'+i).attr('style','display:none;');
		}
	</script>
	<script>
		$('#rw').click(function() {
			if (<%=userAss%>=="3"){
				alert('로그인 후 이용 가능합니다.');
				$('#loginModal').modal();
			}else{
				$('#review').attr('style','disply:block;');
				$('#rw1').attr('type','button');
				$('#rw').attr('type','hidden');
			}
		});
	</script>
	<script>
		$('#rw1').click(function() {
			$('#review').attr('style','display:none;');
			$('#rw').attr('type','button');
			$('#rw1').attr('type','hidden');
		});
	</script>
	<script type="text/javascript">
  $('#c').css({
	    color: "#1ABC9C"
	});
  </script>
	<%@ include file="/Include/footer.jsp"%>
</body>
</html>