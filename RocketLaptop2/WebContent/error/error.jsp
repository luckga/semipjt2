<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<html>
	<head>
		<title>Error</title>
		<style>
			@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

			*{
				font-family: 'Do Hyeon', sans-serif;
			}
			
			body{
				background-image : url("image/error.jpg");
			}
			
			div{
				text-align : center;
				font-size : 100px;
				margin-top : 200px;
				color : white;
			}
		</style>
	</head>
	<body>
		<div>Error<br> ${message} <br> 에러가 발생했습니다.</div>
	</body>
</html>