package com.example.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(TipoProjetoController.URL)
public class TipoProjetoController {
	private static final Logger log = LoggerFactory.getLogger(TipoProjetoController.class);

	private static final String SELECT_ALL = "select * from \"TBTipoProjeto\"";
	static final String URL = "/tipoProjeto";

	@Autowired
	JdbcTemplate jdbcTemplate;

	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		List<Map<String, Object>> result = jdbcTemplate.queryForList(SELECT_ALL, new Object[] {});
		return ResponseEntity.ok().body(result);
	}

}
