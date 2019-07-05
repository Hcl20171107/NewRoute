<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.lang.Math"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style type="text/css">
            body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
            #l-map{height:100%;width:78%;float:left;border-right:2px solid #bcbcbc;}
            #r-result{height:100%;width:20%;float:left;}
        </style>
        <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
        <title>绘制轨迹</title>
    </head>
    <body>
        <div id="allmap"></div>
    </body>
</html>
<script type="text/javascript">
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(111.460, 40.290);
    map.centerAndZoom(point, 15); //初始化地图
    map.addControl(new BMap.NavigationControl()); //平移缩放控件
    map.enableScrollWheelZoom();  //滚轮缩放大小


    var lineList = new Array();//记录要绘制的线
    var arrowLineList = new Array();//记录绘制的箭头线
    var isFirstLoad = false;//是否是第一次加载，第一次加载不触发清除事件
    var arrowLineLengthRate = 15 / 10;
    
    map.addEventListener("click",function(e){
        alert(e.point.lng + "," + e.point.lat);
    });
    
    var polyline = new BMap.Polyline(
    	[
    		new BMap.Point(111.460, 40.290),
		    new BMap.Point(118.565, 42.160),
		    new BMap.Point(115.442, 33.150),
		    new BMap.Point(120.442, 31.150), 
       	], 
    	{strokeColor:"red", strokeWeight:5, strokeOpacity:1 } //Opacity 透明度
    );
    map.addOverlay(polyline);
    lineList[lineList.length] = polyline;//记录要绘制的线
    
    arrowLineList[arrowLineList.length] = addArrow(polyline,10,Math.PI/7);//记录绘制的箭头线
  
    var marker = new BMap.Marker(new BMap.Point(111.460, 40.290));  // 创建标注
    var marker1 = new BMap.Marker(new BMap.Point(120.442, 31.150));
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
            if(pixelEnd.x-pixelStart.x==0){ //斜率不存在是时
                pixelTemX=pixelEnd.x;
                if(pixelEnd.y>pixelStart.y)
                {
                pixelTemY=pixelEnd.y-r;
                }
                else
                {
                pixelTemY=pixelEnd.y+r;
                }    
                //已知直角三角形两个点坐标及其中一个角，求另外一个点坐标算法
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