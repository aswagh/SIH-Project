package com.abc.jsp;

/**
 * Simple Professor abstraction.
 */
public class Professor {
    private final int professorId;
    private final String professorName;
    private final int loadHr;
    private int allocatedLoadHr;

    /**
     * Initalize new Professor
     * 
     * @param professorId The ID for this professor
     * @param professorName The name of this professor
     */
    public Professor(int professorId, String professorName,int loadhr){
        this.professorId = professorId;
        this.professorName = professorName;
        this.loadHr = loadhr;
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
    
    public void setAllocatedLoadHr(int allocatedLoadHr) {
    	this.allocatedLoadHr = allocatedLoadHr;
    }
    
    public int getAllocatedLoadHr(){
        return this.allocatedLoadHr;
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
