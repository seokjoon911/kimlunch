<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>김점심</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<script type="text/javascript"
src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
function search(){
	$.ajax({
		url: "../board/search",
    	type: "GET",
    	data:{
    		find:   document.getElementById("find").value,
    		column: document.getElementById("column").value
    	},
		success: function(){ //http code: 200 => 202 201
			location.replace("../board/search?column="+document.getElementById("column").value+"&find="+document.getElementById("find").value);
		}
	})
}
</script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
.board{display:flex;}
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
.color {background-color : #FAD02C;}
.nounderbar {text-decoration : none;
			 font-size : 18px;}
</style>
</head>
<body>
 <div class="w3-center w3-padding-16">
 	<select class="form-control" name="column" id="column">
        <option value="article">제목</option>
        <option value="subsistence">내용</option>
        <option value="paddress">주소</option>
    </select>
 
	 <input type="text" class="w3-btn w3-white w3-border w3-border-red w3-round-large" placeholder="검색어를 입력하세요"
	 style="width:400px; padding:10px; text-align:center" id="find"/>
	 <button type="submit" class="w3-btn w3-white w3-border w3-border-red w3-round-large"
	 onclick="javascript:search()">검색</button>
 </div>
<div class="w3-main w3-content w3-padding" style="max-width:100%; margin:0 auto;">
  <div class="w3-row-padding w3-padding-16 w3-center" id="food" style="width:100%; margin:0 auto;">
  	<!-- 게시판부분 -->
  	<div class="w3-container">
		    <a href="${path}../board/list?boardid=1" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">일반 게시판</a>
		    <a href="${path}../board/list?boardid=2" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">인기 게시판</a>
		    <a href="${path}../board/list?boardid=3" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">한식</a>
		    <a href="${path}../board/list?boardid=4" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">일식</a>
		    <a href="${path}../board/list?boardid=5" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">중식</a>
		    <a href="${path}../board/list?boardid=6" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">양식</a>
		    <a href="${path}../board/list?boardid=7" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">분식</a>
		    <a href="${path}../board/list?boardid=8" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">아시안 푸드</a>
  	</div>
  	<hr style="width:100%">
  	<div class="w3-center" style="padding-left:100px;">
  	  	<!-- 인기게시판 -->
      <div class="w3-half" style="width:45%">
         <a href="../board/list?boardid=2" class="nounderbar"><h2 class="w3-text-black w3-padding-16">인기 게시판</h2></a>
          <c:if test="${bestcount > 0}"><tr>
   <c:forEach var="b_board" items="${getLikelist}" varStatus="stat"><td>
       <c:if test='${stat.index % 2==0}' />
       <div class="w3-half w3-center" >
       <a href="../board/detail?num=${b_board.bno}" class="nounderbar"" >
       <c:if test="${b_board.imgurl !=null}">
    		<img src="../board/file/${b_board.imgurl}" alt="사진" 
     	 class="w3-hover-opacity w3-container" style="width:100%" height="206"><br><br><b>${b_board.article}</b><br><br></c:if>
     	 <c:if test="${b_board.imgurl == null}">
    		<img src="../images/no_image.gif" alt="사진" 
     	 class="w3-hover-opacity w3-container" style="width:100%" height="206"><br><br><b>${b_board.article}</b><br><br></c:if></a>
     </div>
     <c:if test='${stat.index % 2==1}' />
    </td></c:forEach></tr></c:if>
    <br><br> 
      </div>

    <!-- 지도 -->
 <h2 class="w3-text-black w3-padding-16">김점심의 맛집 지도&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2>
<div class="w3-half w3-twothird" style="width:45%">
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white" style="width:40%">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="강남역" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
    </div>
</div>

<script type="text/javascript" src=
"//dapi.kakao.com/v2/maps/sdk.js?appkey=9a8a1d695aec14a0b043d964924483a5&libraries=services"></script>
<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 


// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다

function searchPlaces() {
    var keyword = document.getElementById('keyword').value;
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }
  
  
     /*  var data = 
    [{"x":126.9786522665368,"y":37.56679717280011,"place_name":"서울시청","phone": "02-123-4567"},
     {"x":127.02820980241191,"y":37.49892782685836,"place_name":"KIC 캠퍼스","phone": "02-345-4567"},]  */
      var data =[] 
    <c:forEach items="${maplist}" var="m">
    data.push({"x":${m.map_b},"y":${m.map_a},"place_name":"${m.pname}","phone":"${m.phone}","num":"${m.bno}"})
    
     </c:forEach>  
    placesSearchCB(data)
   
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data,pagination) {
        displayPlaces(data);
   //     displayPagination(pagination);
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
        

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title,num) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', function() {
            	
            	location.href="http://localhost:8088/project/board/detail?num="+num;
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name,places[i].num);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';
/*
    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 */
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

</script>
  	</div>

  </div>
 </div>
 

</body>
</html>
