<%@page import="com.dto.UserDto"%>
<%@page import="com.service.UserService"%>
<link href="assets/css/style.css" rel="stylesheet">

<div class="horizontal">
	<div class="verticals ten offset-by-one">
			<ol class="breadcrumb breadcrumb-fill2 style4">
			<%
		
UserService user_sidebar_service = new UserService();
UserDto user_sidebar_dto_nav = user_sidebar_service.getuserInfoById(user_id, config, request);
%>
				<li><a href="index.jsp"><i class="fa fa-home"></i></a></li>
				<%
						if (user_sidebar_dto_nav.getIncome_module().equalsIgnoreCase("Yes")) {
						%>
				<li><a href="add_income.jsp">Income</a></li>
				<%}
						if (user_sidebar_dto_nav.getIncome_report().equalsIgnoreCase("Yes")) {
						%>
				<li><a href="manage_income.jsp">Income Report</a></li>
				<%}
						
						if (user_sidebar_dto_nav.getIncome_head_module().equalsIgnoreCase("Yes")) {
						%>
				<li><a href="manage_income_head.jsp">Income Head Report</a></li>
				<%}
						
						%>
			</ol>
		</div>
	
	</div>
