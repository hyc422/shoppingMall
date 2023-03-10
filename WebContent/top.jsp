<%@page import="org.shoppingMall.vo.Best5Vo"%>
<%@page import="org.shoppingMall.dao.Best5Dao"%>
<%@page import="java.util.List"%>
<%@page import="org.shoppingMall.vo.SearchVo"%>
<%@page import="org.shoppingMall.dao.SearchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.rollingbanner{
    position: relative;
    width: 250px;
    height: 38px;
    font-size: .875rem;
    letter-spacing: -1px;
    padding: 7px 15px;
    box-sizing: border-box;
    background-color: #EEEEEE;
    border-radius: 6px;
    margin-right: 10px;
    
}
/* 타이틀 */
.rollingbanner > .title{
    font-weight: bold;
    float: left;
    padding-right: 10px;
    border-right: 1px solid black;
}
/* 롤링 배너 */
.rollingbanner > .wrap{
    position: relative;
    width: auto;
    height: 100%;
    box-sizing: border-box;
    overflow: hidden;
}        
.rolling ul{
    list-style: none;
}
.rollingbanner li{
    position: absolute;
    top: -36px;
    left: 0;
}
/* 이전, 현재, 다음 롤링 배너 표시 */
.rollingbanner li.prev{
    top: 36px;
    transition: top 0.5s ease;
}
.rollingbanner li.current{
    top: 0;
    transition: top 0.5s ease;
}
.rollingbanner li.next{
    top: -36px;
}
.rollingbanner a{
	padding-left:10px;
    display: block;
    display: -webkit-box;
    text-decoration: none;
    -webkit-line-clamp: 1;
    -webkit-box-orient:vertical;
    overflow: hidden;
    color: #000;
    
}
.rollingbanner a{
    display: block;
    display: -webkit-box;
    text-decoration: none;
    -webkit-line-clamp: 1;
    -webkit-box-orient:vertical;
    overflow: hidden;
    color: #000;
}

.donghae{
	color: white;
}
</style>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	
	<script>	/* 실시간검색 */
        document.addEventListener('DOMContentLoaded', ()=>{
            var interval = window.setInterval(rollingCallback, 3000);
        })
        function rollingCallback(){
            //.prev 클래스 삭제
            document.querySelector('.rollingbanner .prev').classList.remove('prev');

            //.current -> .prev
            let current = document.querySelector('.rollingbanner .current');
            current.classList.remove('current');
            current.classList.add('prev');

            //.next -> .current
            let next = document.querySelector('.rollingbanner .next');
            //다음 목록 요소가 널인지 체크
            if(next.nextElementSibling == null){
                document.querySelector('.rollingbanner ul li:first-child').classList.add('next');
            }else{
                //목록 처음 요소를 다음 요소로 선택
                next.nextElementSibling.classList.add('next');
            }
            next.classList.remove('next');
            next.classList.add('current');
        }
    </script>
	
</head>
<body>
	
	<%
		Best5Dao dao2 = Best5Dao.getInstance();
		List<Best5Vo> list = dao2.Best5();
	%>

<!-- header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="<%=request.getContextPath() %>"  id="top">술공장</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <c:if test="${sessionScope.user == null }">
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/login">로그인<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/member/register">회원가입<span class="sr-only">(current)</span></a>
      </li>
      </c:if>
      <c:if test="${sessionScope.user != null }">
      <li class="nav-link"><span id="user">${user.name }님</span></li>
      <li><a class="nav-link" href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
      </c:if>
      <c:if test="${user.admin == 'n' || user == null }">
      <li class="nav-item active">
        <a onclick="Cart2()" class="nav-link" href="#">장바구니<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item dropdown">
        <a  style="color: white;" class="nav-link dropdown-toggle" href="myPage2" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          마이페이지
        </a>
        
  <div class="dropdown-menu">
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" onclick="pay()">결재내역 조회</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" onclick="review()">내가 쓴 리뷰</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#" onclick="qnalist()">내가 쓴 QnA</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item"
           href="#" onclick="update()">회원정보수정</a>
        </div>
      </li>
      </c:if>
      
	<c:if test="${user.admin =='y' }">
	<li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/admin">관리자페이지</a></li>
	</c:if>
      
    </ul>

	<script type="text/javascript">
		function Cart2() {
			let yn
			if ('${user.id}' == '') {
				yn = confirm('장바구니에 추가하기 위해서는 로그인이 필요합니다. 로그인 하시겠습니까?')
				if (yn)
					location.href = '${pageContext.request.contextPath }/login?back=w'
			} else {
				location.href = '${pageContext.request.contextPath }/cart?id=${user.id}'
			}
		}
		function pay() {
			let yn
			if ('${user.id}' == '') {
				yn = confirm('로그인이 필요합니다. 로그인 하시겠습니까?')
				if (yn)
					location.href = '${pageContext.request.contextPath }/login?back=w'
			} else {
				location.href = '${pageContext.request.contextPath }/paylist?id=${user.id}'
			}
		}
		function review() {
			let yn
			if ('${user.id}' == '') {
				yn = confirm('로그인이 필요합니다. 로그인 하시겠습니까?')
				if (yn)
					location.href = '${pageContext.request.contextPath }/login?back=w'
			} else {
				location.href = '${pageContext.request.contextPath }/review?nickname=${user.nickname}'
			}
		}
		function qnalist() {
			let yn
			if ('${user.id}' == '') {
				yn = confirm('로그인이 필요합니다. 로그인 하시겠습니까?')
				if (yn)
					location.href = '${pageContext.request.contextPath }/login?back=w'
			} else {
				location.href = '${pageContext.request.contextPath }/qnalist?nickname=${user.nickname}'
			}
		}
		function update() {
			let yn
			if ('${user.id}' == '') {
				yn = confirm('로그인이 필요합니다. 로그인 하시겠습니까?')
				if (yn)
					location.href = '${pageContext.request.contextPath }/login?back=w'
			} else {
				location.href = '${pageContext.request.contextPath }/update?idx=${user.idx }'
			}
		}
	</script>



<!-- 실시간 주류 -->
<div class="rollingbanner ">
    <div class="title">인기 주류 TOP5 </div>
    <div class="wrap">
         <ul>
            <li class="current"><a href="/shoppingMall/Product/product?productNum=<%=list.get(0).getProductnum()%>"><%=list.get(0).getProductname() %></a></li>
            <li class="next"><a href="/shoppingMall/Product/product?productNum=<%=list.get(1).getProductnum()%>"><%=list.get(1).getProductname() %></a></li>
            <li><a href="/shoppingMall/Product/product?productNum=<%=list.get(2).getProductnum()%>"><%=list.get(2).getProductname() %></a></li>
            <li><a href="/shoppingMall/Product/product?productNum=<%=list.get(3).getProductnum()%>"><%=list.get(3).getProductname() %></a></li>
            <li class="prev"><a href="/shoppingMall/Product/product?productNum=<%=list.get(4).getProductnum()%>"><%=list.get(4).getProductname() %></a></li>
        </ul>
    </div>
</div>



<!-- 검색 -->
    <form name="formname" id="formid" class="form-inline my-2 my-lg-0" action="javascript:search()" method="GET" >
      <input class="form-control mr-sm-2" type="search" placeholder="검색" aria-label="Search" name = "name" id="searchid">
     <button type="button" onclick="search()" class="btn btn-outline-light">검색</button>
    </form>
  </div>
  
  
  <script type="text/javascript">
  function search() {
	  const frm = document.forms[0];
	  const value = frm.name.value;
	  if(value == ""){
		  alert('검색어를 입력해주세요.')
	  } else if(value !== "") {
		  frm.submit();
 		  location.href="/shoppingMall/search?name="+value;
	  }
  }
  
  </script>
</nav>



<!-- nav -->
<div class="sticky-top" style="width: 400px; margin: auto;">
<ul class="nav justify-content-center">
      <li class="nav-item dropdown">
        <a style="color: #424242;" class="nav-link dropdown-toggle"  href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          발효주
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${pageContext.request.contextPath }/Product/productList?Categories=과실주&page=1">과실주</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath }/Product/productList?Categories=막걸리&page=1">막걸리</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath }/Product/productList?Categories=청주&page=1">청주</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a style="color: #424242;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          증류주
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${pageContext.request.contextPath }/Product/productList?Categories=브랜디&page=1">브랜디</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath }/Product/productList?Categories=소주&page=1">소주</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath }/Product/productList?Categories=위스키&page=1">위스키</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a style="color: #424242;" class="nav-link dropdown-toggle" href="${pageContext.request.contextPath}/community/communitylist?category=1" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          커뮤니티
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communitylist?category=1">공지사항</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communitylist?category=2">상품후기</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="${pageContext.request.contextPath}/community/communitylist?category=3">QnA</a>
        </div>
      </li>

</ul>
</div>
<br>
<hr>
<br>





<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>