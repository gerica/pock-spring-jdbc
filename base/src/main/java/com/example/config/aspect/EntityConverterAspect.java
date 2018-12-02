package com.example.config.aspect;

import java.time.LocalDate;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

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
		// execute original method with new args
		return pjp.proceed(args);
	}

}
