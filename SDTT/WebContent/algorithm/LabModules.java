
public class LabModules {

/**
 * Simple course module abstraction, which defines the Professors teaching the module.
 */
    private final int labModuleId;
    private final int sessionsPerWeek;
    private final String labModuleName;
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
    public LabModules(int labModuleId, String labModuleName,int sessionsPerWeek, int professorIds[], int sessionDuration){
        this.labModuleId = labModuleId;
        this.labModuleName = labModuleName;
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
    public int getLabModuleId(){
        return this.labModuleId;
    }
    
    public int getLabDuration(){
        return this.sessionDuration;
    }
    
    /**
     * Get module code
     * 
     * @return moduleCode
     */
    public String getlabModuleName(){
        return this.labModuleName;
    }
    
    /**
     * Get module name
     * 
     * @return moduleName
     */
    public int getSessionsPerWeek(){
        return this.sessionsPerWeek;
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
