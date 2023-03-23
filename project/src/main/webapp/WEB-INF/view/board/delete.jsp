<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /springmvc2/src/main/webapp/WEB-INF/view/board/update.jsp --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 삭제 화면</title>
<script type="text/javascript">
<c:if test="${pageContext.request.method=='POST'}">  	
	alert("삭제되었습니다.");
	opener.location.href="list?boardid=1";
	self.close();
</c:if>
</script>
<style type="text/css"> .errortext {color : red;}</style>
</head><body>
<form:form modelAttribute="board" action="delete" name="deleteform">
<form:hidden path="bno" />  
<form:hidden path="userid" />
<table><caption>게시글 삭제 화면</caption>
	<tr><td>삭제를 원하시면 사용자 본인의 비밀번호를 입력하세요</td></tr>
	<tr><td><input type="password" name="password" /></td></tr>
	<tr><td colspan="2">
	<button value="게시글 삭제" >
	게시글 삭제</button></td></tr>
</table>
</form:form></body></html>
