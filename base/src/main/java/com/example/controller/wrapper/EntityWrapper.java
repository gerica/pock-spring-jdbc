package com.example.controller.wrapper;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class EntityWrapper implements Serializable {

	private static final long serialVersionUID = 1L;
	private List<Map<String, Object>> entitiesChilds;
	private Map<String, Object> entityParent;

	public List<Map<String, Object>> getEntitiesChilds() {
		return entitiesChilds;
	}

	public Map<String, Object> getEntityParent() {
		return entityParent;
	}

	public void setEntitiesChilds(List<Map<String, Object>> entitiesChilds) {
		this.entitiesChilds = entitiesChilds;
	}

	public void setEntityParent(Map<String, Object> entityParent) {
		this.entityParent = entityParent;
	}

}
