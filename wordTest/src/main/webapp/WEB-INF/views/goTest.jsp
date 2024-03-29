<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>단어 시험</title>
	<link rel = "stylesheet" href = "/resources/css/wordTest.css">
</head>
<script>
	var arr = new Array;  //단어
	var arr2 = new Array;  //문장
	
	<c:forEach items="${elist}" var="dataVO">
		arr.push({en:"${dataVO.en}",kr:"${dataVO.kr}",level:"${dataVO.level}"});
	</c:forEach>
	<c:forEach items="${slist}" var="dataVO">
		arr2.push({en:"${dataVO.en}",kr:"${dataVO.kr}",level:"${dataVO.level}",enSentence:"${dataVO.enSentence}",krSentence:"${dataVO.krSentence}"});
	</c:forEach>
	console.log(arr[0].en);
	
	var lastScore = 0;
	var grade="F";
	
	//채점
	function score(){
		var score = 0;
		for (var i =0; i<arr.length;i++){
			var id = arr[i].en
			var answer = document.getElementById(id).value;
			console.log(answer);
			console.log(arr[i].kr);
			if(answer!=="" && (arr[i].kr).includes(answer)){
				console.log(i+"번 정답");
				score++;
			}
			else{
				document.getElementById(arr[i].kr).innerText="오답";
				console.log(i+"번 오답");
			}
		}
		
		for (var i =0; i<arr2.length;i++){
			var id = arr2[i].en
			var answer = document.getElementById(id).value;
			console.log(answer);
			console.log(arr[i].kr);
			if(answer === arr2[i].en){
				console.log(i+"번 정답");
				score++;
			}
			else{
				document.getElementById(arr2[i].kr).innerText="오답";
				console.log(i+"번 오답");
			}
		}
		console.log(score/arr.length);
		
		//점수
		document.getElementById("score").innerText="맞힌 개수 : "+score+"";
		var size = arr.length+arr2.length;
		console.log(size);
		var scoreNum=parseInt((score/size)*100);
		console.log(scoreNum);
		grade="A";
		if(scoreNum<80){
			var log = (size-score)*5
			document.getElementById("time").innerText="늘어나는 수업 시간 : "+log+"분";
			document.getElementById("comment").innerText="멀어져가는 인서울의 꿈...";
			grade="B";
			if(scoreNum<60){
				document.getElementById("comment").innerText="경기도를 알아보기 시작하는 점수..."
				grade="C";
			}
			if(scoreNum<40){
				grade="F";
				document.getElementById("comment").innerText="oh shit 그대는 치킨대학교에 가겠군요"
			}
		}
		else{
			document.getElementById("comment").innerText="서울대도 꿈은 아니다!";
		}
		if(lastScore===0){
			lastScore = parseInt(scoreNum);
		}
		
		alert(parseInt(scoreNum));
		
	}
	
	
	// 시험 점수 제출
	function submitScore(){
		let today = new Date();
		var time = today.toLocaleString();
		alert(time+" 결과를 제출합니다");
		console.log(lastScore);
		var seq = "${seq}";
		location.href = "/score?score="+lastScore+"&time="+time+"&option=insert&grade="+grade+"&chapter="+seq;
	}
</script>
<body>
	<div id="header" class="header">
		<h1> 단어 시험</h1>
		<h2 id="comment"></h2>
		<h4> 1과 (80점 미만이면 틀린 개수만큼 5분씩 추가)</h4>
		<p id="score"></p>
		<p id="time"></p>
	</div>
	
	<br><hr><br>
	<table>
		<thead>
			<tr>
				<th>단어</th>
				<th>답</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${elist}" var="dataVO">
				<tr>
					<td><c:out value="${dataVO.en}"></c:out> <p id="${dataVO.kr}"></p></td>
					<td><input id= "${dataVO.en}" type="text" value=""></td>
				</tr>
		
		
			</c:forEach>
		</tbody>
	</table>
	
	<br>
	
	<table>
		<thead>
			<tr>
				<th>영어문장</th>
				<th>뜻</th>
				<th>빈칸 단어</th>
			</tr>
		</thead>
				<tbody>
			<c:forEach items="${slist}" var="dataVO">
				<tr>
					<td><c:out value="${dataVO.enSentence}"></c:out> <p id="${dataVO.kr}"></p></td>
					<td><c:out value="${dataVO.krSentence}"/></td>
					<td><input id= "${dataVO.en}" type="text" value=""></td>
				</tr>
		
		
			</c:forEach>
		</tbody>
	</table>
		
	<br><br>
	<button onclick="score()" type="submit" value="채점하기">채점하기</button>
	<button onclick="submitScore()">제출하기</button>
	
	
	
</body>
</html>