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
@RequestMapping(BaseController.URL)
public class BaseController {

	protected static final String URL = "/base";
	public String nameModule;
	public String namePrimaryKey;
	public String nameTable;

	private String DELETE_TABLE = "DELETE FROM public.\"%s\" WHERE \"%s\"=%s";

	private String INSERT_TABLE = "INSERT INTO public.\"%s\"(%s) VALUES (%s)";

	private String SELECT_FROM_ALL = "select * from \"%s\";";
	private String SELECT_FROM_ID = "select * from \"%s\" WHERE \"%s\"=%s";
	private String UPDATE_TABLE = "UPDATE public.\"%s\" SET %s WHERE \"%s\"=%s";
	@Autowired
	protected JdbcTemplate jdbcTemplate;

	public BaseController() {
		super();
	}

	@DeleteMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> delete(@PathVariable int id) {
		if (getNameTable() == null || getNamePrimaryKey() == null) {
			throw new RuntimeException("Informe o nome da tabela e o id.");
		}
		int rowsAffected = jdbcTemplate.update(String.format(DELETE_TABLE, getNameTable(), getNamePrimaryKey(), id));
		return ResponseEntity.ok().body(new ResponseWrapper(rowsAffected));
	}

	// @RequestHeader("table") String table
	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		if (getNameTable() == null) {
			throw new RuntimeException("Informe a tabela");
		}
		List<Map<String, Object>> result = jdbcTemplate.queryForList(String.format(SELECT_FROM_ALL, getNameTable()), new Object[] {});
		return ResponseEntity.ok().body(result);
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> fetchById(@PathVariable int id) {
		if (getNameTable() == null || getNamePrimaryKey() == null) {
			throw new RuntimeException("Informe o nome da tabela e o id.");
		}
		List<Map<String, Object>> result = jdbcTemplate.queryForList(String.format(SELECT_FROM_ID, getNameTable(), getNamePrimaryKey(), id), new Object[] {});
		return ResponseEntity.ok().body(new ResponseWrapper(result));
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

	@PostMapping
	@PrepareEntity
	public ResponseEntity<Serializable> save(@RequestBody Map<String, String> mapJson) {
		if (getNameTable() == null) {
			throw new RuntimeException("Informe a tabela");
		}
		for (String key : mapJson.keySet()) {
			if (key == "IDProjeto") {
				return update(mapJson);
			}
		}

		return insert(mapJson);
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

	private ResponseEntity<Serializable> insert(Map<String, String> mapJson) {
		String namesColumns = mapJson.keySet().stream().map(e -> "\"" + e.toString() + "\"").collect(Collectors.joining(","));
		String valuesColumns = mapJson.keySet().stream().map(e -> "?").collect(Collectors.joining(","));

		int rowAffected = jdbcTemplate.update(String.format(INSERT_TABLE, getNameTable(), namesColumns, valuesColumns), mapJson.values().toArray());
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

	private ResponseEntity<Serializable> update(Map<String, String> mapJson) {
		System.out.println(UtilAtributo.prepararUpdate(mapJson, UPDATE_TABLE, getNameTable(), getNamePrimaryKey()));
		int rowAffected = jdbcTemplate.update(UtilAtributo.prepararUpdate(mapJson, UPDATE_TABLE, getNameTable(), getNamePrimaryKey()));
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

}