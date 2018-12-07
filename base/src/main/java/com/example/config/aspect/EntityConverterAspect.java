package com.example.config.aspect;

import java.time.LocalDate;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import com.example.controller.wrapper.EntityWrapper;
import com.example.util.UtilAtributo;

@Aspect
@Component
public class EntityConverterAspect {

//	@Before("@annotation(com.example.config.annotation.PrepareEntity)")
//	public void convertStringToDateBefore(JoinPoint joinPoint) {
//		System.out.println("***** Starting: " + joinPoint.getSignature().getName() + " *****");
//	}

	@Around("@annotation(com.example.config.annotation.PrepareEntity)")
	public Object convertStringToDate(final ProceedingJoinPoint pjp) throws Throwable {
		Object[] args = pjp.getArgs();

		// Find annotated argument
		for (int i = 0; i < args.length; i++) {
			Object raw = args[i];
			if (raw instanceof Map) {
				checkMap((Map) raw);
//				for (Object key : ((Map) raw).keySet()) {
//					Object value = ((Map) raw).get(key);
//					if (value instanceof String) {
//						LocalDate ld = UtilAtributo.convertStringToDate((String) value);
//						if (ld != null) {
//							((Map) raw).put(key, ld);
//						} else if (UtilAtributo.isInteger((String) value)) {
//							((Map) raw).put(key, Integer.parseInt((String) value));
//						}
//					}
//				}
			} else if (raw instanceof EntityWrapper) {
				EntityWrapper entityWrapper = (EntityWrapper) raw;
				if (entityWrapper.getEntityParent() != null) {
					checkMap(entityWrapper.getEntityParent());
				}
				if (entityWrapper.getEntitiesChilds() != null) {
					for (Map<String, Object> entity : entityWrapper.getEntitiesChilds()) {
						checkMap(entity);

					}
				}
//				if (entityWrapper.getEntity1() != null) {
//					checkMap(entityWrapper.getEntity1());
//				}
//				if (entityWrapper.getEntity2() != null) {
//					checkMap(entityWrapper.getEntity2());
//				}
			}
		}
		// execute original method with new args
		return pjp.proceed(args);
	}

	private void checkMap(Map raw) {
		for (Object key : ((Map) raw).keySet()) {
			Object value = ((Map) raw).get(key);
			if (value instanceof String) {
				LocalDate ld = UtilAtributo.convertStringToDate((String) value);
				if (ld != null) {
					((Map) raw).put(key, ld);
				} else if (UtilAtributo.isInteger((String) value)) {
					((Map) raw).put(key, Integer.parseInt((String) value));
				}
			}
		}
	}

}
