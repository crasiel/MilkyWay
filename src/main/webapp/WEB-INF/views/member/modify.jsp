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

        #joinWrap {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
        }
        #wrap div.form > form > button{
        	margin-left: 150px;
        	margin-right: 150px;
        	margin-bottom: 15px;
        }
        
      #wrap > div> div.form {
            width: 400px;
            height: 550px;
            padding-top : 20px;
            border-width:2px;
            border-style:solid;
            border-image:linear-gradient(to bottom,#00067a, #3498db, #8e44ad); 
            border-image-slice:1;
        }
        
        #joinWrap div.form {
            height: 700px;
        }
        
        #wrap div.form > form > .m {
        	text-align:center;
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
        
        #wrap div.form > form > input[type="radio"] {
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-left : 50px;
            margin-top: 15px;
        }
        
        #wrap div.form > form > input.btn {
	        display: inline-block;
            width : 150px;
            height: 42px;
            margin: 0 auto;
            margin-bottom: 15px;
            line-height: 42px;
            font-size: 20px;
            padding: 5px;
            margin-top: 10px;
            line-height: 30px;
            border: none;
            background: #ccc;
            cursor: pointer;
            text-align: center;
        } 
        #wrap div.form > form > #logout {
	        display: inline-block;
            width : 150px;
            height: 42px;
            margin: 0 auto;
            margin-left: 115px;
            margin-bottom: 15px;
            line-height: 42px;
            font-size: 20px;
            padding: 5px;
            margin-top: 25px;
            line-height: 30px;
            border: none;
            background: #ccc;
            cursor: pointer;
            text-align: center;
        } 
    	#wrap div.form > form > #submit{
    		margin-left: 40px;
    		text-align: center;
    	}    
		#wrap div.form > form > .hidden{
			display: none;	
		}
    </style>
</head>
<body>
   <section id="wrap">
        <div id="joinWrap">
           <div class="form" id="joinForm">
                <h1>MilkyWay</h1>
                <form id="Form">
                	<div class="m email">
                		${dto.member_email}
                	</div>
                	<div id="chk_email" style="display:none; text-align: center;">
                	</div>
                   	
                    <div class="m name">
                    ${dto.member_name}
                    </div>
                    <div class="m nick">
                    	${dto.member_nick }
                    </div>
                   	<div id="chk_nick" style="display:none; text-align: center;">
                	</div>
                    <span style="margin-left: 50px;">??? ???</span>
                    <input type="date" name="member_birth" readonly="readonly" value="${dto.member_birth }">
                    <c:choose>
                    	<c:when test="${dto.member_gender eq 'f'}">
		                    <input type="radio" name="member_gender" value="f" checked="checked" onclick="return(false);">??????
		                    <input type="radio" name="member_gender" value="m" onclick="return(false);">??????
						</c:when>
                    	<c:when test="${dto.member_gender eq 'm'}">
		                    <input type="radio" name="member_gender" value="f" onclick="return(false);">??????
		                    <input type="radio" name="member_gender" value="m" checked="checked" onclick="return(false);">??????
						</c:when>
					</c:choose>
                    <input type="button" value="??????" class="btn" id="submit">
                    <input type="button" id="chgpw" value="???????????? ??????" class="btn">
                    <input type="button" id="logout" value="????????????" class="btn">
                </form>
             </div>
        </div>
    </section>
    
<script>
let Formsubmit=false;
let chknick=false;
let chkemail=false;

document.getElementById('logout').onclick= function(e){
	e.preventDefault();
	location.href="${cpath}/member/logout/";
}
document.getElementById('chgpw').onclick= function(e){
	alert('???????????? ??????????????????. ???????????? ??????????????????')
	e.preventDefault();
	let formdata = new FormData();
	const email = document.querySelector('.email').innerText;
	formdata.append("email",email);
	const url = '${cpath}/member/modify/auth/'
	const opt = {
			method:"POST",
			body: formdata
	}
	fetch(url,opt)
	.then(resp=>resp.text())
	.then(text=>{
		if(+text==1){
			console.log(text)
		}else{
			alert('????????? ????????? ??????????????????')
		}
	})
}

document.getElementById('submit').onclick=function(e){
	e.preventDefault();
	if(Formsubmit){
		if(chknick || chkemail){
			let formData= new FormData(document.getElementById('Form'));
			const nick=document.querySelector('.nick').innerText
			const email=document.querySelector('.email').innerText
			formData.append("member_nick",nick)
			formData.append("member_email",email)
			const url='${cpath}/member/modify/NickandEmail/'
			const opt={
					  method: 'POST',
				        body: formData
			}
			
			fetch(url,opt)
			.then(resp=>resp.text())
			.then(text=>{
				if(+text==1){
					alert("????????????")
					location.href="${cpath}/"
				}else{
					alert("????????????")
				}
			})
		}
		e.target.type='button';
		document.querySelector('.email').contentEditable=false
		document.querySelector('.nick').contentEditable=false
		Formsubmit=false;
		return;
	}
	e.target.type='submit';
	document.querySelector('.email').contentEditable=true
	document.querySelector('.nick').contentEditable=true
	document.querySelector('.email').focus()
	Formsubmit = true;
}
document.querySelector('.email').addEventListener("input",check);
document.querySelector('.nick').addEventListener("input",check);
document.querySelector('.email').addEventListener("focus",inpfocus);
document.querySelector('.email').addEventListener("blur",inpblur);
document.querySelector('.nick').addEventListener("focus",inpfocus);
document.querySelector('.nick').addEventListener("blur",inpblur);

function check(event){
	let url='';
	if(event.target.getAttribute("class")=="m email"){
		url = '${cpath}/member/join/check_email/?email='+event.target.innerText;
	}else{
		url = '${cpath}/member/join/check_nick/?nick='+encodeURI(event.target.innerText);
	}
	const opt = {
			method : 'GET'
	}
	fetch(url,opt)
	.then(resp=>resp.text())
	.then(text=>{
		if(+text==1){
			event.target.style.color='red'
			if(event.target.getAttribute("class")=="m email"){
			document.getElementById('chk_email').style.color='red'
			document.getElementById('chk_email').innerText='?????? email ?????????'
			chkemail=false;
			}else{
				document.getElementById('chk_nick').style.color='red'
				document.getElementById('chk_nick').innerText='?????? ????????? ?????????'
				chknick=false;
			}	
		}else{
			event.target.style.color='blue'
			if(event.target.getAttribute("class")=="m email"){
				document.getElementById('chk_email').style.color='blue'
	 			document.getElementById('chk_email').innerText='??????????????? email ?????????'
	 				chkemail=true;
				}else{
					document.getElementById('chk_nick').style.color='blue'
			 		document.getElementById('chk_nick').innerText='??????????????? ????????? ?????????'
		 			chknick=true;
				}			
			
		}
	})
}

function inpfocus(e){
	if(e.target.getAttribute('class')=='m email'){
		document.getElementById('chk_email').style.display='block'
	}else{
		document.getElementById('chk_nick').style.display='block'
	}
}
function inpblur(e){
	if(e.target.getAttribute('class')=='m email'){
		document.getElementById('chk_email').style.display='none'
	}else{
		document.getElementById('chk_nick').style.display='none'
	}
}



</script>
    
</body>
</html>