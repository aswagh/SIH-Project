package com.abc.jsp;

public class TrainerClass {
	private final int classid;
	private String year;
	private int divID;
	private int moduleID;
	private int professorID;
	
	
	public TrainerClass(int classid) {
		this.classid = classid;
	}
	
	public void setDivId(int divId) {
		this.divID = divId;
	}
	
	public void setYear(String year) {
		this.year = year;
	}
	
	public void setModuleId(int moduleID) {
		this.moduleID = moduleID;
	}
	
	public void setProfessorId(int professorID) {
		this.professorID = professorID;
	}
	
	public int getProfessorId() {
		return this.professorID;
	}
	
	public int getDivId() {
		return this.divID;
	}
	
	public int getModuleId() {
		return this.moduleID;
	}
	
	public String getYear() {
		return this.year;
	}
	
	public int getClassId() {
		return this.classid;
	}
	
	
}
