<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="${cpath }/resources/style.css">
    <title>SNS-main</title>
</head>
<body>
    <header id="header" class="clearfix">
        <h1 class="logo"><a href="${cpath }/">MilkyWay</a></h1>
        <form id="searchForm" method="get" action="${cpath }/hashSearch" >
            <input type="text" id="searchHash" name="search" placeholder="검색" value="${hashtag }">
        </form>
        <div class="iconWrap">
            <i class="xi-home xi-2x" title="home"></i>
            <i class="xi-users-o xi-2x" title="친구목록"></i>
            <i class="xi-bell-o xi-2x" title="알람"></i>
            <i class="xi-plus-circle xi-2x" id="newBoard" title="스토리추가"></i>
            <i class="xi-radiobox-blank xi-2x" title="profile" onclick="location.href='${cpath}/member/modify/'"></i>
        </div>
    </header>
    
    <div id="modal">
        <h2>게시물 만들기</h2>
        <hr>
        <form id="writeBoard"  enctype="multipart/form-data" method="post">
      <div  class="title" id="content" contenteditable="true"  oninput="hashtag(event)" data-placeholder="무슨 생각을 하고 계신가요?"></div>
        <div id="hashtag"></div>
           <div class="image"></div>
           <div class="filebox">
               <label for="uploadFile">사진</label> 
               <input type="file" id="uploadFile"accept="image/*" onchange="imgUp(this)" multiple="multiple">
           </div>
         <input type="submit">
        </form>
    </div>

    <div class="bg"></div>
    
    
    <script>
    const newBoard = document.getElementById('newBoard')
    const bg = document.querySelector('.bg')
    const modal = document.querySelector('#modal')
    newBoard.onclick = function(){
        modal.style.display = 'block'
        bg.style.display = 'block'
    }
    bg.onclick = function(){
        modal.style.display = 'none'
        bg.style.display = 'none'
    }
    </script>
    
<!--     이미지 올렸을때 미리보기 4개 -->
    <script>
        const uploadFile = new Array()
        var imgName = new Array()
        function imgUp(upload){
           
            const file = upload.files
              for(let i=0;i<file.length;i++){
                 let flag =true
               for(let b=0;b<uploadFile.length;b++){
                  if(uploadFile[b].name==file[i].name){
                     flag=false;
                  }
               }
               
              imgName.push(file[i].name)
               if(flag){
                   uploadFile.push(file[i])
                  if(uploadFile.length<=4){
                     const img = document.createElement("img")
                      img.setAttribute("class", 'img')
                      img.src = URL.createObjectURL(file[i])
                      img.setAttribute("title",file[i].name)
                      const image = document.querySelector('.image')
                      image.appendChild(img)
                  }else{
                         uploadFile.pop()
                         alert('4개까지 첨부');
                         break;
                       }
                       
                    }
                 }
        
            // upload 이미지 클릭시 이미지 삭제
        document.querySelectorAll('.img').forEach(img => img.onclick = function(e){
            //e.target.remove()
            const name = e.target.title    
            console.log("삭제 이름 : " + name)
           // const index = uploadFile.indexOf(name)					// uploadFile -> file -> name 이 있어서인지 반환이 -1로 됨
           const index = imgName.indexOf(name)
            console.log("삭제 index : " + index)
            uploadFile.splice(index, 1)
            imgName.splice(index, 1)
            console.log(uploadFile)
           e.target.style.display="none"
            console.log(uploadFile.length)
        })
} 
</script>
    
<!--     게시글 등록 -->
    <script>
    document.forms.writeBoard.onsubmit = function(event){
        event.preventDefault()
        const writer = '${login.member_nick}'
        const content = document.getElementById("content").innerHTML
        console.log("content : " + content)
        const hashtag = document.getElementById("hashtag").innerText
        console.log("hashtag : " + hashtag)
        
        for(let i=0; i < uploadFile.length ; i++){
           console.log(uploadFile[i])
        }
        const formData = new FormData(event.target)   
        console.log("formData : "+formData)
        for(let i = 0; i < uploadFile.length; i++){
              formData.append("uploadFile", uploadFile[i]);
        }  
        formData.append("writer", writer)
        formData.append("content", content)
        formData.append("hashtag", hashtag)
        
        
        const url = "${cpath}/"
           const opt = {
              method: 'POST',
              body: formData,
           }
        fetch(url, opt)
        .then(resp => resp.text())
        .then(text => {
           console.log(text)
           if(+text == 1){
              alert("게시글을 등록하였습니다.")
              location.href = "${cpath}/"
           }else{
                alert("게시글 등록 실패하였습니다.")
              location.href = "${cpath}/"
           }
        })
        
     }
    </script>
    
<!--   해시태그 -->
    <script>
    
    function hashtag(event){
      const content =event.target.innerText.replaceAll("\n" , " ")
      const hashArea = document.getElementById("hashtag")
      let text ='';
      let splited= content.split(' ')
      hash = '';
      for(let i=0;i<splited.length;i++){
        if(i==content.lastIndexOf(" ")==content.length)
           text+=" "
         if(splited[i].indexOf('#')==-1){
            text+=splited[i]+" "
         }else{
            let splited2 =splited[i].split('#')
            for(let b=0;b<splited2.length;b++){
               if(b==0){
                  text+=splited2[b]
               }else if(b==splited2.length-1){
                     text+='<a href=" ">#'+splited2[b]+'</a>'+' '
                     hash += '<a href=" ">#'+splited2[b]+'</a>'+' '
               }else{
                      text+='<a href=" ">#'+splited2[b]+'</a>'
                     hash += '<a href=" ">#'+splited2[b]+'</a>'+' '
               }
            }
           
         }
      }
       hashArea.innerHTML = hash
      console.log(text)
      /* event.target.innerHTML=text;
      const b= window.getSelection()
     let a = event.target.innerText.length
     let c = b.anchorNode
     b.collapse(c,a) */
      
    }
    </script>
    
    
<!--     드래그 앤 드랍 -->
   <script>
   
   let dropbox;

   dropbox = document.querySelector(".image");
   dropbox.addEventListener("dragenter", dragenter, false);
   dropbox.addEventListener("dragover", dragover, false);
   dropbox.addEventListener("drop", drop, false);
   
   function dragenter(e) {
        e.stopPropagation();
        e.preventDefault();
      }

   function dragover(e) {
     e.stopPropagation();
     e.preventDefault();
   }
   
   function drop(e) {
        e.stopPropagation();
        e.preventDefault();

        const dt = e.dataTransfer;
        const files = dt.files;

        imgUp(files);
      }
   </script>