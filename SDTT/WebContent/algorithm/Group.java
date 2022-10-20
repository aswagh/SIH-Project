

/**
 * A simple "group-of-students" abstraction. Defines the modules that the group is enrolled in.
 *
 */
public class Group {
	private final int groupId;
    private final String div;

    /**
     * Initialize Group
     * 
     * @param groupId
     * @param groupSize
     * @param moduleIds
     */
    public Group(String div, int groupId){
        this.div = div;
        this.groupId = groupId;
    }
    
    /**
     * Get groupId
     * 
     * @return groupId
     */
    public String getDiv(){
        return this.div;
    }
    
    public int getGroupId() {
    	return this.groupId;
    }
    
    /**
     * Get groupSize
     * 
     * @return groupSize
     */
    
}
