<!DOCTYPE html>
<html>
	<head>
		<title>优惠券修改</title>
		[#include "/common/commonHead.ftl" /]
		<link rel="shortcut icon" href="${base}/styles/images/16.ico" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
		<script language="javascript" type="text/javascript">  
			//添加一行投放区域
			function editPack(){
		         $("#packTabs").append(makeThStr());
		         var i =packTabs.rows.length-1;
				//加载选择区域菜单
		         	var $areaId = $('#areaIds'+i);
				  		// 菜单类型选择
						$areaId.lSelect({
							url: "${base}/common/areao.jhtml"
						});
			}
			//拼投放区域td字符串
			function makeThStr(){
				var i =packTabs.rows.length;
				var th = "<tr height='50px'><td width='10%' align='center'><i class='tjqy_tableIcon"+i+"'></i></td><td width='60%' style='padding-right:200px;'><div class='form-group new_select'><input type='hidden' id='areaIds"+i+"' name='areaIds' class='areaIdVal required'/></div></td><td width='10%' style='padding-right:55px;' align='center'><label class='control-label'><a href='#' stkc='' class='del'>删除</a></label></td></tr>";
				return th;
			}
			//删除一行投放区域
			$("a.del").live("click",function(){
				if(packTabs.rows.length-1<2){
					top.$.jBox.tip('至少有一条区域！');
				}else{
				var tr = $(this).parent().parent().parent();
				var len = tr.parent().children("tr").length;
				tr.remove();
				}
				var i =packTabs.rows.length-1;
				var areaId = $("input[name='areaIds']");
				for(var j=0 ; j<i ; j++){
				var k=j+1;
					areaId[j].setAttribute('id','areaIds'+k)
				}
			});
				
				
				//添加一行按订单金额规则
				function addPack(){
					var i =packTab.rows.length;
					if(i<5){
			         $("#packTab").append(makeStr());
			         }
				}
				//拼按订单金额规则td字符串
				function makeStr(){
					var i =packTab.rows.length+1;
					var th = "<tr><td width='10%' align='center'>"+i+"、满</td><td width='10%' align='left;'><div class='form-group'><div class='col-sm-8'><input type='text' id='orderAmount"+i+"' name='orderAmount' class='filetest form-control required number' /></div></td><td width='5%' align='center'>送</td><td width='10%' align='left;'><div class='form-group'><div class='col-sm-8'><input type='text' id='cpQty"+i+"' name='cpQty' class='cpQty count form-control required number' /> </div></td><td width='10%' align='left'>张</td><td width='5%' align='center'>共</td><td width='10%' align='left;'><div class='form-group'><div class='col-sm-8'><input type='text' disabled='disabled' id='refNo"+i+"' name='refNo' class='form-control required' /></div></td><td width='10%' align='left'>元</td></tr>";
					return th;
				}
		</script>
	</head>
	
	<body class="toolbar-fixed-top">
		<form class="form-horizontal" id="form"  method="post"  action="${base}/couponCam/save.jhtml">
		<input type="hidden" id="ccCode" name="ccCode" value="${couponCam.ccCode}">
		<input type="hidden"   id="oldCcName" value="${couponCam.ccName}"> 
			<div class="navbar-fixed-top" id="toolbar">
			    <button id="addCouponCam" class="btn btn-danger" data-toggle="jBox-call" data-fn="checkForm">保存
				    <i class="fa-save align-top bigger-125 fa-on-right"></i>
			    </button>
				<button class="btn btn-warning" data-toggle="jBox-close">
					关闭 <i class="fa-undo align-top bigger-125 fa-on-right"></i>
				</button>
			</div>
			<div class="page-content">
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								活动标题：
							</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm required" id="ccName" maxlength=30
									name="ccName" value="${couponCam.ccName}" >
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
					[#if sign?exists]	
					<div class="col-xs-5">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								活动类型：
							</label>
							<div class="col-sm-4">
								<select class="form-control required" id="cpProp" name="cpProp">
			                        <option value="">请选择...</option>
			                        <option value="P" [#if couponCam.cpProp=='P']selected="selected"[/#if]>平台券</option>
			                        <option value='O' [#if couponCam.cpProp=='O']selected="selected"[/#if]>自有券</option>
			                    </select>
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
					[/#if]
				</div>
				<br/>
				<div class="row">
				
					<div class="col-xs-6">
						<div class="form-group">
							<label for="beginDate" class="col-sm-4 control-label">
								活动起始时间：
							</label>
							<div class="col-sm-7">
		                    <input type="text" id="dateFrom" name="dateFrom" class="form-control required" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" style="width:181px;" value="${couponCam.dateFrom?string("yyyy-MM-dd")}" /> 
							</div>
						</div>
					</div>
					<div class="col-xs-5">
						<div class="form-group">
							<div class="col-sm-8">
		      				<input type="text" id="dateTo" name="dateTo" class="form-control required"   onClick="WdatePicker({minDate:'#F{$dp.$D(\'dateFrom\')}',dateFmt:'yyyy-MM-dd',readOnly:true})" style="width:181px;" value="${couponCam.dateTo?string("yyyy-MM-dd HH:mm:ss")}"/>
							</div>
							<span class="help-inline col-sm-2">*</span>
						</div>
					</div>
					
				</div>
				<br/>
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								发放总量：
							</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm required" id="totalQty" maxlength=30
									name="totalQty" value="${couponCam.totalQty}" >
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
					<div class="col-xs-5">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								面额：
							</label>
							<div class="col-sm-7">
								<input type="text" class="count form-control input-sm required" id="cpValue" maxlength=30
									name="cpValue" value="${couponCam.cpValue}" >
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								每人限领：
							</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm required" id="singleCustMaxQty" maxlength=30
									name="singleCustMaxQty" value="${couponCam.singleCustMaxQty}" >
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								最低消费金额：
							</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm required" id="minAmtNeed" maxlength=30
									name="minAmtNeed" value="${couponCam.minAmtNeed}" >
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
				
					<div class="col-xs-6">
						<div class="form-group">
							<label for="beginDate" class="col-sm-4 control-label">
								优惠券有效期：
							</label>
							<div class="col-sm-7">
		                    <input type="text" id="cpDateFrom" name="cpDateFrom" class="form-control required" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" style="width:181px;" value="${couponCam.cpDateFrom?string("yyyy-MM-dd HH:mm:ss")}" /> 
							</div>
						</div>
					</div>
					<div class="col-xs-5">
						<div class="form-group">
							<div class="col-sm-8">
		      				<input type="text" id="cpDateTo" name="cpDateTo" class="form-control required"   onClick="WdatePicker({minDate:'#F{$dp.$D(\'cpDateFrom\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" style="width:181px;" value="${couponCam.cpDateTo?string("yyyy-MM-dd HH:mm:ss")}"/>
							</div>
							<span class="help-inline col-sm-2">*</span>
						</div>
					</div>
					
				</div>
				<br/>
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
							<label for="beginDate" class="col-sm-3 control-label">
								方法规则：
							</label>
							<div class="col-sm-4">
		                   		<input class="control_rad" type="radio" name="issueType" value="R" [#if couponCam.issueType=='R']checked="checked"[/#if]><span>新用户注册</span></label> 
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group" style="margin-left:-40px;">
							<div class="col-sm-4">
		                   		<input class="control_rad" type="radio" name="issueType" value="U" [#if couponCam.issueType=='U']checked="checked"[/#if]><span>用户领取</span></label>
							</div>
						</div>
					</div>
					<div class="col-xs-4" style="margin-left:-80px;">
						<div class="form-group">
							<div class="col-sm-5">
		                   		<input class="control_rad" type="radio" name="issueType" value="O"  [#if couponCam.issueType=='O']checked="checked"[/#if]><span>按订单金额</span></label>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
	 				<table id="packTab" class="tjqy_table sr-only" width="90%" border="0" cellspacing="0" cellpadding="0">
						<div id="rule" class="tjqy_btnBox sr-only"><button type="button" class="btn btn-info search_cBox_btn" id='' onclick="addPack();"> 添加一条规则</button></div>
						<tbody>
						[#if ccIssueRules?exists]
		        			[#list ccIssueRules as ccIssueRules]
							<tr>
								<td width='10%' align='center'>${ccIssueRules_index+1}、满</td>
								<td width='10%' align='left;'>
								<div class='form-group'><div class='col-sm-8'>
								<input type='text' id='orderAmount${ccIssueRules_index+1}' name='orderAmount' class='filetest form-control required' value="${ccIssueRules.orderAmount}"/></div>
								</td>
								<td width='5%' align='center'>送</td>
								<td width='10%' align='left;'>
								<div class='form-group'><div class='col-sm-8'>
								<input type='text' id='cpQty${ccIssueRules_index+1}' name='cpQty' class='cpQty count form-control required'  value="${ccIssueRules.cpQty}"/> </div></td>
								<td width='10%' align='left'>张</td><td width='5%' align='center'>共</td>
								<td width='10%' align='left;'>
								<div class='form-group'>
								<div class='col-sm-8'>
								<input type='text' disabled='disabled' id='refNo${ccIssueRules_index+1}' name='refNo' class='form-control required' value=""/></div></td>
								<td width='10%' align='left'>元</td>
							</tr>
		        			 [/#list]
	        			 [/#if]
						</tbody>
					</table>
				</div>
				<br/>
				[#if opcFlg?exists]	
				<div id="area" class="page-content form form-inline">
				<input type='hidden' name="items" id ="items" value=""/>
					<div  class="tjqy_btnBox"><button type="button" class="btn btn-info search_cBox_btn" id='' onclick="editPack();"> 添加分配区域</button></div>
					<table id="packTabs" class="tjqy_table" width="90%" border="0" cellspacing="0" cellpadding="0">
						<thead>
							<tr>
								<th align="center" width="10%">&nbsp;</th>
								<th align="center" width="60%" style="padding-right:200px;">分配区域</th>
								<th align="center" width="10%" style="padding-right:55px;">操作</th>
							</tr>
						</thead>
						[#if ccAreas?exists]
		        			[#list ccAreas as ccAreas]
		            			<tr>
		            			<td width="10%" align="center"><i class="tjqy_tableIcon1"></i></td>
		                			<td width="60%" align="left;">
		                				<input type='hidden' name="areaIds" id ="areaIds${ccAreas_index+1}"  treePath="${ccAreas.TREE_PATH}" value="${ccAreas.AREA_ID}"/>
									</td>
									<td width='10%'><label class='control-label'><a href='#' class='del'>删除</a></label></td>
								</tr>
		        			 [/#list]
		        			 [/#if]
						<tbody>
						</tbody>
					</table>
				</div>
				[#else]
				<table id="packTabs" class="tjqy_table  sr-only" width="90%" border="0" cellspacing="0" cellpadding="0"/>
				[/#if]
			</div>
		</form>
	</body>
</html>
<script type="text/javascript">
		function checkForm(){
			//发放总量验证
				var totalQty = $("#totalQty").val();
				if(!(/^(([1-9]\d*)|\d)$/).test(totalQty)){
					top.$.jBox.tip('发放总量请输入整数！');
					return false;
				}
			//每人限领验证
				var singleCustMaxQty = $("#singleCustMaxQty").val();
				if(!(/^(([1-9]\d*)|\d)$/).test(singleCustMaxQty)){
					top.$.jBox.tip('每人限领请输入整数！');
					return false;
				}
			//消费最低金额验证
			var minAmtNeed = $("#minAmtNeed").val();
				if(!(/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(minAmtNeed)){
					top.$.jBox.tip('消费最低金额应为小数点后最多保留两位的小数或整数！');
					return false;
				}
			//面额验证
			var cpValue = $("#cpValue").val();
				if(!(/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(cpValue)){
					top.$.jBox.tip('面额应为小数点后最多保留两位的小数或整数');
					return false;
				}
			//面额和消费最低金额大小验证	
				if(Number(minAmtNeed)<=Number(cpValue)){
					top.$.jBox.tip('最低消费金额应大于优惠券面额！');
				    return false;
				}
			var str = "";
			  var j = packTabs.rows.length;
			  for(var i=1;i<j;i++){
			  	var areaIds = $("#areaIds"+i).val();
			  		if(i != j-1){
						str =str +areaIds+";";
					}else{
						str =str +areaIds;
					}
			  }
			  $("#items").val(str);
			  
	  			if (mgt_util.validate(form)){
	  			var oldCcName=$("#oldCcName").val();
				var ccName=$("#ccName").val();
				if(ccName!=oldCcName){
					   $.ajax({
						 url:'${base}/couponCam/findByCcNameFlag.jhtml',
						 sync:false,
						type : 'post',
						dataType : "json",
						data :{ccName:$("#ccName").val()},
						error : function(data) {
							alert("网络异常");
							return false;
						},
						success : function(data) {
							if(data.data){
								$.ajax({
									 url:'${base}/couponCam/findGradeByAreaId.jhtml',
									 sync:false,
									type : 'post',
									dataType : "json",
									data :{items:$("#items").val()},
									error : function(data) {
										alert("网络异常");
										return false;
									},
									success : function(data) {
										if(data.data){
											mgt_util.submitForm('#form');
										}else{
											top.$.jBox.tip('分配区域没有选择完整！');
								 			return false;
										}
									}
								});	
							}else{
								top.$.jBox.tip('编码已存在！');
					 			return false;
							}
						}
					});	
				}else{
				  $.ajax({
						 url:'${base}/couponCam/findGradeByAreaId.jhtml',
						 sync:false,
						type : 'post',
						dataType : "json",
						data :{items:$("#items").val()},
						error : function(data) {
							alert("网络异常");
							return false;
						},
						success : function(data) {
							if(data.data == "1"){
								mgt_util.submitForm('#form');
							}else if(data.data == "3"){
								top.$.jBox.tip('分配区域没有选择完整！');
					 			return false;
							}else{
								top.$.jBox.tip('分配区域有相同记录！');
					 			return false;
							}
						}
					});	
			    }
			  }
    		}
    		
    		//按订单金额规则的金额不能重复
			$(".filetest").live("change",function(){
						var insortNo = $(this).val();
						$(this).removeClass("filetest");
						$(".filetest").each(function(){
						if(insortNo==Number($(this).val())){
							top.$.jBox.tip('金额不能重复！');
							$("#addCouponCam").attr("disabled", true); 
						    return false;
						}else{
							$("#addCouponCam").attr("disabled", false); 
						}
						});
						$(this).addClass("filetest");
			});
			
			//发放规则张数小于限领张数
			$(".cpQty").live("change",function(){
						var i =packTab.rows.length+1;
						var singleCustMaxQty = $("#singleCustMaxQty").val();
						for(var j=1;j<i;j++){
						var cpQty = $("#cpQty"+j).val();
						if(Number(cpQty)>Number(singleCustMaxQty)){
							top.$.jBox.tip('赠送方案不能超过限领张数！');
							$("#addCouponCam").attr("disabled", true); 
						    return false;
						}else{
							$("#addCouponCam").attr("disabled", false); 
						}
						}
			});
			
			//计算按订单规则总金额
			$(".count").live("change",function(){
				var i =packTab.rows.length+1;
				for(var j=1;j<i;j++){
				var cpValue = $("#cpValue").val();
				var cpQty = $("#cpQty"+j).val();
				$("#refNo"+j).val(Number(cpQty)*Number(cpValue));
				}
			});
			
			//活动名称不得超过12字
			$("#ccName").live("change",function(){
				var ccName = $("#ccName").val();
				if(ccName.length >12){
					top.$.jBox.tip('活动名称不得超过12字！');
					$("#addCouponCam").attr("disabled", true); 
					return false;
				}else{
					$("#addCouponCam").attr("disabled", false); 
				}
			});
	
	$().ready(function() {
	//计算按订单规则总金额
			var i =packTab.rows.length+1;
			for(var j=1;j<i;j++){
			var cpValue = $("#cpValue").val();
			var cpQty = $("#cpQty"+j).val();
			$("#refNo"+j).val(Number(cpQty)*Number(cpValue));
			}
			
			if($('input[name=issueType]:checked').val()=='O'){
				$("#packTab").removeClass("sr-only");
		    	$("#rule").removeClass("sr-only");
			}else{
				$("#packTab").addClass("sr-only");
		    	$("#rule").addClass("sr-only");
			}
			
			//优惠券类型为自由券时
			if($('#cpProp').children('option:selected').val()=='O'){
			//清除分配区域内容模块
				$("#area").addClass("sr-only");
				$("#packTabs tbody").html("");
			}else{
				$("#area").removeClass("sr-only");
			}
	
			$('#cpProp').change(function(){ 
			//平台券
				if($(this).children('option:selected').val()=='P'){
					//显示分配区域内容模块
					$("#area").removeClass("sr-only");
					editPack();
				}
			//自由券	
				else if($(this).children('option:selected').val()=='O'){
					//清除分配区域内容模块
					$("#area").addClass("sr-only");
					$("#packTabs tbody").html("");
				}
			});
			
		
			var $areaId = $("input[name='areaIds']");
	  		// 菜单类型选择
			$areaId.lSelect({
				url: "${base}/common/areao.jhtml"
			});
			
			
			$('input[name=issueType]').on("click",function(){
		    	var checkVal;
		    	// 控制“规则区域”按钮
		    	if("O" == $(this).val()){
		    	$("#packTab").removeClass("sr-only");
		    	$("#rule").removeClass("sr-only");
		    	addPack();
		    	}else{
		    	$("#packTab tbody").html("");
		    	$("#packTab").addClass("sr-only");
		    	$("#rule").addClass("sr-only");
		    	}
			});
		});
</script>
