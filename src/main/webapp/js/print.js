/**
 * 打印方法
 */
function funPrint(){
	$("#printdiv").jqprint();
	//$('#printdiv').jqprint({ operaSupport: true });
    //debug: false,//如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false   
    //importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）   
    //printContainer: true,//表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。   
    //operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true  
}