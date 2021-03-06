package cn.qpwa.mgt.core.system.dao;

import cn.qpwa.common.core.dao.EntityDao;
import cn.qpwa.common.page.Page;
import cn.qpwa.mgt.facade.system.entity.SysBizActionLog;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface SysBizLogDAO extends EntityDao<SysBizActionLog>{
	
	public Page findSysLogPage(Map<String, Object> paramMap, LinkedHashMap<String, String> orderby);
	
	public List<Map<String, Object>> findNearestSysLog(Map<String, Object> paramMap);
	
}
