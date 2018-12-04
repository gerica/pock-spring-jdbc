package com.example.config.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.example.controller.BaseController;

@Component
@Order(1)
public class TransactionFilter implements Filter {

	@Autowired
	private BaseController controller;

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterchain) throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;

		String nameModule = httpRequest.getHeader("NameModule");
		String nameTable = httpRequest.getHeader("NameTable");
		String namePrimaryKey = httpRequest.getHeader("NamePrimaryKey");

		if (!StringUtils.isEmpty(nameModule)) {
			controller.setNameModule(nameModule);
		} else {
			controller.setNameModule(null);
		}
		if (!StringUtils.isEmpty(nameTable)) {
			controller.setNameTable(nameTable);
		} else {
			controller.setNameTable(null);
		}
		if (!StringUtils.isEmpty(namePrimaryKey)) {
			controller.setNamePrimaryKey(namePrimaryKey);
		} else {
			controller.setNamePrimaryKey(null);
		}
		filterchain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterconfig) throws ServletException {
	}
}
