<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복확인</title>
</head>
<body>
	<h3> 이메일 중복체크 </h3>
	
<form:form modelAttribute="user" method="post" action="emailCheckOk">

	<spring:hasBindErrors name="user"><font color="red">
	<c:forEach items="${errors.globalErrors}" var="error">
		<spring:message code="${error.code}"/>
	</c:forEach></font></spring:hasBindErrors>
	
	<form class="f" method="post" action="emailCheckOk" onsubmit="return emailCheck(this)">
		<br>
		이메일 : <input class="email" type="text" name="email" maxlength="25" autofocus required>
		<input type="submit" value="중복확인" onclick="chk()">
	</form>
</form:form>
</body>
<script>
function emailCheck(id){
	const userID = email.email.value;
    let check=true;

    if(check==false)
    {
        alert('사용하실 수 없는 이메일입니다.');
    }

    return check;
}
function chk() {}
</script>
</html>