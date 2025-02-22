	<!-- ======= Head ======= -->
	<%@include file="include/head.jsp"%>
	<!-- ======= Head end======= -->
	<script src="js/sell.js" type="text/javascript"></script>

</head>

<body >

	<!-- ======= Header ======= -->
	<%@include file="include/header.jsp"%>
	<!-- ======= Header end======= -->

	<!-- ======= Sidebar ======= -->
	<%@include file="include/sidebar.jsp"%>
	<!--  Sidebar End-->

	<main id="main" class="main">
<!-- ======= Breadcrumbs ======= -->
	<%@include file="breadcrumbs/payment.jsp"%>
	<!--  Breadcrumbs End-->
			
		<div class="pagetitle text-center">
			<h1 id=page_title>Manage Online Payment</h1>
		</div>

		<section class="section">
			<div class="row">
				<div class="card ">
					<div class="card-body table-responsive">

						<%
						NumberFormat format = new DecimalFormat("##.##");

						

						String d1=request.getParameter("D1") == null ? "" : request.getParameter("D1");
						String d2=request.getParameter("D2") == null ? "" : request.getParameter("D2");
						String first_date= LogFileService.changeFormate(d1, "yyyy-MM-dd", "dd-MM-yyyy")== null ? "" :LogFileService.changeFormate(d1, "yyyy-MM-dd", "dd-MM-yyyy");
						String second_date= LogFileService.changeFormate(d2, "yyyy-MM-dd", "dd-MM-yyyy")== null ? "" :LogFileService.changeFormate(d2, "yyyy-MM-dd", "dd-MM-yyyy");
						String all = request.getParameter("All") == null ? "" : request.getParameter("All");
						int i = Integer.parseInt(request.getParameter("periods") == null ? "0" : request.getParameter("periods"));
						
						if (i != 0) {
							String temp = LogFileService.getEndDates("yyyy-MM-dd", i);
							String dates[] = temp.split(",");
							d1 = dates[0];
							d2 = dates[1];
							System.out.println(temp);
						}
						int bank_id_fk = Integer.parseInt(request.getParameter("bank_id_fk") == null ? "0" : request.getParameter("bank_id_fk"));
						
						int id = Integer.parseInt(request.getParameter("id") == null ? "0" : request.getParameter("id"));
						
						if(id>0){
							bank_id_fk = id;
						}
						
						OnlinePaymentService service = new OnlinePaymentService();

						ArrayList<OnlinePaymentDto> old_list = null;

						String get_last_date = "";

						if (!"".equals(d1) && !"".equals(d2)) {
							get_last_date = LogFileService.previousDateString(d1);
						}

						old_list = service.getOnlinePaymentInfo("2023-01-01", get_last_date,bank_id_fk,all, config, request);

						float tot_Credit = 0, tot_Debit = 0, Balance_Amt = 0;

						if (!"".equals(d1) && !"".equals(d2)) {
							for (OnlinePaymentDto acc_old_dto : old_list) {
								tot_Credit = tot_Credit + acc_old_dto.getCredit();
								tot_Debit = tot_Debit + acc_old_dto.getDebit();
							}
						}

						Balance_Amt = tot_Credit - tot_Debit;
						%>

						<%

						%>

						<div class="row " id="table_search">
							<form autocomplete="off" class="row g-3">

								

								<div class="col-md-2 col-4">
									<div class="form-floating control">
										<input type="date" class="form-control " id="d1" name="D1"
											value="<%=d1 == null ? "" : d1%>"> <label
											for="floatingName">From Date</label>
									</div>
								</div>

								<div class="col-md-2 col-4">
									<div class="form-floating control">
										<input type="date" class="form-control " id="d2" name="D2"
											value="<%=d2 == null ? "" : d2%>"> <label
											for="floatingPhone">To Date</label>
									</div>
								</div>
								<div class="col-md-2 col-4">
									<div class="form-floating control">
										<select class="form-control" id="periods" name="periods">
											<option value="0">- Select -</option>
											<option
												<%if (i == 1) {
	out.print("selected='selected'");
}%>
												value="1">Today</option>
											<option
												<%if (i == 3) {
	out.print("selected='selected'");
}%>
												value="3">weekly</option>
											<option
												<%if (i == 5) {
	out.print("selected='selected'");
}%>
												value="5">monthly</option>
<option
												<%if (i == 6) {
	out.print("selected='selected'");
}%>
												value="6">yearly</option>
										</select> <label for="floatingPhone">To Date</label>
									</div>
								</div>
								


								<div class="col-md-2 col-4">
									<div class="form-floating control">
										<select class="form-control input_a" name="bank_id_fk"
											id="bank_id_fk" onclick="checkBankName();" onblur="findBankInfoByName(this.value);" >
											<option value="0">Select Your bank</option>
											<%
											BankService bank_ser = new BankService();
											ArrayList<BankDto> bank_list = bank_ser.getBankInfo(config, request);
											for (BankDto bank_dto : bank_list) {
											%>

											<option
												<%if (bank_id_fk == bank_dto.getId()) {
	out.print("selected='selected'");

}%>
												value="<%=bank_dto.getId()%>"><%=bank_dto.getName()%></option>

											<%
											}
											%>

										</select><label for="bank_id_fk">Bank Name</label>
									</div>
								</div>

								<div class="col-md-2 col-4">
									<label class="cow" style="color: #ff0202;">Prev. Bal: <%=format.format(Balance_Amt)%></label>
								</div>
								  <div class="col-md-1">
									<div class="form-check mt-2">
											<input class="form-check-input" type="checkbox" id="all"
												name="All" value="Yes" <%if(all.equalsIgnoreCase("Yes")){%>checked<%}%>> <label
												class="form-check-label" for="all" style="font-size: 13px;">
												All </label>
									</div>
								</div>
								<div class="col-md-1 col-4">
									<div class="form-floating">
										<button type="submit" class="submit-btn">Submit</button>
									</div>
								</div>


							</form>
						</div>

						<br>

						<table id="example" class="table hover table-responsive nowrap">


							<thead class="text-center" id="thead">
							
								<tr>
									<th style="width: 5%; text-align: center;">S.N0.</th>
									<th style="width: 8%; text-align: center;">Credit</th>
									<th style="width: 8%; text-align: center;">Debit</th>
									
									<th style="width: 9%; text-align: center;">Balance</th>
									<th style="width: 14%; text-align: center;">Remark</th>
									<th style="width: 8%; text-align: center;">Online Date</th>
									
									<th style="width: 5%; text-align: center;">Online Way</th>
									<th style="width: 8%; text-align: center;">Pay Date</th>
									<th style="width: 8%; text-align: center;">Type</th>
									
									<th style="width: 8%; text-align: center;">Bank Name</th>
									<th style="width: 8%; text-align: center;">Acc No</th>
									<th style="width: 8%; text-align: center;">Branch</th>
									<th style="width: 8%; text-align: center;">IFSC</th>
								</tr>
							</thead>
							<tbody class="text-center" id="tbody">
								<%
								OnlinePaymentService ser = new OnlinePaymentService();
								ArrayList<OnlinePaymentDto> list = ser.getOnlinePaymentInfo(d1,d2,bank_id_fk,all,config, request);
								float total_debit=0,total_credit=0;
								for (OnlinePaymentDto dto : list) {
									
									if (Balance_Amt < 0) {
										Balance_Amt = (Balance_Amt - dto.getDebit()) + dto.getCredit();
									} else {
										Balance_Amt = (Balance_Amt - dto.getDebit()) + dto.getCredit();

									}
								%>
								<tr>
									<td><%=list.indexOf(dto) + 1%></td>
									<td><%=dto.getCredit()%></td>
									<td><%=dto.getDebit()%></td>
									<td class="main-color"><%=format.format(Balance_Amt)%></td>
									
									
									<td><%=dto.getRemark() == null ? "-": dto.getRemark()%></td>
									<td><%=dto.getOnline_date() == "" ? "-": LogFileService.changeFormate(dto.getOnline_date(), "yyyy-MM-dd", "dd-MM-yyyy")%></td>
									
									
									<td><%=dto.getOnline_way() == null ? "-": dto.getOnline_way()%></td>
									<td><%=dto.getIn_date() == "" ? "-": LogFileService.changeFormate(dto.getIn_date(), "yyyy-MM-dd", "dd-MM-yyyy")%></td>
									<td><%=dto.getType() == null ? "-": dto.getType()%></td>

									<td><%=dto.getBank_name() == null ? "-": dto.getBank_name()%></td>
									<td><%=dto.getAccount_no() == null ? "-": dto.getAccount_no()%></td>
									<td><%=dto.getBranch() == null ? "-": dto.getBranch()%></td>
									<td><%=dto.getIfsc() == null ? "-": dto.getIfsc()%></td>
									
								
									
									
								</tr>
								<%
								total_credit=total_credit+dto.getCredit();
								total_debit=total_debit+dto.getDebit();
								}
								%>
								
								
							</tbody>
							<tfoot id="tfoot">
								<tr>
									<td></td>
									<td><%=total_credit %></td>
									<td><%=total_debit %></td>
									<td><span class="main-color">Online Amount In Hand:-</span> <%=total_credit-total_debit %></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									
								</tr>
							
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</section>

	</main>
	<!-- End #main -->


	<!-- ======= Footer ======= -->
	<%@include file="include/footer.jsp"%>
	<!-- End Footer -->
<!-- ======= Footer ======= -->
	<%@include file="include/datatable_script_footer.jsp"%>
	<!-- End Footer -->
</body>

</html>