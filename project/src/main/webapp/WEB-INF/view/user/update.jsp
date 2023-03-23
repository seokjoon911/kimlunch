<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    
<%-- /springmvc1/src/main/webapp/WEB-INF/view/user/update.jsp --%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>사용자 정보 수정</title></head>
<body>
<h2>사용자 정보 수정</h2>
<form:form modelAttribute="user" method="post" action="update">
  <spring:hasBindErrors name="user">
    <font color="red">
      <c:forEach items="${errors.globalErrors}" var="error">
        <spring:message code="${error.code}" />
      </c:forEach>
    </font>
  </spring:hasBindErrors>
<table border="1" style="border-collapse: collapse;" class="w3-table">
<tr>
	<td>아이디</td>
	<td><form:input path="userid" class="w3-input" readonly="true" />
		<font color="red"><form:errors path="userid"/></font></td>
</tr>
<tr>
	<td>비밀번호</td>
	<td><form:password path="password" class="w3-input" />
		<font color="red"><form:errors path="password" /></font></td>
</tr>
<tr>
	<td>이름</td>
	<td><form:input path="name" class="w3-input" />
		<font color="red"><form:errors path="name" /></font></td>
</tr>
<tr>
	<td>닉네임</td>
	<td><form:input path="nickname" class="w3-input" readonly="true" />
	<font color="red"><form:errors path="nickname"/></font></td>
</tr>
<tr>
	<td>연락처</td>
	<td><form:input path="phoneno" class="w3-input" />
		<font color="red"><form:errors path="phoneno"/></font></td>
</tr>
<tr>
	<td>이메일</td>
	<td><form:input path="email" class="w3-input" readonly="true" />
		<font color="red"><form:errors path="email"/></font></td>
</tr>
<tr>
	<td>성별</td>
	<td><input type="radio" name="gender" value="1" checked />남
		<input type="radio" name="gender" value="2" checked />여
	<font color="red"><form:errors path="gender" /></font></td>
</tr>
<tr>
	<td>직장</td>
	<td><select name="address">
			<option value="강남구">강남구</option>
			<option value="강동구">강동구</option>
			<option value="강북구">강북구</option>
			<option value="강서구">강서구</option>
			<option value="관악구">관악구</option>
			<option value="광진구">광진구</option>
			<option value="구로구">구로구</option>
			<option value="금천구">금천구</option>
			<option value="노원구">노원구</option>
			<option value="도봉구">도봉구</option>
			<option value="동대문구">동대문구</option>
			<option value="동작구">동작구</option>
			<option value="마포구">마포구</option>
			<option value="서대문구">서대문구</option>
			<option value="서초구">서초구</option>
			<option value="성동구">성동구</option>
			<option value="성북구">성북구</option>
			<option value="송파구">송파구</option>
			<option value="양천구">양천구</option>
			<option value="영등포구">영등포구</option>
			<option value="용산구">용산구</option>
			<option value="은평구">은평구</option>
			<option value="종로구">종로구</option>
			<option value="중구">중구</option>
			<option value="중랑구">중랑구</option>
	</select></td>
</tr>
<tr><td colspan="2" align="center">
	<input type="submit" value="등록" class="w3-input" >
	<input type="reset" value="초기화" class="w3-input" ></td>
	</tr>
  </table></form:form></body></html>