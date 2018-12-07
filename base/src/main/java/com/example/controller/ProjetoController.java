package com.example.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.config.annotation.PrepareEntity;
import com.example.controller.wrapper.EntityWrapper;
import com.example.controller.wrapper.ResponseWrapper;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping(ProjetoController.URL)
public class ProjetoController extends CrudController {

	static final String URL = "/projeto";

	public ResponseEntity<Object> delete(@PathVariable int id) {
		appParams.setNameModule(appParams.getModuleProjetoDispendio());
		String query = String.format(DELETE_TABLE, appParams.getNameTable(), "ID" + appParams.getModuleProjeto(), id);
		jdbcTemplate.update(query);

		appParams.setNameModule(appParams.getModuleProjeto());
		return super.delete(id);
	}

	public ResponseEntity<Object> fetchById(@PathVariable int id) {
		List<Object> result = new ArrayList<Object>();

		List<Map<String, Object>> resultProjetos = jdbcTemplate.queryForList(getFethByIdQuery(id), new Object[] {});
		if (!resultProjetos.isEmpty()) {
			result.add(resultProjetos);
			Object idProjeto = null;

			for (Map<String, Object> map : resultProjetos) {
				idProjeto = map.get(appParams.getNamePrimaryKey());

				if (idProjeto != null) {
					appParams.setNameModule(appParams.getModuleProjetoDispendio());
					String select = String.format(SELECT_FROM_ID, appParams.getNameTable(), "ID" + appParams.getModuleProjeto(), idProjeto);
					List<Map<String, Object>> resultProjetosDispendio = jdbcTemplate.queryForList(select, new Object[] {});
					if (!resultProjetosDispendio.isEmpty()) {
						result.add(resultProjetosDispendio);
					}
					break;
				}
			}

		}
		return ResponseEntity.ok().body(new ResponseWrapper(result));
	}

	@PostMapping("/customSave")
	@PrepareEntity
	@Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRES_NEW)
	public ResponseEntity<Serializable> save(@RequestBody EntityWrapper wrapper) {
		Map<String, Object> entityParent = wrapper.getEntityParent();
		attrNameModule(entityParent);
		Integer idProjeto = saveOrUpdate(entityParent);

		List<Map<String, Object>> entitiesChilds = wrapper.getEntitiesChilds();

		if (entitiesChilds != null & !entitiesChilds.isEmpty()) {
			for (Map<String, Object> entity : entitiesChilds) {
				if (idProjeto != null) {
					entity.put(appParams.getNamePrimaryKey(), idProjeto);
				}
				attrNameModule(entity);
				saveOrUpdate(entity);
			}
		}

		return ResponseEntity.ok().body(new ResponseWrapper("sucesso"));
	}

}
