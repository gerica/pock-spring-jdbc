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

	@Value("${app.module.projeto}")
	public String moduleProjeto;
	@Value("${app.module.projeto.dispendio}")
	public String moduleProjetoDispendio;

	public String nameModule;
	public String namePrimaryKey;
	public String nameTable;

	public String getModuleProjeto() {
		return moduleProjeto;
	}

	public String getModuleProjetoDispendio() {
		return moduleProjetoDispendio;
	}

	public String getNameModule() {
		return nameModule;
	}

	public String getNamePrimaryKey() {
		if (getNameModule() != null) {
			return "ID" + getNameModule();
		}
		return namePrimaryKey;
	}

	public String getNameTable() {
		if (getNameModule() != null) {
			return "TB" + getNameModule();
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
