package com.example.controller;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.controller.wrapper.ResponseWrapper;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(ProjetoController.URL)
public class ProjetoController {
	static final String URL = "/projeto";

	private static final String SELECT_FROM_TB_PROJETO = "select * from \"TBProjeto\";";
	private String INSERT_INTO = "INSERT INTO public.\"TBProjeto\"(%s) VALUES (%s)";
	private String DELETE_INTO = "DELETE FROM public.\"TBProjeto\" WHERE \"IDProjeto\"=%s";

	private static final Logger log = LoggerFactory.getLogger(ProjetoController.class);

	@Autowired
	JdbcTemplate jdbcTemplate;

	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		log.info("ProjetoController.fetchAll()");

		return ResponseEntity.ok().body(jdbcTemplate.queryForList(SELECT_FROM_TB_PROJETO, new Object[] {}));
	}

	@PostMapping
	public ResponseEntity<Serializable> save(@RequestBody Map<String, String> mapJson) {
		log.info("ProjetoController.gravar()");

		String namesColumns = mapJson.keySet().stream().map(e -> "\"" + e.toString() + "\"").collect(Collectors.joining(","));
		String valuesColumns = mapJson.values().stream().map(e -> "?").collect(Collectors.joining(","));

		int rowsAffected = jdbcTemplate.update(String.format(INSERT_INTO, namesColumns, valuesColumns), mapJson.values().toArray());

		return ResponseEntity.ok().body(new ResponseWrapper(rowsAffected));
	}

	@DeleteMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> delete(@PathVariable int id) {
		log.info("ProjetoController.delete()");

		int rowsAffected = jdbcTemplate.update(String.format(DELETE_INTO, id));
		return ResponseEntity.ok().body(new ResponseWrapper(rowsAffected));
	}
}
