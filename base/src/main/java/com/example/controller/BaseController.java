package com.example.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(BaseController.URL)
public class BaseController extends CrudController {

	protected static final String URL = "/base";

	public BaseController() {
		super();
	}

}