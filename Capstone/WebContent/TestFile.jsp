<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Test</title>
	<script src="https://kit.fontawesome.com/62f9f1cacb.js" crossorigin="anonymous"></script>
</head>
<body onload="enableEditMode();">
	<div>
		<button onclick="execCmd('bold');"><i class="fa fa-bold" aira-hidden="true"></i></button>
		<button onclick="execCmd('justifyLeft');"><i class="fa fa-align-left" aira-hidden="true"></i></button>
		<button onclick="execCmd('justifyCenter');"><i class="fa fa-align-center" aira-hidden="true"></i></button>
		<button onclick="execCmd('justifyRight');"><i class="fa fa-align-right" aira-hidden="true"></i></button>
	</div>
	<iframe name="richTextField" style="width: 90%; height: 50%;"></iframe>
	<script type="text/javascript">
		function enableEditMode(){
			richTextField.document.designMode = "On";
		}
		function execCmd(command){
			richTextField.document.execCommand(command,false,null);
		}
	</script>
</body>
</html>