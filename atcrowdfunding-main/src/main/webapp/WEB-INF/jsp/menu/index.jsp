<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh_CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@ include file="/WEB-INF/commons/css.jsp" %>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>
 <jsp:include page="/WEB-INF/commons/top.jsp"></jsp:include>
    <div class="container-fluid">
      <div class="row">
 		<jsp:include page="/WEB-INF/commons/side-bar.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单树</h3>
			  </div>
			  <div class="panel-body">
			  
				<ul id="treeDemo" class="ztree"></ul>
          
			  </div>
			</div>
        </div>
      </div>
    </div>
    
    <!-- 添加菜单 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加菜单</h4>
	      </div>
	      <div class="modal-body">
	      
		     <div class="form-group">
				<input type="hidden" class="form-control" id="pid" name="pid" >
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">菜单名称</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="请输入菜单名称">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">菜单URL</label>
				<input type="text" class="form-control" id="url" name="url" placeholder="请输入菜单URL">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">菜单图标</label>
				<input type="text" class="form-control" id="icon" name="icon" placeholder="请输入菜单图标">
			 </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="saveBtn" type="button" class="btn btn-primary">添加</button>
	      </div>
	    </div>
	  </div>
	</div>
    <!-- 修改菜单 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改菜单</h4>
	      </div>
	      <div class="modal-body">
	      
		     <div class="form-group">
				<input type="hidden" class="form-control" id="updateid" name="id" >
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">修改</label>
				<input type="text" class="form-control" id="updatename" name="name" placeholder="请输入菜单名称">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">菜单URL</label>
				<input type="text" class="form-control" id="updateurl" name="url" placeholder="请输入菜单URL">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">菜单图标</label>
				<input type="text" class="form-control" id="updateicon" name="icon" placeholder="请输入菜单图标">
			 </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="updateBtn" type="button" class="btn btn-primary">添加</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	 <!-- 显示菜单树 -->
	<div class="modal fade" id="assignModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改权限</h4>
	      </div>
	      <div class="modal-body">
		     <ul id="pTreeDemo" class="ztree"></ul>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="saveAssignBtn" type="button" class="btn btn-primary">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	

    <%@ include file="/WEB-INF/commons/js.jsp" %>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
			    initTree();
			});
            function initTree(){
            	
	            var setting = {
	            		data: {
            				simpleData: {
            					enable: true,//true / false 分别表示 使用 / 不使用 简单数据模式
            					pIdKey: "pid"//若数据库t_menu表中的字段是pId就不在用设置
            				},
            				key: {
            					url : "xUrl"
            				}
            			},
            			view:{
            				addDiyDom: function(treeId, treeNode){//设置节点后面显示一个按钮
            					$("#"+treeNode.tId+"_ico").removeClass();//.addClass();
            					$("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")

    						},
    						addHoverDom: function(treeId, treeNode){   //treeNode节点 -> TMenu对象设置鼠标移到节点上，在后面显示一个按钮
    							var aObj = $("#" + treeNode.tId + "_a");
//     							aObj.attr("href", "javascript:;");
    							if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
    							var s = '<span id="btnGroup'+treeNode.tId+'">';
    							if ( treeNode.level == 0 ) { //根节点
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
    							} else if ( treeNode.level == 1 ) { //分支节点
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
    								if (treeNode.children.length == 0) {
    									s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
    								}
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
    							} else if ( treeNode.level == 2 ) { //叶子节点
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
    							}
    							if ( treeNode.level != 0 ){
    								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="PTreeBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="glyphicon glyphicon-pencil"></i></a>';
    							}
    			
    							s += '</span>';
    							aObj.after(s);
    						},
    						removeHoverDom: function(treeId, treeNode){
    							$("#btnGroup"+treeNode.tId).remove();
    						}
            			}
                };
	          

	            var url = "${PATH}/menu/loadTree";
                var json = {} ;
                $.get(url,json,function(result){ // List<TMenu> -> JSON  -> 简单格式json数据
                	var zNodes = result;
                	zNodes.push({id:0,name:"系统菜单",icon:"glyphicon glyphicon-th-list"});
             		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
             		
             		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
             		treeObj.expandAll(true);
                });
            }
		//===添加菜单==开始=====================================================================================
		
		function addBtn(id){
		 $("#addModal").modal({
				show:true,
				backdrop:'static',
				keyboard:false
		 });
		 $("#addModal input[name='pid']").val(id);
		 
		}
		$("#saveBtn").click(function(){
			var pid = $("#addModal input[name='pid']").val();
			var name = $("#addModal input[name='name']").val();
			var url = $("#addModal input[name='url']").val();
			var icon = $("#addModal input[name='icon']").val();
			
			$.ajax({
			type:"post",
			url:"${PATH}/menu/doAdd",
			data:{
				pid:pid,
				name:name,
				url:url,
				icon:icon
			},
			beforeSend:function(){
			return true;
			},
			success:function(result){
				if("ok"==result){
					layer.msg("添加成功",{time:1000},function(){
						$("#addModal").modal("hide");
							$("#addModal input[name='pid']").val("");
							$("#addModal input[name='name']").val("");
							$("#addModal input[name='url']").val("");
							$("#addModal input[name='icon']").val("");
						initTree();
					});
				}else{
					layer.msg("添加失败");
				}
			}
			
		 });
		});
		
			
		//===添加菜单==结束=====================================================================================
			
			
		//===修改菜单==开始=====================================================================================
		function updateBtn(id){
			$.get("${PATH}/menu/getTMenuById",{id:id},function(result){
				console.log(result);
				$("#updateModal").modal({
					show:true,
					backdrop:'static',
					keyborad:false
					
				});
				$("#updateModal input[name=id]").val(result.id);
				$("#updateModal input[name=name]").val(result.name);
				$("#updateModal input[name=url]").val(result.url);
				$("#updateModal input[name=icon]").val(result.icon);
			});
		};
		$("#updateBtn").click(function(){
			var id = $("#updateModal input[name=id]").val();
			var name = $("#updateModal input[name=name]").val();
			var url = $("#updateModal input[name=url]").val();
			var icon = $("#updateModal input[name=icon]").val();
			$.post("${PATH}/menu/updateTMenu",{
				id:id,
				name:name,
				url:url,
				icon:icon
			},function(result){
				if("ok"==result){
					layer.msg("修改成功!",{time:1000},function(){
						$("#updateModal").modal("hide");
						initTree();
					});
				}else{
					layer.msg("修改失败");
				}
			});
		});
		
		//===修改菜单==结束=====================================================================================
			
			
		//===删除菜单==开始=====================================================================================
		function deleteBtn(id){
			layer.confirm("确认要删除这个菜单?",{btn:['确定','取消']},function(index){
				$.post("${PATH}/menu/deleteTMenuById",{id:id},function(result){
					if("ok"==result){
						layer.msg("删除成功",{time:1000},function(){
							initTree();
						});
					}else{
						layer.msg("删除失败");
					}
					
				});
				
				layer.close(index);
			},function(index){
				layer.close(index);
			});
		}
			
		
		//===删除菜单==结束=====================================================================================
    	//==权限树模态框显示==开始=====================================================================================	   
    	var menuId = '';
   		function PTreeBtn(id){
   			menuId = id;
			//显示模态框
			$("#assignModal").modal({
				show:true,
				backdrop:'static',
				keyborad:false
			});
			initPTree(menuId);
		}
	 	function initPTree(menuId){
	   	
	       var setting = {
	       		check:{
	       			enable:true
	       		},
	       		data: {
	   				simpleData: {
	   					enable: true,//true / false 分别表示 使用 / 不使用 简单数据模式
	   					pIdKey: "pid"//若数据库t_menu表中的字段是pId就不在用设置
	   				},
	      				key: {
	      					url : "xUrl",
	      					name: "title"
	      				}
	   			},
	   			view:{
	   				addDiyDom: function(treeId, treeNode){//设置节点后面显示一个按钮
	   					$("#"+treeNode.tId+"_ico").removeClass();//.addClass();
	   					$("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
	
					}
	   			}
	       };
	       var url = "${PATH}/permission/loadTree";
           //1.加载数据
           $.get(url,function(data){ // List<TMenu> -> JSON  -> 简单格式json数据
           		var zNodes = data;
        		$.fn.zTree.init($("#pTreeDemo"), setting, zNodes);
        		var treeObj = $.fn.zTree.getZTreeObj("pTreeDemo");
        		treeObj.expandAll(true);
        		//回显分配许可
        		$.get("${PATH}/menu/listPermissionIdByMenuId",{menuId:menuId},function(result){
        			$.each(result,function(i,e){
        				var permissionId = e;
        				var treeObj = $.fn.zTree.getZTreeObj("pTreeDemo");
       				var node = treeObj.getNodeByParam("id", permissionId, null);
       				treeObj.checkNode(node, true, false , false);
        			});
        		});

           });
	 	 }
    	//==权限树模态框显示==结束=====================================================================================	   
    	//==修改菜单权限保存到数据库==开始=====================================================================================	   
    	$("#saveAssignBtn").click(function(){
            	var json = {
            			menuId:menuId
            	}
            	console.log(menuId);
            	//取得已选数据
            	var treeObj = $.fn.zTree.getZTreeObj("pTreeDemo");
        		var nodes = treeObj.getCheckedNodes(true);
//         		if(nodes.length==0){//有这句话就不能清空权限了
//         			layer.msg("请先选择再保存!");
//         			return false;
//         		}
            	$.each(nodes,function(i,e){
            		var permissionId = e.id;
            		console.log(permissionId);
            		json['ids['+i+']'] = permissionId;
            	});
            	
            	
            	
            	$.ajax({
            		type:"post",
            		url:"${PATH}/menu/savePermissionandMenuRelationship",
            		data:json,
            		success:function(result){
            			if("ok"==result){
            				layer.msg("修改权限成功!",{icon:6,time:1000},function(){
            					$("#assignModal").modal("hide");
            					
            					
            				});
            			}else{
            				layer.msg("添加权限失败!");
            			}
            		}
            	});
            	
            });
    	//==修改菜单权限==结束=====================================================================================	   
           
        </script>
  </body>
</html>
