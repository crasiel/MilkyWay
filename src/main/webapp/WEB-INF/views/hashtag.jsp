<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>  
    <section id="wrap" class="clearfix">
        <div id="leftWrap">
           <div class="contentList">
               
            <c:forEach var="imgList" items="${list }">
            <h2>${imgList.idx }</h2>
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
	            			<p><fmt:formatNumber value="${hash.hashCnt }" pattern="###,###,###" /> 테그</p>
	            		</div>
	            	</c:forEach>
	            	<div class="hashDiv" onclick="" style="display: block">
						<p>더보기</p>	            	
	            	</div>
            </div>
        </div>
    </section>
    
    </body>
    </html>