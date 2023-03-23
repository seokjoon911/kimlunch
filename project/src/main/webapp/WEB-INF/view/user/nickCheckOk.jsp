<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 중복확인 결과</title>
<script type="text/javascript">
function thisnick() {
	opener.document.join.nickname.value='${nickname}';
	   self.close();
}
function othernick() {
	self.close();
}
</script>
</head>
<body><table>
<tr><th>중복된 닉네임 아닙니다.</th><td>${nickname}</td></tr><tr><td>
<form class="f_c">
<button class="t" value="이 닉네임 사용" onclick="thisnick()">이 닉네임 사용</button>
<button class="o" value="다른 닉네임 사용" onclick="othernick()">다른 닉네임 사용</button></td></tr></table>
</form>
</body>
</html>