# JSTL (JSP Standard Tag Library)
JSP를 사용하는 여러 프로그램이 공통으로 사용할 수 있도록 JSP 태그를 라이브러리 형태로 만들어놓은 것  
보통의 라이브러리와는 다르게 JSP 페이지 안에서 사용 할 수 있는 커스텀과 함수를 제공한다.  
일반적으로 EL (Expression Language)과 함께 쓰이며, 이를 통해 HTML 코드 내에서 자바 코드를 사용할 수 있게 해주는 스크립틀릿을 가독성 좋게 사용할 수 있다.  
최근에는 뷰와 비즈니스 로직의 분리와 가독성 이슈로 스크립툴릿 대신 JSTL을 많이 사용한다.  

# JSTL로 할 수 있는 일
1. 간단한 프로그램 로직 구사 (자바 변수 선언, if문, for문 등)
2. 다른 JSP 페이지 호출 (<c:redirect><c:import>)
3. Formatting(숫자, 날짜, 시간)
4. 데이터베이스 CRUD
5. XML 문서 처리
6. 문자열 처리 함수 호출 등

# 대표적 라이브러리와 기능
## 라이브러리
### Core 
> 접두어: c  
> 기능: 일반 프로그램 언어에서 제공하는 변수선언, 조건/제어/반복문 등의 기능 제공  
### Formatting
> 접두어: fmt  
> 기능: 숫자, 날짜, 시간을 포맷팅하는 기능 그리고 국제화, 다국어 지원기능 제공  
### Function
> 접두어: fn  
> 기능: 문자열을 처리하는 함수 제공  
### Database
> 접두어: sql  
> 기능: 데이터베이스의 데이터 CRUD 기능 제공  
### XML 처리
> 접두어: x  
> 기능: XML 문서를 처리할 때 필요한 기능 제공  
## 라이브러리 선언 (JSP 문서 선언부에 작성)
```
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="https://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="https://java.sun.com/jsp/jstl/xml" %>
```

# 사용 예시
## 변수 선언
```
// 변수의 선언 <c:set var="변수명" value="값"/>
<c:set var="num1" value= "1"/>
<c:set var="num2" value= "${num1 + 1}"/>
<c:set var="url" value="<%=request.getContextPath() %>"/>

// 변수의 사용
<h1>${num1}</h1>
<h1>${num2}</h1>
<a href="${url}/member/loginForm">로그인</a>
```
## 반복문
```
<c:forEach var="vo" items="${list}">
	<li><input type="checkbox" name="noList" value='${vo.no}' class="chk" /></li>
	<li>${vo.no}</li>
	<li><a href="/myapp/board/boardView?no=${vo.no}">${vo.subject}</a></li>
	<li>${vo.userid}</li>
	<li>${vo.hit}</li>
	<li>${vo.writedate}</li>
</c:forEach>
```
## 조건문 (if) - else 구문이 없음
```
<c:if test="조건식" var="조건식 결과를 저장할 변수 선언" scope="조건식 결과를 저장할 변수의 저장 scope 지정">
	조건식이 참일 경우 반복할 내용
</c:if>

<c:if test="${logStatus !='Y'}">
	<a href ="${url}/member/loginForm">로그인</a>
	<a href ="${url}/member/memberForm">회원가입</a>
</c:if>
<c:if test="${logStatus =='Y'}">
	<a href ="${url}/member/logout">로그아웃</a>
	<a href ="${url}/member/memberEdit">회원정보 수정</a>
</c:if>
```
## 조건문 (choose, otherwise)
```
<c:choose>
    <c:when test="조건식1"> 조건식1이 참일 경우 실행할 내용 </c:when>
    <c:when test="조건식2"> 조건식2이 참일 경우 실행할 내용 </c:when>
    <c:otherwise> 조건식1과 조건식2 모두 참이 아닐 경우 실행할 내용 </c:otherwise>
</c:choose>

<c:choose>
	<c:when test = "${logStatus != 'Y'}">	
		<li><a href="${url}/member/loginForm">로그인</a></li>
		<li><a href="${url}/member/memberForm">회원가입</a></li>
	</c:when>
	<c:when test = "${logStatus == 'Y'}">
		<li><span style="font-size:0.8em;color:#ddd;">${logId} </span><a href="${url}/member/logout">로그아웃</a></li>
		<li><a href="${url}/member/memberEdit">회원정보 수정</a></li>
	</c:when>
</c:choose>
```