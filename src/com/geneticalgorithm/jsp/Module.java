package com.abc.jsp;

/**
 * Simple course module abstraction, which defines the Professors teaching the module.
 */
public class Module {
    private final int moduleId;
    private final int sessionsPerWeek;
    private final String moduleCode;
    private final int professorIds[];
    private final int sessionDuration;
    
    /**
     * Initialize new Module
     * 
     * @param moduleId
     * @param moduleCode
     * @param module
     * @param professorIds
     */
    public Module(int moduleId, String moduleCode, int sessionsPerWeek, int professorIds[], int sessionDuration){
        this.moduleId = moduleId;
        this.moduleCode = moduleCode;
        //this.module = module;
        this.professorIds = professorIds;
        this.sessionsPerWeek = sessionsPerWeek;
        this.sessionDuration = sessionDuration;
    }
    
    /**
     * Get moduleId
     * 
     * @return moduleId
     */
    public int getModuleId(){
        return this.moduleId;
    }
    
    /**
     * Get module code
     * 
     * @return moduleCode
     */
    public String getModuleCode(){
        return this.moduleCode;
    }
    
    /**
     * Get module name
     * 
     * @return moduleName
     */
    public int getSessionsPerWeek(){
        return this.sessionsPerWeek;
    }
    
    public int getSessionDuration(){
        return this.sessionDuration;
    }
    
    public int[] getProfessors() {
    	return this.professorIds;
    }
    
    /**
     * Get random professor Id
     * 
     * @return professorId
     */
    public int getRandomProfessorId(){
        int professorId = professorIds[(int) (professorIds.length * Math.random())];
        return professorId;
    }
}
