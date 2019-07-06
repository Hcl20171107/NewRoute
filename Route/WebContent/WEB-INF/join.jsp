<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>加入</title>
<link href="css/base.css" type="text/css" rel="stylesheet" />
<link href="css/login.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
    function validate(){
    	var latitude = document.getElementById("latitude");
    	var longtitude = document.getElementById("longtitude");
    	if(latitude.value == ""){
    		alert("纬度不能为空！");
    		latitude.focus();
    		return false;
    	}
    	if(longtitude.value == ""){
    		alert("经度不能为空！");
    		longtitude.focus();
    		return false;
    	}
    	return true;
    }
</script>
</head>
<body>
	<iframe src="top.jsp" width="100%" height="100" scrolling="no"
		frameborder="0"></iframe>
	<div class="content">
		<div class="page_name">加入</div>
		<div class="join_content">
			<form action="JoinServlet" method="POST">
			<div class="login_l">
				<p class="font14">加入纬度和经度</p>
				<div class="span1">
					<label class="tn-form-label">纬度：</label> 
					<input class="tn-textbox" type="text" name="latitude"  id = "latitude" value="<%=latitude%>">
				</div>
				<div class="span1">
					<label class="tn-form-label">经度：</label> 
					<input class="tn-textbox" type="text" name="longtitude"  id = "longtitude" value="<%=longtitude%>">
				</div>
				<div class="tn-form-row-button">
					<div class="span1">
						<input name="" type="submit" class="tn-button-text" value="登   录">

					</div>
			</form>
				</div>
				<div class="clear"></div>
			</div>
			<div class="login_r">

				<div>
					<img src="images/login_pic.png">
				</div>

				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<iframe src="foot.jsp" width="100%" height="150" scrolling="no"
		frameborder="0"></iframe>
</body>
</html>