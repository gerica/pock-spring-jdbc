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
	private static final Logger log = LoggerFactory.getLogger(ProjetoController.class);

	private static final String SELECT_FROM_TB_PROJETO = "select * from \"TBProjeto\";";
	static final String URL = "/projeto";
	private String DELETE_TABLE = "DELETE FROM public.\"TBProjeto\" WHERE \"IDProjeto\"=%s";

	private String INSERT_TABLE = "INSERT INTO public.\"TBProjeto\"(%s) VALUES (%s)";

	@Autowired
	JdbcTemplate jdbcTemplate;

	private String SELECT_FROM_ID = "select * from \"TBProjeto\" WHERE \"IDProjeto\"=%s";

	private String UPDATE_TABLE = "UPDATE public.\"TBProjeto\" SET %s WHERE \"IDProjeto\"=%s";

	@DeleteMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> delete(@PathVariable int id) {
		log.info("ProjetoController.delete()");

		int rowsAffected = jdbcTemplate.update(String.format(DELETE_TABLE, id));
		return ResponseEntity.ok().body(new ResponseWrapper(rowsAffected));
	}

	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		log.info("ProjetoController.fetchAll()");

		List<Map<String, Object>> result = jdbcTemplate.queryForList(SELECT_FROM_TB_PROJETO, new Object[] {});
		return ResponseEntity.ok().body(result);
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> fetchById(@PathVariable int id) {
		log.info("ProjetoController.fetchById()");

		List<Map<String, Object>> result = jdbcTemplate.queryForList(String.format(SELECT_FROM_ID, id), new Object[] {});
		return ResponseEntity.ok().body(new ResponseWrapper(result));
	}

	private String getColumnWithType(String value) {
		if (isInteger(value)) {
			return value;
		}
		return "'" + value + "'";
	}

	private ResponseEntity<Serializable> insert(Map<String, String> mapJson) {
		String namesColumns = mapJson.keySet().stream().map(e -> "\"" + e.toString() + "\"").collect(Collectors.joining(","));
		String valuesColumns = mapJson.values().stream().map(e -> "?").collect(Collectors.joining(","));

		int rowAffected = jdbcTemplate.update(String.format(INSERT_TABLE, namesColumns, valuesColumns), mapJson.values().toArray());
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

	public boolean isInteger(String str) {
		if (str == null) {
			return false;
		}
		if (str.isEmpty()) {
			return false;
		}
		int i = 0;
		if (str.charAt(0) == '-') {
			if (str.length() == 1) {
				return false;
			}
			i = 1;
		}
		for (; i < str.length(); i++) {
			char c = str.charAt(i);
			if (c < '0' || c > '9') {
				return false;
			}
		}
		return true;
	}

	@PostMapping
	public ResponseEntity<Serializable> save(@RequestBody Map<String, String> mapJson) {
		log.info("ProjetoController.gravar()");

		for (String key : mapJson.keySet()) {
			if (key == "IDProjeto") {
				return update(mapJson);
			}
		}

		return insert(mapJson);
	}

	private ResponseEntity<Serializable> update(Map<String, String> mapJson) {
		StringBuilder sets = new StringBuilder();
		String primaryKey = null;
		for (String key : mapJson.keySet()) {
			if (key == "IDProjeto") {
				primaryKey = getColumnWithType(mapJson.get(key));
				continue;
			}
			sets.append("\"");
			sets.append(key);
			sets.append("\"");
			sets.append("=");
			sets.append(getColumnWithType(mapJson.get(key)));
			sets.append(", ");
		}
		sets.replace(sets.length() - 2, sets.length(), "");
		int rowAffected = jdbcTemplate.update(String.format(UPDATE_TABLE, sets.toString(), primaryKey));

		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}
}
