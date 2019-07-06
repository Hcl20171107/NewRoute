<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page pageEncoding="utf-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
<meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />
<title>百度地图</title>
<!--引用百度地图API-->
<style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=iY0ZHSqRfyGHoNRhFcE4l0LyXXBoVRQc"></script>
</head>

<body>
  <!--百度地图容器-->
  
  <iframe src="top.jsp" width="100%" height="100" scrolling="no"
		frameborder="0"></iframe>
		
		<div class="content">
			<div style="width:1347px;height:550px;border:#ccc solid 1px;" id="dituContent"></div>
		</div>

		<iframe src="foot.jsp" width="100%" height="150" scrolling="no"
		frameborder="0"></iframe>
</body>
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    }
    
    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(114.632667,39.252968);//定义一个中心点坐标
        map.centerAndZoom(point,15);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }
    
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
	var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
	map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	map.addControl(ctrl_sca);
    }
    
    
    initMap();//创建和初始化地图
    
    var point = new BMap.Point(111.4634932000, 40.2914265600);
    map.centerAndZoom(point, 15); //初始化地图
    map.addControl(new BMap.NavigationControl()); //平移缩放控件
    map.enableScrollWheelZoom();  //滚轮缩放大小
    var marks = [];


    var lineList = new Array();//记录要绘制的线
    var arrowLineList = new Array();//记录绘制的箭头线
    var isFirstLoad = false;//是否是第一次加载，第一次加载不触发清除事件
    var arrowLineLengthRate = 15 / 10;
    
    map.addEventListener("click",function(e){
        alert(e.point.lng + "," + e.point.lat);
    });
    
    var polyline = new BMap.Polyline(
    	[
    		new BMap.Point(111.790620, 40.494733),
    		new BMap.Point(111.795646, 40.500092),
    		new BMap.Point(111.793369,40.497935),
		    new BMap.Point(111.674941, 40.820078),
		    new BMap.Point(118.960630, 42.294507),
       	], 
    	{strokeColor:"red", strokeWeight:5, strokeOpacity:1 } //Opacity 透明度
    );
    map.addOverlay(polyline);
    lineList[lineList.length] = polyline;//记录要绘制的线
    
    arrowLineList[arrowLineList.length] = addArrow(polyline,10,Math.PI/7);//记录绘制的箭头线
  
    var marker = new BMap.Marker(new BMap.Point(111.790620, 40.494733));  // 创建标注
    var marker1 = new BMap.Marker(new BMap.Point(118.960630, 42.294507));
    map.addOverlay(marker);               // 将标注添加到地图中
    marker.setAnimation(BMAP_ANIMATION_BOUNCE); // 跳动的动画
    map.addOverlay(marker1);               // 将标注添加到地图中
    marker1.setAnimation(BMAP_ANIMATION_BOUNCE); // 跳动的动画
    
    isFitstLoad = true;//第一次加载
    
    /**
     * 在百度地图上给绘制的直线添加箭头
     * @param polyline 直线 var line = new BMap.Polyline([faydPoint,daohdPoint], {strokeColor:"blue", strokeWeight:3, strokeOpacity:0.5});
     * @param length 箭头线的长度 一般是10
     * @param angleValue 箭头与直线之间的角度 一般是Math.PI/7
     */
    function addArrow(polyline,length,angleValue){ //绘制箭头的函数
        var linePoint=polyline.getPath();//线的坐标串
        var arrowCount=linePoint.length;
        for(var i =1;i<arrowCount;i++){ //在拐点处绘制箭头
            var pixelStart=map.pointToPixel(linePoint[i-1]);
            var pixelEnd=map.pointToPixel(linePoint[i]);
            var angle=angleValue;//箭头和主线的夹角
            var r=length; // r/Math.sin(angle)代表箭头长度
            var delta=0; //主线斜率，垂直时无斜率
            var param=0; //代码简洁考虑
            var pixelTemX,pixelTemY;//临时点坐标
            var pixelX,pixelY,pixelX1,pixelY1;//箭头两个点
            if(pixelEnd.x-pixelStart.x==0){ // 斜率不存在时
                pixelTemX=pixelEnd.x;
                if(pixelEnd.y>pixelStart.y)
                {
                pixelTemY=pixelEnd.y-r;
                }
                else
                {
                pixelTemY=pixelEnd.y+r;
                }    
                // 已知直角三角形两个点坐标及其中一个角，求另外一个点坐标算法
                pixelX=pixelTemX-r*Math.tan(angle); 
                pixelX1=pixelTemX+r*Math.tan(angle);
                pixelY=pixelY1=pixelTemY;
            }
            else  //斜率存在时
            {
                delta=(pixelEnd.y-pixelStart.y)/(pixelEnd.x-pixelStart.x);
                param=Math.sqrt(delta*delta+1);


                if((pixelEnd.x-pixelStart.x)<0) //第二、三象限
                {
                pixelTemX=pixelEnd.x+ r/param;
                pixelTemY=pixelEnd.y+delta*r/param;
                }
                else//第一、四象限
                {
                pixelTemX=pixelEnd.x- r/param;
                pixelTemY=pixelEnd.y-delta*r/param;
                }
                //已知直角三角形两个点坐标及其中一个角，求另外一个点坐标算法
                pixelX=pixelTemX+ Math.tan(angle)*r*delta/param;
                pixelY=pixelTemY-Math.tan(angle)*r/param;


                pixelX1=pixelTemX- Math.tan(angle)*r*delta/param;
                pixelY1=pixelTemY+Math.tan(angle)*r/param;
            }


            var pointArrow=map.pixelToPoint(new BMap.Pixel(pixelX,pixelY));
            var pointArrow1=map.pixelToPoint(new BMap.Pixel(pixelX1,pixelY1));
            var Arrow = new BMap.Polyline([
                pointArrow,
             linePoint[i],
                pointArrow1
            ], {strokeColor:"red", strokeWeight:5, strokeOpacity:1});
            map.addOverlay(Arrow);
            map.addOverlay(Arrow);
            return Arrow;
        }
    }
    
    //地图加载完毕事件
    map.addEventListener("tilesloaded",function(){
        //alert("地图加载完毕");
        if(!isFirstLoad){
            //map.clearOverlays();//清除所有的覆盖物
            //清除上一次绘制的箭头线，不清除上一次的箭头线，当地图放大时箭头线也会跟着放大
            for(var i=0; i<arrowLineList.length; i++){
                map.removeOverlay(arrowLineList[i]);//清除制定的覆盖物，可以是直线、标注等
            }
            arrowLineList.length = 0;
            //重新绘制箭头线
            for(var i=0; i<lineList.length; i++){
                arrowLineList[arrowLineList.length] = addArrow(lineList[i],15 / arrowLineLengthRate,Math.PI / 7); //记录绘制的箭头线
            }
        }
        isFirstLoad = false;
    });
    
    //单击获取点击的经纬度
    map.addEventListener("click",function(e){
        alert(e.point.lng + "," + e.point.lat);
    });
</script>
</html>