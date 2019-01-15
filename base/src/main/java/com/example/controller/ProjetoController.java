package com.example.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
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
import com.example.controller.config.CrudController;
import com.example.controller.wrapper.EntityWrapper;
import com.example.controller.wrapper.ResponseWrapper;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(ProjetoController.URL)
public class ProjetoController {

	static final String URL = "/projeto";

	@Value("${app.module.projeto}")
	public String moduleProjeto;

	@Value("${app.module.projeto.dispendio}")
	public String moduleProjetoDispendio;

	@Autowired
	private CrudController crudController;

	@PostMapping()
	@PrepareEntity
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRES_NEW)
	public ResponseEntity<Serializable> save(@RequestBody EntityWrapper wrapper) {
		Map<String, Object> entityParent = wrapper.getEntityParent();
		crudController.attrNameModule(entityParent);
		Integer idProjeto = crudController.saveOrUpdate(entityParent);

		List<Map<String, Object>> entitiesChilds = wrapper.getEntitiesChilds();

		if (entitiesChilds != null & !entitiesChilds.isEmpty()) {
			for (Map<String, Object> entity : entitiesChilds) {
				if (idProjeto != null) {
					entity.put(crudController.getAppParams().getNamePrimaryKey(), idProjeto);
				}
				crudController.attrNameModule(entity);
				crudController.saveOrUpdate(entity);
			}
		}

		return ResponseEntity.ok().body(new ResponseWrapper("sucesso"));
	}

	@DeleteMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> delete(@PathVariable int id) {
		crudController.getAppParams().setNameModule(moduleProjetoDispendio);
		String query = String.format(crudController.DELETE_TABLE, crudController.getAppParams().getNameTable(), "ID" + moduleProjeto, id);
		crudController.getJdbcTemplate().update(query);

		crudController.getAppParams().setNameModule(moduleProjeto);
		return crudController.delete(id);
	}

	@GetMapping()
	public ResponseEntity<List<Map<String, Object>>> fetchAll() {
		return crudController.fetchAll();
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Object> fetchById(@PathVariable int id) {
		List<Object> result = new ArrayList<Object>();

		List<Map<String, Object>> resultProjetos = crudController.getJdbcTemplate().queryForList(crudController.getFethByIdQuery(id), new Object[] {});
		if (!resultProjetos.isEmpty()) {
			result.add(resultProjetos);
			Object idProjeto = null;

			for (Map<String, Object> map : resultProjetos) {
				idProjeto = map.get(crudController.getAppParams().getNamePrimaryKey());

				if (idProjeto != null) {
					crudController.getAppParams().setNameModule(moduleProjetoDispendio);
					String select = String.format(crudController.SELECT_FROM_ID, crudController.getAppParams().getNameTable(), "ID" + moduleProjeto, idProjeto);
					List<Map<String, Object>> resultProjetosDispendio = crudController.getJdbcTemplate().queryForList(select, new Object[] {});
					if (!resultProjetosDispendio.isEmpty()) {
						result.add(resultProjetosDispendio);
					}
					break;
				}
			}

		}
		return ResponseEntity.ok().body(new ResponseWrapper(result));
	}

}
