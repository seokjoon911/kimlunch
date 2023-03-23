<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 중복확인</title>
</head>
<body>
	<h3> 닉네임 중복체크 </h3>
	
<form:form modelAttribute="user" method="post" action="nickCheckOk">

	<spring:hasBindErrors name="user"><font color="red">
	<c:forEach items="${errors.globalErrors}" var="error">
		<spring:message code="${error.code}"/>
	</c:forEach></font></spring:hasBindErrors>
	
	<form class="f" method="post" action="nickCheckOk" onsubmit="return nickCheck(this)">
		<br>
		닉네임 : <input class="nick" type="text" name="nickname" maxlength="10" autofocus required>
		<input type="submit" value="중복확인" onclick="chk()">
	</form>
</form:form>
</body>
<script>
function nickCheck(id){
	const userID = nick.nickname.value;
    let check=true;

    if(check==false)
    {
        alert('사용하실 수 없는 닉네임입니다.');
    }

    return check;
}
function chk() {}
</script>
</html>