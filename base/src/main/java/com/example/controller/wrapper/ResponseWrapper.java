package com.example.controller.wrapper;

import java.io.Serializable;

public class ResponseWrapper implements Serializable {

	private static final long serialVersionUID = 1L;

	private String mensagem;

	private Object value;

	public ResponseWrapper() {
		this.mensagem = "Operação realizada com sucesso";
	}
	public ResponseWrapper(Object value) {
		this.mensagem = "Operação realizada com sucesso";
		this.value = value;
	}
	public ResponseWrapper(String mensagem, Object value) {
		super();
		this.mensagem = mensagem;
		this.value = value;
	}

	public String getMensagem() {
		return mensagem;
	}

	public Object getValue() {
		return value;
	}

	public void setMensagem(String mensagem) {
		this.mensagem = mensagem;
	}

	public void setValue(Object value) {
		this.value = value;
	}

};