<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인 결과</title>
<script type="text/javascript">
function thisid() {
	opener.document.join.userid.value='${userid}';
	   self.close();
}
function otherid() {
	self.close();
}
</script>
</head>
<body><table>
<tr><th>중복된 아이디가 아닙니다.</th><td>${userid}</td></tr><tr><td>
<form class="f_c">
<button class="t" value="이 아이디사용" onclick="thisid()">이 아이디사용</button>
<button class="o" value="다른 아이디사용" onclick="otherid()">다른 아이디사용</button></td></tr></table>
</form>
</body>
</html>