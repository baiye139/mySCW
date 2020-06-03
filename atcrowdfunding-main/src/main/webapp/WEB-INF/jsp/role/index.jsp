<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<security:authorize access="hasRole('PM - 项目经理')" var="flag">
	<button id="deleteALL" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
	<button id="addBtn"  type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
</security:authorize>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
              
              </thead>
              
              <tbody>
              </tbody>
			  <tfoot>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
    <!-- 添加角色 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加角色</h4>
	      </div>
	      <div class="modal-body">
		     <div class="form-group">
				<label for="exampleInputPassword1">角色名称</label>
				<input type="text" class="form-control" id="name2" name="name" placeholder="请输入角色名称">
			 </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="saveBtn" type="button" class="btn btn-primary">添加</button>
	      </div>
	    </div>
	  </div>
	</div>
	
    <!-- 修改角色 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改角色</h4>
	      </div>
	      <div class="modal-body">
		     <div class="form-group">
				<label for="exampleInputPassword1">角色名称</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="请输入角色名称">
			 </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="updateBtn" type="button" class="btn btn-primary">修改</button>
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
		     <ul id="treeDemo" class="ztree"></ul>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button id="saveAssignBtn" type="button" class="btn btn-primary">修改</button>
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
			    initData(1);
            });
            //===开始分页=================================================================================
           	var json ={
           			pageNum:1,
           			pageSize:2,
           			
           	}
            function initData(pageNum){
            	json.pageNum = pageNum;
            	
	           	//1.发起ajax
	           	
	           	var index = -1;
	           	$.ajax({
	           		type:'post',
	           		url:"${PATH}/role/loadData",
	           		data:json,
	           		beforeSend:function(){
	           			index = layer.load(0,{time:10*1000});
	           			return true;
	           		},
	           		success:function(result){
	           			console.log(result);
	           			initThead();
	           			initShow(result);
	           			layer.close(index);
	           			
	           			initNavg(result);
	           			
	           		}
	           		
	           		
	           	});
            }
           //2.展示数据 
           //2.1数据头
           function initThead(){
        	   var content = '';
        	   content += '<tr >';
        	   content += '	<th width="30">#</th>';
        	   content += '	<th width="30"><input type="checkbox" id="selectAll"></th>';
        	   content += '	<th>名称</th>';
        	   content += '	<th width="100">操作</th>';
        	   content += '</tr>';
        	   $("thead").empty();
        	   $("thead").append(content);
           }
           function initNavg(result){
        	   var flag = true;
        	   flag = ${flag};
        	   var list = result.list;
        	   var content = '';
        	   $.each(list,function(i,e){
        		   content += '<tr>';
        		   content += ' <td>'+(i+1)+'</td>';
        		   content += ' <td><input type="checkbox" roleId="'+e.id+'"></td>';
        		   content += ' <td>'+e.name+'</td>';
        		   content += ' <td>';
        		   if(flag){
	        		   content += '	  <button type="button" roleId="'+e.id+'" class="assignClass btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
	        		   content += '	  <button type="button" roleId="'+e.id+'" roleName="'+e.name+'" class="updateClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
	        		   content += '	  <button type="button" roleId="'+e.id+'" class="deleteClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
        		   }
        		   content += ' </td>';
        		   content += '</tr>';
        	   });
        	   $("tbody").empty();
        	   $("tbody").append(content);
           };
           //3.展示分页
           function initShow(result){
           	var content = '';
           	
           	
           	content += '<tr >';
           	content += ' <td colspan="6" align="center">';
           	content += '	<ul class="pagination">';
           	if(!result.isFirstPage){
	           	content += '		<li class="disabled"><a onclick="initData('+result.prePage+')">上一页</a></li>';
           	}else{
           		content += '					<li class="disabled"><a>上一页</a></li>';
           	}
           	$.each(result.navigatepageNums,function(i,num){
           		if(num == result.pageNum){
		           	content += '		<li class="active"><a onclick="initData('+num+')">'+num+'<span class="sr-only">(current)</span></a></li>';
           		}else{
		           	content += '		<li><a onclick="initData('+num+')">'+num+'</a></li>';
           		}
           	});
           	if(!result.isLastPage){
	           	content += '		<li><a onclick="initData('+result.nextPage+')">下一页</a></li>';
           	}else{
           		content += '					<li class="disabled"><a>下一页</a></li>';
           	}
           	content += '	</ul>';
           	content += ' </td>';
           	content += '</tr>';
           	$("tfoot").empty();
           	$("tfoot").append(content);
           	
           };
           //===分页结束================================================================================= 
        	   
        	   
        	   
        	   
           //===开始查询=================================================================================  
        	$("#queryBtn").click(function(){
        		var condition = $("#condition").val();
        		json.condition = condition;
        		
        		//执行页面初始化
        		initData(1);
        		
        		
        		
        	});  
        	   
           //===查询结束=================================================================================
            
           //===开始添加角色==============================================================================
            $("#addBtn").click(function(){
            	$("#addModal").modal({
            			show:'true',
            			backdrop:'static'
            	});
            });
           $("#saveBtn").click(function(){
        	   var name = $("#addModal input[name='name']").val();
        	   var index2 = -1;
        	   $.ajax({
        		   type:"post",
        		   url:"${PATH}/role/addRole",
        	   	   data:{name:name},
        	   	   beforeSend:function(){
        	   		   return true;
        	   	   },
        	   	   success:function(result){
        	   			layer.close(index2);
        	   		   if("ok"==result){
        	   			   layer.msg("添加成功",{time:1000},function(){
        	   				initData(1);
        	   				$("#addModal").modal('hide');
        	   			   });
        	   		   }else if("403"==result){
        	   				layer.msg("访问权限不够,403!",{time:1000,icon:5},function(){
        	   				$("#addModal").modal('hide');
        	   				});
        	   			   
        	   		   }else{
        	   			 layer.msg("添加失败"); 
        	   		   }
        	   	   },
        	   	   error:function (XMLHttpRequest, textStatus, errorThrown) {
        	   	    // 通常 textStatus 和 errorThrown 之中
        	   	    console.log(textStatus);
        	   	    console.log(XMLHttpRequest);
        	   	 	layer.msg("出现异常请稍后再试,或联系xxx!",{time:1000,icon:5},function(){
    	   				$("#addModal").modal('hide');
    	   			   });
        	   	    // 只有一个会包含信息
        	   	    this; // 调用本次AJAX请求时传递的options参数
        	   	}
        	   });
           });
            
            
           //===添加角色结束==============================================================================
        	   
           //===修改角色名称开始============================================================================
        	  $("tbody").on('click','.updateClass',function(){
        		  var roleId = $(this).attr("roleId");
        		  var roleName = $(this).attr("roleName");
        		  $("#updateModal").modal({
        			  show:'true',
        			  backdrop:'static',
        			  keyboard:'false'
        		  });
        		  //回显名称
        		  $("#updateModal input[name='name']").val(roleName);
        		  //去修改
        		  $("#updateBtn").click(function(){
        			  
        			var name = $("#updateModal input[name='name']").val();
        			alert();
	        		  $.post("${PATH}/role/updateRole",{
				        			  id:roleId,
				        			  name:name,
	        			},
	        			function(result){
	        			  if("ok"==result){
	       	   			   layer.msg("修改成功",{time:1000},function(){
		       	   				initData(json.pageNum);
	        	   				$("#updateModal").modal('hide');
	       	   			   	});
	       	   		  	  }else{
	       	   			   layer.msg("修改失败");
	       	   		      }
       		  		    });
        		  });
        	  }); 
        	   
           //===修改角色名称结束============================================================================
           //===删除角色 开始==============================================================================
        	$("tbody").on('click','.deleteClass',function(){
        		var roleId = $(this).attr("roleId");
        		 layer.confirm("确定要删除这个角色?",{btn:['确定','取消']},
     				 function(index){
		        		 $.post("${PATH}/role/deleteRole",{id:roleId},
	        				 function(result){
		        			 	if("ok"==result){
		        			 		layer.msg("删除成功");
		        			 		initData(json.pageNum);
		        			 	}else{
		        			 		layer.msg("删除失败");
		        			    }
		        		 });
        			 	layer.close(index);
	        		 },function(index){
	        			layer.close(index);
       		   	});
        		 
        	});
           //===删除角色 结束==============================================================================
           //===一键选中当前页==============================================================================
        	$("thead").on('click','#selectAll',function(){
        		$("tbody input[type='checkbox']:enabled").prop("checked",this.checked);
        	});
        	   
           //===批量删除角色 开始==============================================================================
            $("#deleteALL").click(function(){
            	//取全部选中的id
            	var checkboxList = $("tbody input[type='checkbox']:checked");
            	if(checkboxList.length==0){
            		layer.msg("请先勾选!");
           			return false;
            	}
            	var array = new Array();
            	var ids = '';
            	$.each(checkboxList,function(i,e){
            		var roleId = $(e).attr("roleId");
            		array.push(roleId);
            	});
            	ids = array.join(",");
            	console.log(ids);
            	layer.confirm("确认要删除这些?",{btn:['确定','取消']},function(index){
            		//开始删除
            		$.post("${PATH}/role/deleteBatch",{ids:ids},function(result){
            			if("ok"==result){
            				layer.msg("删除成功!");
            				initData(json.pageNum);
            			}else{
            				layer.msg("删除失败!");
            			}
            		});
            		layer.close(index);
            	},function(index){
            		layer.close(index);
            	});
            });
           //显示树=====================================================================================
             function initTree(){
            	
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
             		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
             		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
             		treeObj.expandAll(true);
             		//回显分配许可
             		$.get("${PATH}/role/listPermissionIdByRoleId",{roleId:roleId},function(data){
             			$.each(data,function(i,e){
             				var permissionId = e;
             				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            				var node = treeObj.getNodeByParam("id", permissionId, null);
            				treeObj.checkNode(node, true, false , false);
             			});
             		});
 
                });
            }
            //==权限树模态框显示==开始=====================================================================
            var roleId = '';
            $("tbody").on("click",".assignClass",function(){
            	$("#assignModal").modal({
            		show:true,
            		backdrop:'static',
            		keyborad:false
            	});
            	//获取数据
            	roleId = $(this).attr("roleId");
            	//1:初始化树
            	initTree();
            	//2.获取该角色对应的权限
            	
            });	
            //保存数据+++++
            $("#saveAssignBtn").click(function(){
            	var json = {
            			roleId:roleId
            	}
            	console.log(roleId);
            	//取得已选数据
            	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        		var nodes = treeObj.getCheckedNodes(true);
//         		if(nodes.length==0){
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
            		url:"${PATH}/role/toAssignPermissionToRole",
            		data:json,
            		success:function(result){
            			if("ok"==result){
            				layer.msg("添加权限成功!",{icon:6,time:1000},function(){
            					$("#assignModal").modal("hide");
            					
//             					initTree();//已经关闭了不用调用
            				});
            			}else{
            				layer.msg("添加权限失败!");
            			}
            		}
            	});
            	
            });
            //==显示权限树模态框显示==结束=====================================================================
            
            
            
            
            
            
        </script>
  </body>
</html>
    