<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
</head>

<body>
	<h3> 댓글 수정 </h3>
<%-- --%>	
	<spring:hasBindErrors name="user"><font color="red">
	<c:forEach items="${errors.globalErrors}" var="error">
		<spring:message code="${error.code}"/>
	</c:forEach></font></spring:hasBindErrors>

	<p>
		<label>댓글 작성자</label> <input type="text" name="writer" value="${sessionScope.loginUser.getNickname()}" readonly="true">
	</p>
	<p>
		<textarea rows="5" cols="50" id="content"></textarea>
	</p>
	<p>
		<button type="submit" onclick="javascript:updateComment()">수정하기</button>
	</p>
</body>
<script>
function updateComment(){
	$.ajax({
		url: "../ajax/addComment",
    	type: "POST",
    	data:{
    		bno: ${board.bno},
    		cno: "cno",
    		content: "content",
    		userid : "${sessionScope.loginUser.userid}",
    		content: document.getElementById("content").value
    	},
		success: function(){ //http code: 200 => 202 201
			history.go(0);
		}
	})
}
</script>
</html>