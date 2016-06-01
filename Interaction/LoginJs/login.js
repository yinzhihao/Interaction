"user strict"

var Login = (function(){
	function Login(){

	}

	Login.prototype.login = function(){
		this.appRequest("JSInteraction", "showAleart", "Start...");
	}

    /**
     * 设置登录信息
     * @logininfoJson json参数字符串
     */
	Login.prototype.setLoginInfo = function(logininfoJson){
		//解析json字符串
        var logininfo = eval("("+logininfoJson+")");

		document.getElementById("txtUsername").value = logininfo.Username;
		document.getElementById("txtPassword").value = logininfo.Password;
	}

    Login.prototype.appRequest = function(appAction, functionName, parameters){
        var requestCommand = appAction + ":" + functionName + ":" + parameters;

        window.location = requestCommand;
    }
             
	return Login;
})();

var loginObj = new Login();

window.onload=function(){
    loginObj.appRequest("executeScript", "loginObj.setLoginInfo", "");
}
