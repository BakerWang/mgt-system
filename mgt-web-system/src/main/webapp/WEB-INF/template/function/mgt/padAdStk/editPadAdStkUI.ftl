<!DOCTYPE html>
<html>
	<head>
		<title>广告商品新增</title>
		[#include "/common/commonHead.ftl" /]
		<link rel="shortcut icon" href="${base}/styles/images/16.ico" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
		<link rel="stylesheet" media="screen" href="${base}/styles/css/base/css/ztree.css" />
	</head>
	<body class="toolbar-fixed-top">
		<form class="form-horizontal" id="form" action="${base}/padAdStk/add.jhtml" method="POST">
			<div class="navbar-fixed-top" id="toolbar">
				<button class="btn btn-danger" data-toggle="jBox-call" data-fn="checkForm">保存
					<i class="fa-save  align-top bigger-125 fa-on-right"></i>
				</button>
				<button class="btn btn-warning" data-toggle="jBox-close">关闭
					<i class="fa-undo align-top bigger-125 fa-on-right"></i>
				</button>
			</div>
 	        
			<div class="page-content">
				[#if padAdStkMas?exists]
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
							<label for="name" class="col-sm-4 control-label">
								商品编号：
							</label>
							<div class="col-sm-7">
								<input type="text" value='${padAdStkMas.id.stkC}' class="form-control input-sm required" id="stkC" name="stkC" maxlength=100>
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
					<div class="col-xs-5">
						<div class="form-group">
							<label for="pId" class="col-sm-4 control-label">
								原价：
							</label>
							<div class="col-sm-7">
								<input type="text" value='${padAdStkMas.listPrice}' class="form-control input-sm required" name="listPrice" id="listPrice" maxlength=10>
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
				</div>
				</div>
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
						    <label for="visible" class="col-sm-4 control-label">折扣：</label>
							<div class="col-sm-7">
								<input type="text" value='${padAdStkMas.discNum}' class="form-control input-sm required" name="discNum" id="discNum" maxlength=10>
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
					<div class="col-xs-5"> 
						<div class="form-group">
							<label for="sortby" class="col-sm-4 control-label">净价：</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm number required"
								id="netPrice" name="netPrice" value='${padAdStkMas.netPrice}' maxlength=10>
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-5">
						<div class="form-group">
							<label for="sortby" class="col-sm-4 control-label">二维码url：</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm"
								id="qrCodeUrl" name="qrCodeUrl" value='${padAdStkMas.qrCodeUrl}' maxlength=200>
							</div>
						</div>
					</div>
					<div class="col-xs-5">
						<div class="form-group">
							<label for="sortby" class="col-sm-4 control-label">排序依据：</label>
							<div class="col-sm-7">
								<input type="text" class="form-control input-sm number required"
								id="sortNo" name="sortNo" value='${padAdStkMas.sortNo}' maxlength=6>
							</div>
							<span class="help-inline col-sm-1">*</span>
						</div>
					</div>
				</div>
			[#else]
			<div class="row">
				<div class="col-xs-5">
					<div class="form-group">
						<label class="col-sm-4 control-label">数据出错，请刷新再试！</label>
					</div>
				</div>
			</div>
			[/#if]
			</div>
			</div>
		</form>
	</body>
</html>
<script>
function checkForm(){
	mgt_util.submitForm('#form');
}
</script>