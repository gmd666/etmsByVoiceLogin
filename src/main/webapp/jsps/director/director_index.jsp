<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="renderer" content="webkit">
  		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>网站后台管理模版</title>
		<%
    		String path = request.getContextPath();
    		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
   		%>
		<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/layui.css"/>
		<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/admin.css"/>
	</head>
	<body>
		<div class="main-layout" id='main-layout'>
			<!--侧边栏-->
			<div class="main-layout-side">
				<div class="m-logo">
				</div>
				<ul class="layui-nav layui-nav-tree" lay-filter="leftNav">
				  <li class="layui-nav-item">
				    <a href="javascript:{changeSrc('<c:url value='/TaskServlet?method=getSelect&url=/jsps/director/addTask.jsp'/>')}"><i class="iconfont">&#xe604;</i>制定任务</a>
				  </li>
				  <li class="layui-nav-item">
				    <a href="javascript:{changeSrc('<c:url value='/TaskServlet?method=taskSelect&mid=${sessionScope.Luser["id"]}'/>')}"><i class="iconfont">&#xe604;</i>查看任务</a>
				  </li>
				   <li class="layui-nav-item">
				    <a href="javascript:{changeSrc('<c:url value='/TaskServlet?method=findTask&mid=${sessionScope.Luser["id"]}'/>')}"><i class="iconfont">&#xe60c;</i>跟踪任务</a>
				  </li>
				  <li class="layui-nav-item">
				    <a href="javascript:{changeSrc('<c:url value='/TaskServlet?method=changeTask&mid=${sessionScope.Luser["id"]}'/>')}"><i class="iconfont">&#xe60a;</i>调整任务</a>
				  </li>
				  <li class="layui-nav-item">
				    <a href="javascript:{changeSrc('<c:url value='/TaskServlet?method=lookUser'/>')}""><i class="iconfont">&#xe60a;</i>查看人员</a>
				  </li>
				</ul>
			</div>
			<!--右侧内容-->
			<div class="main-layout-container">
				<!--头部-->
				<div class="main-layout-header">
					<div class="menu-btn" id="hideBtn">
						<a href="javascript:;">
							<span class="iconfont">&#xe60e;</span>
						</a>
					</div>
					<ul class="layui-nav" lay-filter="rightNav">
					   <li class="layui-nav-item"><a href="javascript:;">${sessionScope.Luser["identify"]} : </a></li>
					  <li class="layui-nav-item">
					    <a href="javascript:;">${sessionScope.Luser.username}</a>
					  </li>
					  <li class="layui-nav-item"><a href="<c:url value='/userServlet?method=quit'/>">退出</a></li>
					</ul>
				</div>
				<!--主体内容-->
				<div class="main-layout-body">
					<!--tab 切换-->
					<div class="layui-tab layui-tab-brief main-layout-tab" lay-filter="tab" lay-allowClose="true">
					  <ul class="layui-tab-title">
					    <li class="layui-this welcome">用户管理主页</li>
					  </ul>
					  <div class="layui-tab-content">
					    <div class="layui-tab-item layui-show" style="background: #f5f5f5;">
					    	<!--1-->
					    	<iframe src="<%=basePath %>/jsps/Success.jsp" width="100%" height="100%" name="iframe" scrolling="auto" id="iframe" framborder="0"></iframe>
					    	<!--1end-->
					    </div>
					  </div>
					</div>
				</div>
			</div>
			<!--遮罩-->
			<div class="main-mask">
			</div>
		</div>
		<script type="text/javascript">
			function changeSrc(newsrc){
				document.getElementById('iframe').src=newsrc;
			}
		</script>
	</body>
</html>
