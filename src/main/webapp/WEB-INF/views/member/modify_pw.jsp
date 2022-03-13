<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#wrap {
	width: 1600px;
	height: 1300px;
}

#wrap>div {
	margin-top:100px;
	margin-left: auto;
	margin-right: auto;
	width: 50%;
	height: 50%;
	text-align: center;
	
}
#wrap>div>form{
	display: flex;
	flex-flow: column;
	align-items: center;
	width: 100%;
	height: 100%;
	
}

#wrap>div>form>input {
	margin-top: 20px;
	border: groove;
	display: inline-block;
	width: 300px;
	text-align: center;
    border: outset;
    border-bottom: solid;
    border-radius: 10px;
}
}
#wrap>div>form>input[type="submit"] {
	width: 150px;
	height:30px;
	margin-left: 75px;
	margin-top: 20px;
	border: none;
}
</style>
</head>
<body>
<div id="wrap">
	<div>
		<h1>MilkyWay</h1>
		<form id="pwform" method="post">
			<input type="email" name="email" readonly="readonly"  value="${email }">		
			<input type="password" name="password" placeholder="변경할 비밀번호를 입력하세요">
			<input type="password" name="chk_pw" placeholder="비밀번호 확인">
			<input type="submit" value="제출">
		</form>
	</div>
</div>

<script>
	document.getElementById('pwform').onsubmit=function(e){
		e.preventDefault()
		const pw = document.querySelector('input[name="password"]').value
		const chk_pw = document.querySelector('input[name="chk_pw"]').value
		if(pw==chk_pw){
			document.getElementById('pwform').submit()
		}else{
			alert('비밀번호가 일치하지 않습니다.')
		}
	}
</script>

</body>
</html>