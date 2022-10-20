
/**
 * Simple Professor abstraction.
 */
public class Professor {
    private final int professorId;
    private final String professorName;
    private final int loadHr;
    private int allocatedLoadHr;
    private int allocatedLabLoadHr;
    private int practLoadHr;

    /**
     * Initalize new Professor
     * 
     * @param professorId The ID for this professor
     * @param professorName The name of this professor
     */
    public Professor(int professorId, String professorName,int loadhr, int practLoadHr){
        this.professorId = professorId;
        this.professorName = professorName;
        this.loadHr = loadhr;
        this.practLoadHr = practLoadHr;
    }
    
    /**
     * Get professorId
     * 
     * @return professorId
     */
    public int getProfessorId(){
        return this.professorId;
    }
    
    public int getProfessorLoadHr(){
        return this.loadHr;
    }
    
    public int getProfessorLabLoadHr(){
        return this.practLoadHr;
    }
    
    public void setAllocatedLoadHr(int allocatedLoadHr) {
    	this.allocatedLoadHr = allocatedLoadHr;
    }
    
    public int getAllocatedLoadHr(){
        return this.allocatedLoadHr;
    }
    
    public int getAllocatedLabLoadHr(){
        return this.allocatedLabLoadHr;
    }
    
    public void setAllocatedLabLoadHr(int allocatedLabLoadHr){
    	this.allocatedLabLoadHr = allocatedLabLoadHr;
    }
    
    /**
     * Get professor's name
     * 
     * @return professorName
     */
    public String getProfessorName(){
        return this.professorName;
    }
}
