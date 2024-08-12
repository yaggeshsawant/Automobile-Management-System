
<!-- head -->
<%@include file="include/head.jsp"%>
<!-- head end -->
<style>
.col-4 {
	flex: 0 0 auto;
	width: 40.333333%;
}
</style>
<script type="text/javascript" src="js/vehicle.js"></script>
</head>

<body>



	<!-- ======= Header ======= -->
	<%@include file="include/header.jsp"%>
	<!-- ======= Header end======= -->


	<!-- ======= Sidebar ======= -->
	<%@include file="include/sidebar.jsp"%>
	<!--  Sidebar End-->

	<main id="main" class="main">
		<div class="row justify-content-center">
			<div class="pagetitle col-lg-8 text-center">
				<h1>Pay Vehicle Due</h1>
			</div>
		</div>



		<section class="section dashboard">
			<div class="row justify-content-center">

				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">

							<%
							int id = Integer.parseInt(request.getParameter("id") == null ? "0"
									: request.getParameter("id"));
							VehicleInfoService service = new VehicleInfoService();
							float due_amt=0;

							VehicleInfoDto dto = service.getVehicleInfoById(id, config, request);
							due_amt=(dto.getDue_sale_price() - dto.getDue_sale_price_paid());
						%>

							<h5 class="text-center card-title" style="margin-bottom: -15px;">Vehicle
								Details</h5>



							<div class="table-responsive">
								<table
									class="table info-table table-borderless mt-4 table-color">
									<tr>
										<th width="75px">Company</th>
										<th width="2px">:</th>
										<td width="350px"><%=dto.getBike_company_name()%></td>
										<th width="150px">Vehicle No.</th>
										<th width="2px">:</th>
										<td width="250px"><%=dto.getVehicle_no()%></td>
										<th width="150px">Chassis No.</th>
										<th width="2px">:</th>
										<td width="250px"><%=dto.getChassis_no()%></td>
									</tr>


									<tr>
										<th>Model</th>
										<th>:</th>
										<td><%=dto.getModel_name()%></td>
										<th>Engine No.</th>
										<th>:</th>
										<td><%=dto.getEngine_no()%></td>
										<th>Color</th>
										<th>:</th>
										<td><%=dto.getColor_name()%></td>

									</tr>
									<tr>
										<th>Amount</th>
										<th>:</th>
										<td><%=dto.getDue_sale_price()%></td>
										<th>Paid Amt.</th>
										<th>:</th>
										<td><%=dto.getDue_sale_price_paid()%></td>
										<th>Due</th>
										<th>:</th>
										<td id="due_amt"><%=due_amt%></td>

									</tr>
								</table>
							</div>
							<h5 class="text-center card-title">Pay Vehicle Due</h5>

							<!-- Floating sold vehicle Form -->
							<form autocomplete="off" class="row g-3 needs-validation"
								novalidate>

								<input type="hidden" id="user_id_fk" value="<%=user_id%>">
								<input type="hidden" id="vehicle_id_fk" value="<%=dto.getId()%>">
								<input type="hidden" id="c_y_session" value="<%=c_y_session%>">


								<div class="col-md-3">
									<div class="control form-floating">
										<input type="Date" class="form-control" id="pay_date"
											placeholder="Pay Date" value="<%=current_date%>" required>
										<label for="in_date">Pay Date</label>
										<div class="invalid-feedback">Please, enter Pay Date!</div>
									</div>
								</div>

								<!-- Cash Amount Start -->
								<div class="col-md-3" id="cash_block">
									<div class="control form-floating">
										<input type="number" step="0.01" class="form-control"
											onblur="paidAmountEvent();" id="cash_amount"
											placeholder="Cash Amount" value="0" required> <label
											for="cash_amount">Cash Amount</label>
									</div>
								</div>
								<!-- Cash Amount end -->

								<!-- Online Amount Start -->
								<div class="d-none" id="online_amt_block">
									<div class="control form-floating">
										<input type="number" step="0.01" class="form-control"
											onblur="paidAmountEvent();" id="online_amount"
											placeholder="Online Amount" value="0" required> <label
											for="online_amount">Online Amount</label>
									</div>
								</div>
								<!-- Online Amount end -->

								<!-- Paid Amount Start -->
								<div class="d-none" id="paid_block">
									<div class="control form-floating">
										<input readonly type="number" step="0.01"
											style="background-color: #e7ededad;" class="form-control"
											id="paid_amount" onblur="paidAmountEvent();"
											placeholder="Pay Amount" value="0" required> <label
											for="paid_amount">Paid Amount</label>
									</div>
								</div>
								<!-- Paid Amount end -->

								<!-- Remaining Amount end -->

								<div class="d-none" id="online_block">



									<!-- Online Date Start-->
									<div class="col-md-3">
										<div class="control form-floating">
											<input type="date" class="form-control"
												placeholder="Online Date" id="online_date"> <label
												for="online_date">Online Date</label>
											<div class="invalid-feedback">Please, Enter Online
												Date!</div>
										</div>
									</div>
									<!-- Online Date End -->

									<!-- Online way start -->
									<div class="col-md-3">
										<div class="control form-floating mb-3">
											<select class="form-select" id="online_way" name="Online_way"
												aria-label="working post">
												<option value="N/A" Selected='selected'>Select
													Online way</option>

												<option value="Gpay">Gpay</option>
												<option value="Phonepay">Phone Pay</option>
												<option value="Paytm">Paytm</option>
												<option value="Cheque">Cheque</option>
												<option value="Online">Online</option>


											</select> <label for="online_way">Select Online Way</label>
										</div>
									</div>
									<!-- Online way end -->

									<div class="col-md-3 refresh-container mb-3"
										data-add="add_bank.jsp" data-list="bank">
										<div class="control form-floating refresh-input">
											<input type="text" class="form-control" id="bank_name"
												placeholder="Select Bank Name"> <input type="hidden"
												id="bank_id_fk" name="Bank_id_fk" value="0" /> <label
												for="bank_name">Select Bank Name</label>
											<div class="invalid-feedback">Please, Select Bank!</div>
										</div>
									</div>
									<%-- <!-- Bank Detail start -->
									<div class="col-md-2 col-8 mt-2">
										<div id="refresh_bank">
											<div class="control form-floating d-flex">
												<select class="form-select" id="bank_id_fk"
													name="Bank_id_fk" aria-label="working post">
													<option value="0" Selected='selected'>Select Bank
														Name</option>

													<%
													BankService ser1 = new BankService();

													ArrayList<BankDto> list1 = ser1.getBankInfo(config, request);

													for (BankDto Bank_dto : list1) {
													%>

													<option value="<%=Bank_dto.getId()%>"><%=Bank_dto.getName()%></option>


													<%
													}
													%>

												</select> <label for="bank_id_fk">Select Bank</label>
											</div>
										</div>
									</div>
									<div class="refresh_add"
										id="bank_parent">
										<%@include file="include/refresh_add.jsp"%>
									</div>
 --%>

									<!-- Online Remark Start -->
									<div class="col-md-3">
										<div class="control form-floating">
											<input class="form-control" id="online_remark"
												name="Online_remark" placeholder="Online Remark" value="N/A">
											<label for="online_remark">Online Remark</label>
										</div>
									</div>
									<!-- Online Remark End -->

								</div>
								<!-- *** Online Block End *** -->




								<h6 class="text-center card-title">Payment Mode</h6>
								<div class="container d-flex justify-content-center">
									<div class="col-md-2 col-sm-12 d-flex justify-content-around">


										<div class="form-check" style="margin-left: 5px;">
											<input class="form-check-input" type="radio"
												name="Payment_mode1" id="cash_mode" value="Cash"
												onclick="checkPaymentMode();" checked> <label
												class="form-check-label" for="cash_mode"> Cash </label>
										</div>
										<div class="form-check" style="margin-left: 5px;">
											<input class="form-check-input" type="radio"
												name="Payment_mode1" id="online_mode" value="Online"
												onclick="checkPaymentMode();"> <label
												class="form-check-label" for="online_mode"> Online </label>
										</div>

										<div class="form-check" style="margin-left: 5px;">
											<input class="form-check-input" type="radio"
												name="Payment_mode1" id="both_mode" value="Both"
												onclick="checkPaymentMode();"> <label
												class="form-check-label" for="both_mode"> Both </label>
										</div>

									</div>
								</div>


								<input type="hidden" id="payment_mode" name="Payment_mode"
									value="Cash" />
								<div class="col-md-2">
									<div class="control form-floating">
										<input type="date" class="form-control"
											placeholder="Upcoming_date" id="upcoming_date"
											name="Upcoming_date"> <label for="upcoming_date">Upcoming
											Date</label>
										<div class="invalid-feedback">Please, Enter Upcoming
											Date!</div>
									</div>
								</div>

								<div class="col-md-5">
									<div class="control form-floating">
										<textarea class="form-control" placeholder="Upcoming_remark"
											id="upcoming_remark" Name="Upcoming_remark">N/A</textarea>
										<label for="remark">Upcoming remark</label>
									</div>
								</div>

								<div class="col-md-5">
									<div class="control form-floating">
										<textarea class="form-control" placeholder="Remark"
											id="remark" Name="Remark">N/A</textarea>
										<label for="remark">Remark</label>
									</div>
								</div>

								<div id="sub" class="text-center">
									<input type="button" value="Submit" name="submit" id="submit"
										onclick="dueSubmit()" class="submit-btn" />
								</div>
								<div id="res_status"></div>

							</form>

						</div>
					</div>
				</div>


			</div>
		</section>

	</main>
	<!-- End main -->
	<br />
	<br />




	<script type="text/javascript">

	function dueSubmit() {
		
		//var id = document.getElementById("id").value;
		var vehicle_id_fk = document.getElementById("vehicle_id_fk").value;
		var bank_id_fk = document.getElementById("bank_id_fk").value;
		//alert("Hello 1");
		var paid_amount = document.getElementById("paid_amount").value;
		var online_amount = document.getElementById("online_amount").value;
		var cash_amount = document.getElementById("cash_amount").value;
		//alert("Hello 2");
		var c_y_session = document.getElementById("c_y_session").value;
		var pay_date = document.getElementById("pay_date").value;
		var remark = document.getElementById("remark").value;
		var online_way = document.getElementById("online_way").value;
		//alert("Hello 3");
		var online_remark = document.getElementById("online_remark").value;
		var online_date = document.getElementById("online_date").value;
		var payment_mode = document.getElementById("payment_mode").value;
		var user_id_fk = document.getElementById("user_id_fk").value;
		var upcoming_date = document.getElementById("upcoming_date").value;
		var upcoming_remark = document.getElementById("upcoming_remark").value;
		//alert("Hello 4");
		 
		$
				.ajax({
					url : 'AjaxService/AjaxPayVehicleDue.jsp',
					data : 'Vehicle_id_fk='+ vehicle_id_fk
					+ '&Bank_id_fk='+ bank_id_fk 
					+ '&Paid_amount='+ paid_amount 
					+ '&Online_amount='+ online_amount 
					+ '&Cash_amount='+ cash_amount 
					+ '&C_y_session='+ c_y_session 
					+ '&Pay_date='+ pay_date 
					+ '&Remark='+ remark 
					+ '&Online_way='+ online_way 
					+ '&Online_remark='+ online_remark 
					+ '&Online_date='+ online_date 
					+ '&Payment_mode='+ payment_mode
					+ '&User_id_fk='+ user_id_fk
					+ '&Upcoming_date='+ upcoming_date
					+ '&Upcoming_remark='+ upcoming_remark,
					type : 'post',
					success : function(msg) {
						//alert(msg);
						$('#res_status').html(msg);
						var status = document.getElementById("updatestatus").value;
						var return_id = document.getElementById("return_id").value;
						if (status=='true') {
							window.location.href = "print_vehicle_due.jsp?id="+return_id+"&vehicle_id="+vehicle_id_fk;
						} else {
							window.location.href = "manage_vehicle_due.jsp?msg=No&id="+vehicle_id_fk;
						}

					}
				});
		
	}
		
	</script>


	<!-- ======= Footer ======= -->
	<%@include file="include/footer.jsp"%>
	<!-- End Footer -->


</body>

</html>