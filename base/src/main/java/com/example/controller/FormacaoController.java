package com.example.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.controller.config.CrudController;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(FormacaoController.URL)
public class FormacaoController extends CrudController {

	protected static final String URL = "/formacao";

	@Value("${app.module.formacao}")
	public String nameModule;
	@Value("${app.module.formacaoPK}")
	public String namePrimaryKey;

	public FormacaoController() {
	}

	@Override
	public void init() {
		this.appParams.setNameModule(nameModule);
		this.appParams.setNamePrimaryKey(namePrimaryKey);
		super.init();
	}

}