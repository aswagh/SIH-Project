
public class TrainerClass {
	private final int classid;
	private String year;
	private int divID;
	private int moduleID;
	private int professorID;
	private int sessionDuration;
	
	public TrainerClass(int classid) {
		this.classid = classid;
	}
	
	public void setDivId(int divId) {
		this.divID = divId;
	}
	
	public void setYear(String year) {
		this.year = year;
	}
	
	public void setSessionDuration(int sessionDuration) {
		this.sessionDuration = sessionDuration;
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
	
	public int getSessionDuration() {
		return this.sessionDuration;
	}
	
	
}
