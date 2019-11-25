<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>캠핑장 메인 페이지</title>
  <!-- Custom fonts for this theme -->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Theme CSS -->
  <link href="css/freelancer.min.css" rel="stylesheet">
      <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5bb32a063c253eb98bfdec5e4b579917&libraries=services,clusterer,drawing"></script>

</head>
<body id="page-top">
<%@ include file="/Include/header.jsp"%>

<!-- 지도 API -->
<div style="margin-top: 10%;display: inline-flex;width: 83%;margin-left: 8%;margin-bottom:5%">
    <div id="map" style="width:100%;height:400px;"></div>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5bb32a063c253eb98bfdec5e4b579917"></script>

<script>
// GeoLocation을 이용해서 접속 위치를 얻어옵니다
	
	navigator.geolocation.getCurrentPosition(function(position) {
    
    var lat = position.coords.latitude, // 위도
        lon = position.coords.longitude; // 경도

        
        
	 
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
            level: 4 // 지도의 확대 레벨
        };
        
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	
    $("#fc").click(function () {
    	var sigu=$('#sido1').val();
 		sigu+=$('#gugun1').val();
        console.log(sigu)


            var ps = new kakao.maps.services.Places();

            ps.keywordSearch(sigu, placesSearchCB);

        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK){
                var bounds = new kakao.maps.LatLngBounds();

                for (var i=0; i<data.length; i++){
                    // displayMarker(data[i]);
                    bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                }

                map.setBounds(bounds);
                map.setZoomable(false);
            }
        }

        map.setLevel(3);
    });
    
    var json_url = '/json/camp.json';
    
    $.getJSON(json_url, function (data, textStatus) {

        var FNAME = null;
        var LAT = null;
        var LON = null;   
        
        var imageSrc = '/img/tq.png', // 마커이미지의 주소입니다
        imageSize = new kakao.maps.Size(40, 48), // 마커이미지의 크기입니다
        imageOption = {offset: new kakao.maps.Point(27, 48)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

   		 // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)


	    var markerPosition  = new kakao.maps.LatLng(lat, lon); 

        
	 // 마커를 생성합니다
	 var marker = new kakao.maps.Marker({
	     position: markerPosition
	 });

	 // 마커가 지도 위에 표시되도록 설정합니다
	 marker.setMap(map);
     
	 var iwContent = '<div style="padding:5px;">현재 위치입니다!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition = new kakao.maps.LatLng(lat, lon); //인포윈도우 표시 위치입니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker); 
        
        $.each(data.campdata, function () {
            FNAME = this.FNAME;
            LAT = this.LAT;
            LON = this.LON;
            
            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                map: map, // 마커를 표시할 지도
                image: markerImage,
                position: new kakao.maps.LatLng(LAT, LON), // 마커를 표시할 위치
                clickable: true
            });
            
            
            var customOverlay = new daum.maps.CustomOverlay({
                position: new kakao.maps.LatLng(LAT, LON)
            });

            var content = document.createElement('div');
            content.style.position = "relative";
            content.style.bottom = "30px";
            content.style.left = "25px";
            content.style.padding = "5px";
            content.style.borderRadius = "6px";
            content.style.border = "1px solid #ccc";
            content.style.borderBottom = "2px solid #ddd";
            content.style.cssFloat = "left";
            content.style.backgroundColor = "#fff";
			
            var det='/CampDetail.do?LAT='+LAT+'&LON='+LON+'&FNAME='+FNAME
            
            var detail = document.createElement('div');
            detail.appendChild(document.createTextNode(FNAME+" >"));
            content.appendChild(detail);
            detail.style.fontSize = "13pt";
            detail.style.fontWeight = "bold";
            detail.style.borderBottom = "1px solid #ddd";
            detail.style.textAlign = "center";
            detail.onclick = function () {
                window.location.href = det;
            };
            
           
            
            var flex = document.createElement('div');
            content.appendChild(flex);
            flex.style.display = "flex";
            
            var ourl = 'https://map.kakao.com/link/to/' + FNAME + ', ' + LAT + ', ' + LON
			
            var info = document.createElement('div');
            info.appendChild(document.createTextNode("길찾기"));
            flex.appendChild(info);
            info.style.width = "50%";
            info.style.minWidth = "75px";
            info.style.fontSize = "13pt";
            info.style.color = "white";
            info.style.fontWeight = "bold";
            info.style.borderBottom = "1px solid #ddd";
            info.style.textAlign = "center";
            info.style.backgroundColor = "#1ABC9C";
            info.onclick = function () {
                window.open(ourl, '_blank')
            };

            var closeBtn = document.createElement('div');
            closeBtn.appendChild(document.createTextNode('닫기'));
            closeBtn.onclick = function () {
                customOverlay.setMap(null);
            };
            flex.appendChild(closeBtn);
            closeBtn.style.width = "50%";
            closeBtn.style.minWidth = "75px";
            closeBtn.style.color = "white";
            closeBtn.style.fontWeight = "bold";
            closeBtn.style.backgroundColor = "#d95050";
            closeBtn.style.textAlign = "center";
            closeBtn.style.borderRadius = "0px 0px 4px 4px";
			
            
            // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
            kakao.maps.event.addListener(marker, 'click', function () {
            	customOverlay.setMap(map);
            	
            });

            customOverlay.setContent(content);
            customOverlay.setMap(null);
            
       
        });

    });
	});
   

    
</script>
<!-- 지역선택 -->
<script type="text/javascript">
$('document').ready(function() {
 var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
   var area3 = ["대덕구","동구","서구","유성구","중구"];
   var area4 = ["광산구","남구","동구",     "북구","서구"];
   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
   var area6 = ["남구","동구","북구","중구","울주군"];
   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
   var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
   var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
   var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
   var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
   var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
   var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
   var area16 = ["서귀포시","제주시","남제주군","북제주군"];

 

 // 시/도 선택 박스 초기화

 $("select[name^=sido]").each(function() {
  $selsido = $(this);
  $.each(eval(area0), function() {
   $selsido.append("<option value='"+this+"'>"+this+"</option>");
  });
  $selsido.next().append("<option value=''>구/군 선택</option>");
 });

 

 // 시/도 선택시 구/군 설정

 $("select[name^=sido]").change(function() {
  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
  var $gugun = $(this).next(); // 선택영역 군구 객체
  $("option",$gugun).remove(); // 구군 초기화

  if(area == "area0")
   $gugun.append("<option value=''>구/군 선택</option>");
  else {
   $.each(eval(area), function() {
    $gugun.append("<option value='"+this+"'>"+this+"</option>");
   });
  }
 });


});
</script>
<div class="card o-hidden border-0 shadow-lg "style="width: 20%; margin: 0 auto;min-width: 320px;">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-2">지역별 캠핑장 찾기</h1>
                    <p class="mb-4">찾으시려는 캠핑장의<br/>지역을 입력해주세요!</p>
                  </div>
                  <form class="user" method="POST">
                    <div class="form-group">
                      <select name="sido1" id="sido1"class="form-control form-control-user"style="margin-bottom:5%"></select>
                      <select name="gugun1" id="gugun1"class="form-control form-control-user"></select>
                    </div>
                    <input type="button" class="btn btn-primary btn-user btn-block" id="fc" value="캠핑장 찾기">
                      	
                    
                  </form>
                </div>
              </div>
</div>
<script type="text/javascript">
  $('#c').css({
	    color: "#1ABC9C"
	});
  </script>
<%@ include file="/Include/footer.jsp"%>
</body>
</html>