<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디중복확인</title>
</head>
<body>
	<h3> 아이디 중복체크 </h3>
	
<form:form modelAttribute="user" method="post" action="idCheckOk">

	<spring:hasBindErrors name="user"><font color="red">
	<c:forEach items="${errors.globalErrors}" var="error">
		<spring:message code="${error.code}"/>
	</c:forEach></font></spring:hasBindErrors>
	
	<form class="f" method="post" action="idCheckOk" onsubmit="return IDCheck(this)">
		<br>
		아이디 : <input class="id" type="text" name="userid" maxlength="10" autofocus required>
		<input type="submit" value="중복확인" onclick="chk()">
	</form>
</form:form>
</body>
<script>
function IDCheck(id){
	const userID = id.personName.value;
    let check=true;

    for(let i=0; i<userID.length; i++)
    {
        let temp = userID.charCodeAt(i);
        if( (65<=temp && temp<=90 || 97<=temp && temp<=122 || 48<=temp && temp<=57)&&userID.length>=5 && userID.length<=15 )  {
        }
        else{
            check=false;
            break;
        }
    }
    if(check==false)
    {
        alert('사용하실 수 없는 아이디입니다.');
    }

    return check;
}

function chk() {}
</script>
</html>