

/**
 * Simple Lab abstraction -- used to store the lab capacity and compare against the student Group's size.
 */
public class Lab {
	private final int labId;
	private final String labNumber;
	private final int capacity;

	/**
	 * Initialize new lab
	 * 
	 * @param labId
	 *            The ID for this classlab
	 * @param labNumber
	 *            The lab number
	 * @param capacity
	 *            The lab capacity
	 */
	public Lab(int labId, String labNumber, int capacity) {
		this.labId = labId;
		this.labNumber = labNumber;
		this.capacity = capacity;
	}

	/**
	 * Return labId
	 * 
	 * @return labId
	 */
	public int getLabId() {
		return this.labId;
	}

	/**
	 * Return lab number
	 * 
	 * @return labNumber
	 */
	public String getLabNumber() {
		return this.labNumber;
	}

	/**
	 * Return lab capacity
	 * 
	 * @return capacity
	 */
	public int getLabCapacity() {
		return this.capacity;
	}
}