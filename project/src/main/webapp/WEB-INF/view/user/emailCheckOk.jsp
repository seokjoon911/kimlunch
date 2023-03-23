<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복확인 결과</title>
<script type="text/javascript">
function thisid() {
	opener.document.join.email.value='${email}';
	   self.close();
}
function otherid() {
	self.close();
}
</script>
</head>
<body><table>
<tr><th>중복된 이메일이 아닙니다.</th><td>${email}</td></tr><tr><td>
<form class="f_c">
<button class="t" value="이 이메일사용" onclick="thisid()">이 이메일사용</button>
<button class="o" value="다른 이메일사용" onclick="otherid()">다른 이메일사용</button></td></tr></table>
</form>
</body>
</html>