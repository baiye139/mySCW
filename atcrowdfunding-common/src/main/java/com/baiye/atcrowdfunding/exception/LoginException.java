package com.baiye.atcrowdfunding.exception;

public class LoginException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public LoginException() {
		
	}
	public LoginException(String message) {
		super(message);
	}

}
