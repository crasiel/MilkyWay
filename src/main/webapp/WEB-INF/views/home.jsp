<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>  
    <section id="wrap" class="clearfix">
        <div id="leftWrap">
           <div class="contentList">
               
            <c:forEach var="imgList" items="${list }">
            <h2>${imgList.idx} </h2>
             <div class="contentWrap">
             	<div onclick="location.href='${cpath }/read/${imgList.idx }'">
	             <c:if test="${imgList.getFileList()[0] ne '' }">   <!-- img가 있을 경우 -->              
             <div class="conImagWrap">   
                 <div id="contImg clearfix" class="${imgList.idx }">
                      <c:forEach var="img" items="${imgList.getFileList() }" varStatus="status">     
                      <%-- <h2 style="color : #fff">1 : ${fn:length(imgList.getFileList())}</h2> --%>                         
                              <img src="${cpath }/upload/${status.current }"
                               class="contImg${fn:length(imgList.getFileList()) }" <c:if test="${fn:length(imgList.getFileList()) eq 3 and status.index eq '0' }">style="width : 100%"</c:if>>
                       </c:forEach>
                 </div>
                 
             </div>
             </c:if>    
             <div class="readContent"> content 내용 : ${imgList.getContent() }</div>
             </div>
               <div class="replyWrap">
                   <details>
                      <summary>댓글보기</summary>
    
                           <div class="replyList">
                                <ul>
                                   <c:forEach var="reply" items="${reList}">
                                   <c:if test="${reply.board_idx eq imgList.idx }">
                                      <li>
                                      <input type="text" name="reply_nick" value="${reply.reply_nick }" class="re_user" readonly>
                                       ${reply.reply_content } 
	                                       <c:choose>
	                                        	<c:when test="${reply.recommend }">
	                                        		<i class="red xi-heart xi-2x" name="recommend" id="recommend"><input type="hidden" name="idx" value="${reply.reply_idx }"></i><span>${reply.count }</span>
	                                    	   </c:when>
	                                    		<c:otherwise>
	                                    			<i class="xi-heart-o xi-2x" name="recommend" id="recommend"><input type="hidden" name="idx" value="${reply.reply_idx }"></i></i><span>${reply.count }</span>
	                                    		</c:otherwise>
	                                    	</c:choose>
                                       </li>
                                    </c:if>
                                    </c:forEach>
                                  </ul>
                              </div> 
                           </details>
                       </div>     
                </div>
         </c:forEach>
         </div>
         </div>
      
        <div id="rightWrap">
            <div>
            	<h2 style="margin-bottom : 20px; color : #3498db">나를 위한 트렌드</h2>
	            	<c:forEach var="hash" items="${hashList }">
	            		<div class="hashDiv" onclick="location.href='${cpath}/${hash.hashtag }'">
	            			<p style="color:blue"># ${hash.hashtag }</p>
	            			<p><fmt:formatNumber value="${hash.hashCnt }" pattern="###,###,###" /> 태그</p>
	            		</div>
	            	</c:forEach>
	            	<div class="hashDiv" onclick="" style="display: block">
						<p>더보기</p>	            	
	            	</div>
            </div>
        </div>
    </section>
    
    
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