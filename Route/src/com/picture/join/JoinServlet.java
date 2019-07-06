package com.picture.join;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.picture.bean.Map;
import com.picture.dao.MapDAO;



/**
 * Servlet implementation class JoinServlet
 */
@WebServlet("/JoinServlet")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		Float latitude=Float.parseFloat(request.getParameter("latitude"));
		Float longtitude=Float.parseFloat(request.getParameter("longtitude"));
		MapDAO dao = new MapDAO();
		int mapID = dao.join(latitude, longtitude);
		if(mapID!=0) {
			Map map = new Map(mapID,latitude,longtitude);
			request.getSession().setAttribute("SESSION_MAP", map);
		}else {
			out.print("<script type='text/javascript'>");
			out.print("alert('纬度或经度错误，请重新输入');");
			out.print("</script>");
		}
	}

}
