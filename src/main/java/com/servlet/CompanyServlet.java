package com.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dto.CompanyDto;
import com.service.CompanyService;

/**
 * Servlet implementation class CompanyServlet
 */
@WebServlet("/CompanyServlet")
public class CompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServletConfig config;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CompanyServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		this.config = config;
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
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub

		CompanyDto dto = new CompanyDto();

		CompanyService ser = new CompanyService();

		dto.setUser_id_fk(Integer.parseInt(request.getParameter("User_id_fk") == null ? "0" : request.getParameter("User_id_fk")));

		dto.setId(Integer.parseInt(request.getParameter("Id") == null ? "0" : request.getParameter("Id")));

		dto.setName(request.getParameter("Name") == null ? "" : request.getParameter("Name"));

		dto.setService_count(
				request.getParameter("Service_count") == null ? "" : request.getParameter("Service_count"));

		dto.setStatus(request.getParameter("Status") == null ? "Active" : request.getParameter("Status"));

		if (dto.getId() == 0) {

			boolean b = ser.insertCompany(dto, request, config);

			if (b) {

				response.sendRedirect("add_company.jsp?msg=Yes");
			} else {

				response.sendRedirect("add_company.jsp?msg=No");

			}
		}

		else {
			boolean b = ser.UpdateCompany(dto, request, config);

			if (b) {

				response.sendRedirect("manage_company.jsp?msg=YesUp");
			} else {

				response.sendRedirect("edit_company.jsp?msg=NoUp");

			}
		}

	
	}

}
