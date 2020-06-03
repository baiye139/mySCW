package com.baiye.atcrowdfunding.mapper;

import com.baiye.atcrowdfunding.bean.TAdminRole;
import com.baiye.atcrowdfunding.bean.TAdminRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TAdminRoleMapper {
    long countByExample(TAdminRoleExample example);

    int deleteByExample(TAdminRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TAdminRole record);

    int insertSelective(TAdminRole record);

    List<TAdminRole> selectByExample(TAdminRoleExample example);

    TAdminRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TAdminRole record, @Param("example") TAdminRoleExample example);

    int updateByExample(@Param("record") TAdminRole record, @Param("example") TAdminRoleExample example);

    int updateByPrimaryKeySelective(TAdminRole record);

    int updateByPrimaryKey(TAdminRole record);

	List<Integer> getRoleIdByAdminId(@Param("id") Integer id);

	void saveTAdimnAndRoleRelationship(@Param("roleIds") Integer[] roleId,@Param("adminid") Integer adminId);

	void deleteTAdimnAndRoleRelationship(@Param("roleIds") Integer[] roleId,@Param("adminid") Integer adminId);
}