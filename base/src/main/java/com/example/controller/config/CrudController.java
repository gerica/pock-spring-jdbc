package com.example.controller.config;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.config.annotation.PrepareEntity;
import com.example.controller.wrapper.ResponseWrapper;
import com.example.util.AppParams;
import com.example.util.UtilAtributo;

@Component
public class CrudController {

	@Autowired
	protected AppParams appParams;

	public String DELETE_TABLE = "DELETE FROM public.\"%s\" WHERE \"%s\"=%s";
	public String INSERT_TABLE = "INSERT INTO public.\"%s\"(%s) VALUES (%s)";
	@Autowired
	public JdbcTemplate jdbcTemplate;
	public String SELECT_FROM_ALL = "select * from \"%s\";";
	public String SELECT_FROM_ID = "select * from \"%s\" WHERE \"%s\"=%s";
	public String UPDATE_TABLE = "UPDATE public.\"%s\" SET %s WHERE \"%s\"=%s";

	public CrudController() {
		super();
	}

	public void init() {
		if (appParams.getNameTable() == null) {
			throw new RuntimeException("Informe a tabela");
		}
	}

	@DeleteMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> delete(@PathVariable int id) {
		init();
		if (appParams.getNameTable() == null || appParams.getNamePrimaryKey() == null) {
			throw new RuntimeException("Informe o nome da tabela e o id.");
		}
		int rowsAffected = jdbcTemplate.update(getDeleteQuery(id));
		return ResponseEntity.ok().body(new ResponseWrapper(rowsAffected));
	}

	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		init();
		List<Map<String, Object>> result = jdbcTemplate.queryForList(getFethAllQuery(), new Object[] {});
		return ResponseEntity.ok().body(result);
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> fetchById(@PathVariable int id) {
		init();
		if (appParams.getNameTable() == null || appParams.getNamePrimaryKey() == null) {
			throw new RuntimeException("Informe o nome da tabela e o id.");
		}
		List<Map<String, Object>> result = jdbcTemplate.queryForList(getFethByIdQuery(id), new Object[] {});
		return ResponseEntity.ok().body(result);
	}

	@PostMapping
	@PrepareEntity
	public ResponseEntity<Serializable> save(@RequestBody Map<String, Object> mapJson) {
		init();
		for (String key : mapJson.keySet()) {
			if (key == appParams.getNamePrimaryKey() || key.equalsIgnoreCase(appParams.getNamePrimaryKey())) {
				return update(mapJson);
			}
		}

		return insert(mapJson);
	}

	@PostMapping("/saveAndReturnId")
	@PrepareEntity
	public ResponseEntity<Serializable> saveAndReturnId(@RequestBody Map<String, Object> entity) {
		init();
		Integer id = saveOrUpdate(entity);
		if (id == null) {
			id = (Integer) entity.get(appParams.getNamePrimaryKey());
		}
		return ResponseEntity.ok().body(new ResponseWrapper(id));
	}

	public void attrNameModule(Map<String, Object> entity) {
		String string = "module";
		for (Iterator<String> iterator = entity.keySet().iterator(); iterator.hasNext();) {
			String key = (String) iterator.next();
			if (key == string || string.equals(key)) {
				appParams.setNameModule(entity.get(key).toString());
				iterator.remove();
				break;
			}

		}
	}

	public String getDeleteQuery(Object id) {
		return String.format(DELETE_TABLE, appParams.getNameTable(), appParams.getNamePrimaryKey(), id);
	}

	public String getFethAllQuery() {
		return String.format(SELECT_FROM_ALL, appParams.getNameTable());
	}

	public String getFethByIdQuery(Object id) {
		return String.format(SELECT_FROM_ID, appParams.getNameTable(), appParams.getNamePrimaryKey(), id);
	}

	public ResponseEntity<Serializable> insert(Map<String, Object> mapJson) {
		String namesColumns = mapJson.keySet().stream().map(e -> "\"" + e.toString() + "\"").collect(Collectors.joining(","));
		String valuesColumns = mapJson.keySet().stream().map(e -> "?").collect(Collectors.joining(","));

		int rowAffected = jdbcTemplate.update(String.format(INSERT_TABLE, appParams.getNameTable(), namesColumns, valuesColumns), mapJson.values().toArray());
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

	public Integer insertReturnId(Map<String, Object> mapJson) {
//		String[] columnNames = mapJson.keySet().toArray(new String[mapJson.size()]);
		String namesColumns = mapJson.keySet().stream().map(e -> "\"" + e.toString() + "\"").collect(Collectors.joining(","));
		String valuesColumns = mapJson.keySet().stream().map(e -> "?").collect(Collectors.joining(","));
		String query = String.format(INSERT_TABLE, appParams.getNameTable(), namesColumns, valuesColumns);

		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
				PreparedStatement ps = connection.prepareStatement(query, new String[] { appParams.getNamePrimaryKey() });
				int count = 1;
				for (Object value : mapJson.values()) {
					ps.setObject(count++, value);

				}
				return ps;
			}
		}, keyHolder);
		return (Integer) keyHolder.getKey();
	}

	public Integer saveOrUpdate(Map<String, Object> entity) {
		if (entity != null) {
			for (String key : entity.keySet()) {
				if (key == appParams.getNamePrimaryKey() || key.equals(appParams.getNamePrimaryKey())) {
					update(entity);
					return null;
				}
			}
			return insertReturnId(entity);
		}
		return null;
	}

	protected ResponseEntity<Serializable> update(Map<String, Object> mapJson) {
		int rowAffected = jdbcTemplate.update(UtilAtributo.prepararUpdate(mapJson, UPDATE_TABLE, appParams.getNameTable(), appParams.getNamePrimaryKey()));
		return ResponseEntity.ok().body(new ResponseWrapper(rowAffected));
	}

	public AppParams getAppParams() {
		return appParams;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

}