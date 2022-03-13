<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>SNS_main</title>
    <style>
        * {margin: 0; padding: 0; list-style: none; text-decoration: none; color: inherit; box-sizing: border-box;}
        body {width: 100%;}
        
        #wrap {width : 1000px; height: 100vh; margin: 0 auto;}
                   
        #wrap div.form > h1{
            display: block;
            width: 195px;
            margin: 0 auto;
            padding-bottom: 20px;
            background: linear-gradient(to right, #00067a, #3498db, #8e44ad);
            -webkit-background-clip: text;
              background-clip: text;
            color : transparent;
            font-size: 40px;
            font-weight: bold;
        }
        
        #loginWrap {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            
        }
        #joinWrap {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            display: none;
        }
        
        #findWrap {
        	position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            display: none;
        }
      #wrap > div> div.form {
            width: 400px;
            padding-top : 20px;
            border-width:2px;
            border-style:solid;
            border-image:linear-gradient(to bottom,#00067a, #3498db, #8e44ad); 
            border-image-slice:1;
        }
        
        #loginWrap div.form{
            height: 320px;
        }
        
        #joinWrap div.form {
            height: 500px;
        }
        
        #wrap div.form > form > input {
            display: block;
            width : 300px;
            height: 42px;
            margin: 0 auto;
            margin-bottom: 15px;
            line-height: 42px;
            font-size: 20px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 10px;
        }
        #wrap div.form > form > input[type="date"] {
            display: inline-block;
            width: 243px;
            margin-left : 10px;
        }
        
        #wrap div.form > form > input[type="checkbox"] {
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-left : 60px;
        }
        
        #wrap div.form > form > input[type="radio"] {
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-left : 50px;
        }
        
        #wrap div.form > form > input.btn {
            margin-top: 10px;
            line-height: 30px;
            border: none;
            background: #ccc;
        } 
        
               
        div.changeTab {
            width: 400px;
            line-height: 30px;
            margin-top: 10px;
            padding: 10px 0;
            text-align: center;
            border-width:2px;
            border-style:solid;
            border-image:linear-gradient(to bottom,#8e44ad, #3498db, #00067a); 
            border-image-slice:1;
        }
        div.changeTab>p>span {
            color : #3498db;
            font-weight: bold;
            cursor: pointer;
        }
        
        div.changeTab>p>span:hover {
        	color : coral;
        }
        /* div.changeTab>p>b{
        	cursor: pointer;
        } */
        #chk_email{
        	text-align: center;
        }
        #chk_nick{
        	text-align: center;
        }
        
    </style>
</head>
<body>
   <section id="wrap">
        <div id="loginWrap">
         <div class="form">
          <h1>MilkyWay</h1>
           <form id="loginForm">
           <c:choose>
           		<c:when test="${not empty email}">
           			<input type="email" name="member_email" required="required" placeholder="email" value="${email}">
           		</c:when>
           		<c:otherwise>
	         		<input type="email" name="member_email" required="required" placeholder="email">
           		</c:otherwise>
           </c:choose>
	                <input type="password" name="member_pw" required="required" placeholder="password">
           
           <c:choose>
           		<c:when test="${not empty email}">
           			<input type="checkbox" name="cookie" checked="checked">&nbsp;<span>id 저장</span>
           		</c:when>
           		<c:otherwise>
           			<input type="checkbox" name="cookie">&nbsp;<span>id 저장</span>
           		</c:otherwise>
           </c:choose>
	                <input type="submit" value="login" class="btn">
            </form>
            
            </div>
            <div class="changeTab">
                <p><b>비밀번호를 잊으셔나요? </b> &nbsp;&nbsp; <span>비밀번호찾기</span></p> 
                <p><b>계정이 없으신가요? </b> &nbsp;&nbsp; <span>회원가입</span></p>
            </div>
        </div>
        
        <div id="findWrap">
	        <div class="form">
	          <h1>MilkyWay</h1>
	        	<form id="findpw">
	            	<input type="email" name="email" required="required" placeholder="email" oninput="check_email(event)">
	            	<input type="submit" value="비밀번호 찾기" class="btn">
	            </form>
            </div>
            <div class="changeTab">
                <p><b>계정이 있으신가요? </b> &nbsp;&nbsp; <span>로그인</span></p> 
                <p><b>계정이 없으신가요? </b> &nbsp;&nbsp; <span>회원가입</span></p>
            </div>
        </div>
        
        <div id="joinWrap">
           <div class="form" id="joinForm">
                <h1>MilkyWay</h1>
                <form id="joinForm">
                    <input type="email" autocomplete="off" name="member_email" placeholder="email" id="email" required="required" oninput ="check_email(event)">
                    <div id="chk_email"></div>
                    <input type="password" name="member_pw" required="required" placeholder="password">
                    <input type="text" name="member_name" required="required" placeholder="name">
                    <input type="text" autocomplete="off"  name="member_nick" placeholder="nick" id="nick" required="required" oninput ="check_nick(event)">
                    <div id="chk_nick"></div>
                    <span style="margin-left: 50px;">생 일</span>
                    <input type="date" name="member_birth" required="required">
                    
                    <input type="radio" name="member_gender" value="f" required="required">여성
                    <input type="radio" name="member_gender" value="m" required="required">남성

                    <input type="submit" value="join" class="btn">
                </form>
            </div>
            <div class="changeTab">
                <p><b>계정이 있으신가요? </b> &nbsp;&nbsp; <span>로그인</span></p>
            </div>
        </div>
    </section>
    
    <script>
//        const tab = document.querySelectorAll('.changeTab > p > span')
        const join = document.getElementById('joinWrap')
        const login = document.getElementById('loginWrap')
		const find = document.getElementById('findWrap')
		const findpw = document.getElementById('findpw')
		const loginForm = document.getElementById('loginForm')
		//findpw.hidden=true;
		
        let chk_email=false
		let chk_nick=false
		let chk_find=false
		
         document.querySelectorAll('.changeTab > p > span').forEach(span => span.onclick = function(e){
            e.preventDefault()
            //findpw.hidden=true;
            //loginForm.hidden=false;
            if(e.target.innerText == "회원가입"){
                login.style.display = 'none'
                join.style.display = 'block'
                find.style.display = 'none'
            }
            if(e.target.innerText == "로그인"){
                login.style.display = 'block'
                join.style.display = 'none'
                find.style.display = 'none'
            }
            if(e.target.innerText == "비밀번호찾기"){
            	login.style.display = 'none'
                join.style.display = 'none'
                find.style.display = 'block'  
            }
        })
        
        /* document.querySelector('.changeTab > p > b').onclick=function(e){
        	 	loginForm.hidden=true;
        		findpw.hidden=false;
        } */
         
        findpw.onsubmit=function(e){
        	if(!chk_find){alert('존재하지 않는 email입니다');return;}
        	e.preventDefault()
        	alert('이메일을 발송했습니다 이메일을 확인해주세요')
        	const formdata = new FormData(e.target)
        	const url= '${cpath}/member/modify/auth/'
        	const opt={
        		method : "POST",
        		body : formdata
        	}
        	fetch(url,opt)
        	.then(resp=>resp.text())
        	.then(text=>{
        		if(+text==1){
        			findpw.hidden=true;
                    loginForm.hidden=false;
        		}else{
        			alert('이메일 발송에 실패하였습니다.')
        			findpw.hidden=true;
                    loginForm.hidden=false;
        		}
        	})
        	
        }
        
	document.getElementById('loginForm').onsubmit=function(event){
       	event.preventDefault()
		const formData = new FormData(event.target);
    	const ob = {}
		for (key of formData.keys()) {
			ob[key] = formData.get(key)
		}
    	
       	const url = '${cpath}/member/login/'
       	const opt = {
       			method: 'POST',
       			body: JSON.stringify(ob),
    			headers: {
    				'Content-Type' : 'application/json; charset=utf-8'
    			}
       	}
       	fetch(url,opt)
       	.then(resp=>resp.text())
       	.then(text=>{
       		if(+text!=1){
       			alert('아이디 또는 비밀번호가 존재하지 않습니다');
       		}else{
       			location.href='${cpath}/'
       		}
       	})
	}
       
       document.getElementById('joinForm').onsubmit=function(event){
        event.preventDefault()
        if(!(chk_email&&chk_nick)){alert('이메일 또는 닉네임 중복'); return;}
        
        const formData = new FormData(event.target);
       	const ob = {}
   		for (key of formData.keys()) {
   			ob[key] = formData.get(key)
   		}
       	console.log(JSON.stringify(ob))
          	const url = '${cpath}/member/join/'
          	const opt = {
          			method: 'POST',
          			body: JSON.stringify(ob),
       			headers: {
       				'Content-Type' : 'application/json; charset=utf-8'
       			}
          	}
          	fetch(url,opt)
          	.then(resp=>resp.text())
          	.then(text=>{
          		if(+text==1){
          			alert('회원가입에 성공하셨습니다');
          			event.target.reset();
          			location.reload();
          		}
          	})
   	}
       
    function check_email(event){
    	const url = '${cpath}/member/join/check_email/?email='+event.target.value;
    	const opt = {
    			method : 'GET'
    	}
    	fetch(url,opt)
    	.then(resp=>resp.text())
    	.then(text=>{
    		if(+text==1){
   				if(event.target==document.getElementById('findpw').children[0]){
   					chk_find=true;
   				}else{   					
	    			document.getElementById('email').style.color='red'
	   				document.getElementById('chk_email').style.color='red'
	   				document.getElementById('chk_email').innerText='중복 email 입니다'
	   				chk_email=false;
   				}
    		}else{
 	   			if(event.target==document.getElementById('findpw').children[0]){
 	   				chk_find=false;
   				}else{   					
	    			document.getElementById('email').style.color='blue'
	      			document.getElementById('chk_email').style.color='blue'
	 	   			document.getElementById('chk_email').innerText='사용가능한 email 입니다'
	   				chk_email=true;
   				}
    		}
    	})
    }
    
    function check_nick(event){
    	const nick= event.target.value;
     	const url = '${cpath}/member/join/check_nick/?nick='+encodeURI(nick);
    	const opt = {
    			method : 'GET'
    	}
    	fetch(url,opt)
    	.then(resp=>resp.text())
    	.then(text=>{
    		if(+text==1){
    			document.getElementById('nick').style.color='red'
    			document.getElementById('chk_nick').style.color='red'    			
   				document.getElementById('chk_nick').innerText='중복 ncik 입니다'
   				chk_nick=false;
    		}else{
    			document.getElementById('nick').style.color='blue'
    			document.getElementById('chk_nick').style.color='blue'
    			document.getElementById('chk_nick').innerText='사용가능합니다.'
    			chk_nick=true;
    		}
    	})
    }   
    document.getElementById('email').addEventListener("focus",inpfocus);
    document.getElementById('email').addEventListener("blur",inpblur);
    document.getElementById('nick').addEventListener("focus",inpfocus);
    document.getElementById('nick').addEventListener("blur",inpblur);
    
    function inpfocus(e){
    	if(e.target.getAttribute('id')=='email'){
    		document.getElementById('chk_email').style.display='block'
    	}else{
    		document.getElementById('chk_nick').style.display='block'
    	}
    }
    function inpblur(e){
    	if(e.target.getAttribute('id')=='email'){
    		document.getElementById('chk_email').style.display='none'
/*     		if(!chk_real){
    			alert('메일 인증 메일 발송했습니다 인증번호를 확인해주세요');
    			real(e.target.value)
    		} */
    	}else{
    		document.getElementById('chk_nick').style.display='none'
    	}
    }
    
    
    
    </script>
    
</body>
</html>