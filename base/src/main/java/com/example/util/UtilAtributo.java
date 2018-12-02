package com.example.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Map;

public class UtilAtributo {

	public static boolean isInteger(String str) {
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

	public static String prepararUpdate(Map<String, String> mapJson, String query, String nameKey) {
		StringBuilder sets = new StringBuilder();
		Object primaryKey = null;
		for (String key : mapJson.keySet()) {
			if (key == nameKey) {
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
		return String.format(query, sets.toString(), primaryKey);
	}

	/**
	 * Para os campos do tipo varchar é necessário adicionar aspas simples
	 * 
	 * @param value
	 * @return
	 */
	private static Object getColumnWithType(Object value) {
		if (value instanceof Integer) {
			return value;
		}
		if (UtilAtributo.isInteger(value.toString())) {
			return value;
		}
		return "'" + value + "'";
	}

	public static LocalDate convertStringToDate(String inDate) {

		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.ENGLISH);

		try {
			return LocalDate.parse(inDate, inputFormatter);
		} catch (Exception pe) {
			return null;
		}
	}
}