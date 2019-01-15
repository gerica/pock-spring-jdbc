package com.example.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

/**
 * 
 * @author rogeriocardoso Essa classe sera criada por request
 *         https://stackoverflow.com/questions/14731092/spring-request-scope-bean
 */

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class AppParams {

	public String nameModule;
	public String namePrimaryKey;
	public String nameTable;

	public String getNameModule() {
		return nameModule;
	}

	public String getNamePrimaryKey() {
		if (namePrimaryKey == null || namePrimaryKey.trim().equals("")) {
			if (getNameModule() != null) {
				return "ID" + getNameModule();
			}
		}
		return namePrimaryKey;
	}

	public String getNameTable() {
		if (nameTable == null || nameTable.trim().equals("")) {
			if (getNameModule() != null) {
				return "TB" + getNameModule();
			}
		}
		return nameTable;
	}

	public void setNameModule(String nameModule) {
		this.nameModule = nameModule;
	}

	public void setNamePrimaryKey(String namePrimaryKey) {
		this.namePrimaryKey = namePrimaryKey;
	}

	public void setNameTable(String nameTable) {
		this.nameTable = nameTable;
	}
}
