package com.example.controller;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

import com.example.config.annotation.PrepareEntity;
import com.example.controller.wrapper.ResponseWrapper;
import com.example.util.UtilAtributo;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(ProjetoController.URL)
public class ProjetoController {
	private static final String SELECT_FROM_TB_PROJETO = "select * from \"TBProjeto\";";
	static final String URL = "/projeto";
	private String DELETE_TABLE = "DELETE FROM public.\"TBProjeto\" WHERE \"IDProjeto\"=%s";

	private String INSERT_TABLE = "INSERT INTO public.\"TBProjeto\"(%s) VALUES (%s)";

	private String SELECT_FROM_ID = "select * from \"TBProjeto\" WHERE \"IDProjeto\"=%s";

	private String UPDATE_TABLE = "UPDATE public.\"TBProjeto\" SET %s WHERE \"IDProjeto\"=%s";

	@Autowired
	JdbcTemplate jdbcTemplate;

	@DeleteMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> delete(@PathVariable int id) {
		int rowsAffected = jdbcTemplate.update(String.format(DELETE_TABLE, id));
		return ResponseEntity.ok().body(new ResponseWrapper(rowsAffected));
	}

	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		List<Map<String, Object>> result = jdbcTemplate.queryForList(SELECT_FROM_TB_PROJETO, new Object[] {});
		return ResponseEntity.ok().body(result);
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> fetchById(@PathVariable int id) {
		List<Map<String, Object>> result = jdbcTemplate.queryForList(String.format(SELECT_FROM_ID, id), new Object[] {});
		return ResponseEntity.ok().body(new ResponseWrapper(result));
	}

	@PostMapping
	@PrepareEntity
	public ResponseEntity<Serializable> save(@RequestBody Map<String, String> mapJson) {
		for (String key : mapJson.keySet()) {
			if (key == "IDProjeto") {
				return update(mapJson);
			}
		}

		return insert(mapJson);
	}

	private ResponseEntity<Serializable> insert(Map<String, String> mapJson) {
		String namesColumns = mapJson.keySet().stream().map(e -> "\"" + e.toString() + "\"").collect(Collectors.joining(","));
		String valuesColumns = mapJson.keySet().stream().map(e -> "?").collect(Collectors.joining(","));

		int rowAffected = jdbcTemplate.update(String.format(INSERT_TABLE, namesColumns, valuesColumns), mapJson.values().toArray());
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

	private ResponseEntity<Serializable> update(Map<String, String> mapJson) {

		int rowAffected = jdbcTemplate.update(UtilAtributo.prepararUpdate(mapJson, UPDATE_TABLE, "IDProjeto"));
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

}
