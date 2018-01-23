<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
 <a href="#this" class="btn" id="mask-open1">버튼</a>
 <div style="width: 300px;height: 300px; border: 1px solid #000;" id="user-content">
    user content
</div>
<a href="#this" class="btn" id="mask-open2">열기</a>
<a href="#this" class="btn" id="mask-close">닫기</a>
<br><a href="#this" class="btn" id="mask-open">로딩중</a></br>

    <h2>게시판 목록</h2>
    <table class="board_list">
        <colgroup>
            <col width="10%"/>
            <col width="*"/>
            <col width="15%"/>
            <col width="20%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">글번호</th>
                <th scope="col">제목</th>
                <th scope="col">조회수</th>
                <th scope="col">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list) > 0}">
                    <c:forEach var="row" items="${list}" varStatus="status">
                        <tr>
                            <td>${row.IDX }</td>
                            <td class="title">
                                <a href="#this" name="title">${row.TITLE }</a>
                                <input type="hidden" id="IDX" value="${row.IDX }">
                            </td>
                            <td>${row.HIT_CNT }</td>
                            <td>${row.CREA_DTM }</td>
                        </tr>
                    </c:forEach> 
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4">조회된 결과가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>  
        </tbody>
    </table>
     
    <c:if test="${not empty paginationInfo}">
        <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
    </c:if>
    <input type="hidden" id="currentPageNo" name="currentPageNo"/>
     
    <br/>
    <a href="#this" class="btn" id="write">글쓰기</a>
     
    <%@ include file="/WEB-INF/include/include-body.jspf" %>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#write").on("click", function(e){ //글쓰기 버튼
                e.preventDefault();
                fn_openBoardWrite();
            });
             
            $("a[name='title']").on("click", function(e){ //제목
                e.preventDefault();
                fn_openBoardDetail($(this));
            });
        });
         
         
        function fn_openBoardWrite(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
            comSubmit.submit();
        }
         
        function fn_openBoardDetail(obj){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
            comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
            comSubmit.submit();
        }
         
        function fn_search(pageNo){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
            comSubmit.addParam("currentPageNo", pageNo);
            comSubmit.submit();
        }
    </script>
<!--ax5 -->
    <script type="text/javascript">
    $(document.body).ready(function () {
        var mask = new ax5.ui.mask();
        $('#mask-open1').click(function () {
            mask.open();
 
            setTimeout(function () {
                mask.close();
            }, 2000);
        });
 
    });
</script>
<script type="text/javascript">
    var mask = new ax5.ui.mask();
 
    $(document.body).ready(function () {
 
        $('#mask-open2').click(function () {
            mask.open({
                // position: "fixed", // Maybe options that may be required to you
                zIndex: 99,
                target: $("#user-content").get(0),
                content: 'MASK',
                onClick: function(){
                    console.log(this);
                }
            });
        });
 
        $('#mask-close').click(function () {
            mask.close();
        });
 
    });
</script>
<script type="text/javascript">
    $(document.body).ready(function () {
 
        var mask = new ax5.ui.mask();
        mask.setConfig({
            target: document.body, // 미리 선언했지만
            content: "<h1>Mask will disappear after 3 seconds.</h1>",
            onStateChanged: function(){
                console.log(this);
            }
        });
 
        $('#mask-open').click(function () {
            mask.open({
                content: '<h1><i class="fa fa-spinner fa-spin"></i> Loading</h1>'
            });
 
            setTimeout(function () {
                mask.close();
            }, 2000);
            // Mask will disappear after 3 seconds.
        });
 
    });
</script>
</body>
</html>


