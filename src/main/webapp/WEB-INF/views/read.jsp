<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<section id="wrap"  class="clearfix">
<a href="${cpath }"><i class="xi-arrow-left xi-2x"></i></a>
    <div id="leftWrap">
         <h2>${read.idx }</h2>  
         <div class="tapWrap">
              <div id="tabBtn">
                  <c:forEach var="img" items="${read.getFileList() }" varStatus="status">
                   <div title="${status.index + 1}"></div>
                  </c:forEach>
                 </div>
                 <div>
                    <div id="prev">◁</div>
                    <div id="next">▷</div>
                 </div>
                 <div id="tabImg" class="${read.idx }">
                      <c:forEach var="img" items="${read.getFileList() }" varStatus="status">
                     <c:choose>
                        <c:when test="${status.index + 1 eq 1}">
                              <div style="height : 600px; background-size:contain; background-image: url('${cpath }/upload/${status.current }'); background-repeat : no-repeat; background-position : center center;" class="conImg on" title="1"></div>
                        </c:when>
                        <c:when test="${status.index + 1 ne 1}">
                              <div style="height : 600px; background-size:contain; background-image: url('${cpath }/upload/${status.current }'); background-repeat : no-repeat; background-position : center center;" class="conImg" title="${status.index + 1 }"></div>
                        </c:when>
                     </c:choose>
                       </c:forEach>

                 </div>
             </div>
        </div>     
        <div id="rightWrap">
           <h2>작성자 :  ${read.writer }</h2>
             <div class="readContent"> content 내용 : ${read.getContent() }</div>
                <div class="replyWrap">
                       
                            <c:if test="${login.member_nick != null }">
                            <div class="reply">
                                <details>
                                    <summary>댓글작성</summary>

                                        <form method="post" id="replyForm" class="re_form">
                                           <input type="hidden" name="board_idx" value="${read.idx }">  
                                            <input type="text" name="reply_nick" value="${login.member_nick }" class="re_user" readonly>
                                            <input name="reply_content"  class="re_cont">
                                            <input type="submit" class="sub_btn" value="댓글작성"> 
                                        </form>
                                </details>
                            </div>
                            </c:if>
                           

                            <div class="replyList">
                                <ul style="height : 500px;overflow-y: scroll; ">
                                
                                <c:forEach var="reply" items="${reList}">
                                
                                    <li> 
                                           <input type="text" name="reply_nick" value="${reply.reply_nick }" class="re_user" readonly>
                                        <c:choose>
                                        	<c:when test="${reply.recommend }">
                                        		<i class="red xi-heart xi-2x" name="recommend" id="recommend"><input type="hidden" name="idx" value="${reply.reply_idx }"></i><span>${reply.count }</span>
                                    	   </c:when>
                                    		<c:otherwise>
                                    			<i class="xi-heart-o xi-2x" name="recommend" id="recommend"><input type="hidden" name="idx" value="${reply.reply_idx }"></i></i><span>${reply.count }</span>
                                    		</c:otherwise>
                                    	</c:choose>
                                           <c:if test="${login.member_nick eq reply.reply_nick }">
                                              <div class="sub_btn r_sub" onclick="location.href='${cpath}/read/deleteReply/${reply.reply_idx }?idx=${read.idx }&r_reply_idx=0'">삭제</div>
                                           </c:if>
                                        <br>
                                        <details style="width : 100%">
                                        <summary style="width : 100%">
                                        <span>${reply.reply_content }</span> <span>${reply.reply_date }</span>
                                       
                                        </summary>
                                           <c:if test="${login.member_nick eq read.writer}">
                                               <form method="POST" class="re_form r_re">
                                               <input type="hidden" name="reply_idx" value="${reply.reply_idx }">
                                               <input type="hidden" name="type" value="1">
                                               <input type="text" name="r_reply_nick" value="${login.member_nick }"  class="re_user">
                                               <input name="r_reply_content"  class="re_cont">
                                               <input type="submit" class="sub_btn" value="답글작성"> 
                                               </form>
                                           </c:if>
                                        </details>
                                        
                                       
                                    </li>
                                    <c:forEach var="r_reply" items="${r_reList }">
                                    <c:if test="${r_reply.reply_idx eq reply.reply_idx  }">
                           <li style = "background : #ddd; font-size : 14px;padding-left : 30px;">
                              
                                           <input type="text" name="reply_nick" value="${r_reply.r_reply_nick }" class="re_user" readonly>
                                           <span>${r_reply.r_reply_content }</span> <span>${r_reply.r_reply_date }</span>
                                           <c:if test="${login.member_nick eq r_reply.r_reply_nick }">
                                              <div class="sub_btn r_sub_btn"  onclick="location.href='${cpath}/read/deleteReply/${reply.reply_idx }?idx=${read.idx}&r_reply_idx=${r_reply.r_reply_idx }'">삭제</div>
                                           </c:if>
                                    </li>
                                    </c:if>
                                    </c:forEach>
                                    </c:forEach>
                                    
                                </ul>
                            </div>
                    </div>
                   </div> 
                

</section>
<!--  <script>
   const r_replyForm = document.querySelectorAll('.r_re's)
   r_replyForm.onsubmit = function(event){
      event.preventDefault()
      const reply_idx = event.target
      const url = '${cpath}/read/' + reply_idx
      const opt = {
            method : 'PUT',
            'ContentType' : 'application/json; charset=utf-8'
      }
      
      fetch(url, opt).then(resp => resp.text())
      .then(text => {
            
      })
   }
</script>

<script>
   function delete(reply_idx){
      console.log(reply_idx)
      const url='${cpath}/read/'+ reply_idx
      const opt = {
            method : 'DELETE'
      }
      fetch(url, opt).the(resp => resp.text())
      .then(text => {
         if(text == 1){
            alert('댓글을 삭제하였습니다.')
         }else{
            '본인이 작성한 댓글만 삭제할 수 있습니다.'
         }
      })
   }
</script>--> 

<script>
        const prev = document.getElementById('prev')
        const next = document.getElementById('next')
        const imgs = document.querySelectorAll('.tapWrap > #tabImg > div')
        //console.log(imgs)
        const img = document.querySelector('.tapWrap > #tabImg > div')
        const leng = document.querySelector('.tapWrap > #tabImg').childElementCount
        console.log(leng.childElementCount)
        var i = img.title
        prev.onclick = function(e){
            e.preventDefault()
                   
            if(i == 1){  
                imgs[0].classList.remove('on')
                imgs[leng - 1].classList.add('on')
                i = leng
                console.log(i)
            }else{  
                imgs[i-1].classList.remove('on')
                imgs[i-2].classList.add('on')
                i--
                console.log(i)
            }
            
        }
         next.onclick = function(e){
             e.preventDefault()     
            if(i == leng){  
                imgs[leng - 1].classList.remove('on')
                imgs[0].classList.add('on')
                i = 1
                console.log(i)
            }else{  
                imgs[i-1].classList.remove('on') 
                imgs[i].classList.add('on')
                i++
                console.log(i)
            }
            
        }   

    </script>
    <script>
        document.querySelectorAll('.tapWrap > #tabBtn > div').forEach(div => div.onclick = function(e){
           e.preventDefault();
            console.log(e.target)
            const i = e.target.title
            const img = document.querySelectorAll('#tabImg > div')
            for(let j = 0; j < img.length; j++){
                if(img[j].classList.contains('on')){
                img[j].classList.remove('on')
                }
                if( i-1 == j){
                    img[i-1].classList.add('on')
                }
            }           

        })
    </script>
    
   <script>
     const recommend = document.querySelectorAll('.replyList>ul>li').forEach(i => i.onclick = function(e){
   	  	const target = e.target
   	  	if(!(target.classList.contains('xi-heart-o')||target.classList.contains('xi-heart'))){return;}
//             target.classList.toggle('red')
         if(!target.classList.contains('red')){
            target.classList.remove('xi-heart-o')
            target.classList.add('red','xi-heart')
            const r_idx = target.children[0].value
            recommend_fetch(r_idx,target,'count')
            // 좋아요 넘길 값 
          }else{
             target.classList.remove('xi-heart','red')
             target.classList.add('xi-heart-o')     
            const r_idx = target.children[0].value
            recommend_fetch(r_idx,target,'discount')
          }     
       })
       function recommend_fetch(data,target,choose){
    	  let url='';
    	  let formdata1 = new FormData();
      	  formdata1.append("reply_idx",data)
    	  formdata1.append("nick","${login.member_nick}")	
    	 
    	  switch(choose){
    	  	case 'count' : url ='${cpath}/recommend/'; break;
    	  	case 'discount' : url ='${cpath}/recommend/discount/';
    	  	break;
    	  }
    	  const opt = {
    			  method : "POST",
    			  body : formdata1
    	  }
    	  fetch(url,opt)
    	  .then(resp=>resp.text())
    	  .then(text=>{
    		  target.nextSibling.innerText= +text;
    	  })
      }
    
     </script>
</body>
</html>