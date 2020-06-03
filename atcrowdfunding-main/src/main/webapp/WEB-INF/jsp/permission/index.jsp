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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 许可权限管理</h3>
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
	        <h4 class="modal-title" id="myModalLabel">添加权限</h4>
	      </div>
	      <div class="modal-body">
	      
		     <div class="form-group">
				<input type="hidden" class="form-control" id="adPid" name="pid" >
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">权限标题</label>
				<input type="text" class="form-control" id="adTitle" name="title" placeholder="请输入权限标题">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">权限名称</label>
				<input type="text" class="form-control" id="adName" name="name" placeholder="请输入权限名称">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">权限图标</label>
				<input type="text" class="form-control" id="adIcon" name="icon" placeholder="请输入权限图标">
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
	        <h4 class="modal-title" id="myModalLabel">修改权限</h4>
	      </div>
	      <div class="modal-body">
	      
		     <div class="form-group">
				<input type="hidden" class="form-control" id="upId" name="id" >
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">权限标题</label>
				<input type="text" class="form-control" id="upTitle" name="title" placeholder="请输入权限标题">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">权限名称</label>
				<input type="text" class="form-control" id="upName" name="name" placeholder="请输入权限名称">
			 </div>
		     <div class="form-group">
				<label for="exampleInputPassword1">权限图标</label>
				<input type="text" class="form-control" id="upIcon" name="icon" placeholder="请输入权限图标">
			 </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
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
            					url : "xUrl",
            					name: "title"
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
    							
    							s += '</span>';
    							aObj.after(s);
    						},
    						removeHoverDom: function(treeId, treeNode){
    							$("#btnGroup"+treeNode.tId).remove();
    						}
            			}
                };
	          

	            var url = "${PATH}/permission/loadTree";
                var json = {} ;
                $.get(url,json,function(result){ // List<TMenu> -> JSON  -> 简单格式json数据
                	var zNodes = result;
                	zNodes.push({id:0,title:"系统菜单",icon:"glyphicon glyphicon-th-list"});
             		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
             		
             		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
             		treeObj.expandAll(true);
  // 展开当前选择的第一个节点（包括其全部子节点）           		
//              		var nodes = treeObj.getSelectedNodes();
//              		if (nodes.length>0) {
//              			treeObj.expandNode(nodes[1], true, true, true);
//              		}
                });
            }
		//===添加菜单==开始=====================================================================================
		
		function addBtn(id){
		 $("#addModal").modal({
				show:true,
				backdrop:'static',
				keyboard:false
		 });
		 $("#adPid").val(id);
		 
		}
		$("#saveBtn").click(function(){
			var pid= $("#adPid").val();
			var title = $("#adTitle").val();
			var name = $("#adName").val();
			var icon = $("#adIcon").val();
			
			$.ajax({
			type:"post",
			url:"${PATH}/permission/doAdd",
			data:{
				pid:pid,
				name:name,
				title:title,
				icon:icon
			},
			beforeSend:function(){
			return true;
			},
			success:function(result){
				if("ok"==result){
					layer.msg("添加成功",{time:1000},function(){
						$("#addModal").modal("hide");
						$("#adPid").val("");
						$("#adTitle").val("");
						$("#adName").val("");
						$("#adIcon").val("");
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
			$.get("${PATH}/permission/getTPermissionById",{id:id},function(result){
				console.log(result);
				$("#updateModal").modal({
					show:true,
					backdrop:'static',
					keyborad:false
					
				});
				$("#upId").val(result.id);
				$("#upTitle").val(result.title);
				$("#upName").val(result.name);
				$("#upIcon").val(result.icon);
			});
		};
		$("#updateBtn").click(function(){
			var id = $("#upId").val();
			var title = $("#upTitle").val();
			var name = $("#upName").val();
			var icon = $("#upIcon").val();
			$.post("${PATH}/permission/updateTPermission",{
				id:id,
				title:title,
				name:name,
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
			layer.confirm("确认要删除这个权限?",{btn:['确定','取消']},function(index){
				$.post("${PATH}/permission/deleteTPermissionById",{id:id},function(result){
					
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
    		   
           
        </script>
  </body>
</html>
