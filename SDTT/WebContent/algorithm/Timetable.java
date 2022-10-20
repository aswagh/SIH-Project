

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

/**
 * Timetable is the main evaluation class for the class scheduler GA.
 * 
 * A timetable represents a potential solution in human-readable form, unlike an
 * Individual or a chromosome. This timetable class, then, can read a chromosome
 * and develop a timetable from it, and ultimately can evaluate the timetable
 * for its fitness and number of scheduling clashes.
 * 
 * The most important methods in this class are createClasses and calcClashes.
 * 
 * The createClasses method accepts an Individual (really, a chromosome),
 * unpacks its chromosome, and creates Class objects from the genetic
 * information. Class objects are lightweight; they're just containers for
 * information with getters and setters, but it's more convenient to work with
 * them than with the chromosome directly.
 * 
 * The calcClashes method is used by GeneticAlgorithm.calcFitness, and requires
 * that createClasses has been run first. calcClashes looks at the Class objects
 * created by createClasses, and figures out how many hard constraints have been
 * violated.
 * 
 */
public class Timetable {
	private final HashMap<Integer, Room> rooms;
	private final HashMap<Integer, Lab> labs;
	private final HashMap<Integer, Professor> professors;
	private final HashMap<String, HashMap<Integer, Module>>yearModules;
	private final HashMap<Integer, Module> modules;
	private final HashMap<String, HashMap<Integer, Group>> yearDiv;
	private final HashMap<String, HashMap<Integer, LabModules>>yearlabModules;
	private final HashMap<Integer, LabModules>labModules;
	private final HashMap<Integer, Group>groups;
	private final HashMap<Integer, Timeslot> timeslots;
	private Class classes[];
	private TrainerClass trainerClass[];
	private String duration,brk;

	private int numClasses = 0;

	/**
	 * Initialize new Timetable
	 */
	public Timetable() {
		this.rooms = new HashMap<Integer, Room>();
		this.labs = new HashMap<Integer, Lab>();
		this.professors = new HashMap<Integer, Professor>();
		this.yearModules = new HashMap<String, HashMap<Integer, Module>>();
		this.modules = new HashMap<Integer, Module>();
		this.yearDiv = new HashMap<String, HashMap<Integer, Group>>();
		this.groups = new HashMap<Integer, Group>();
		this.timeslots = new HashMap<Integer, Timeslot>();
		this.labModules = new HashMap<Integer, LabModules>();
		this.yearlabModules = new HashMap<String, HashMap<Integer, LabModules>>();
	}

	/**
	 * "Clone" a timetable. We use this before evaluating a timetable so we have
	 * a unique container for each set of classes created by "createClasses".
	 * Truthfully, that's not entirely necessary (no big deal if we wipe out and
	 * reuse the .classes property here), but Chapter 6 discusses
	 * multi-threading for fitness calculations, and in order to do that we need
	 * separate objects so that one thread doesn't step on another thread's
	 * toes. So this constructor isn't _entirely_ necessary for Chapter 5, but
	 * you'll see it in action in Chapter 6.
	 * 
	 * @param cloneable
	 */
	public Timetable(Timetable cloneable) {
		this.rooms = cloneable.getRooms();
		this.labs = cloneable.getLabs();
		this.professors = cloneable.getProfessors();
		this.modules = cloneable.getModules();
		this.yearDiv = cloneable.getYearDiv();
		this.groups = cloneable.getGroups();
		this.timeslots = cloneable.getTimeslots();
		this.yearModules = cloneable.getYearModulePair();
		this.yearlabModules = cloneable.getyearlabModules();
		this.labModules = cloneable.getLabModules();
	}

	private HashMap<Integer, Group> getGroups() {
		return this.groups;
	}
	
	private HashMap<String, HashMap<Integer, Group>> getYearDiv() {
		return this.yearDiv;
	}
	
	private HashMap<String, HashMap<Integer, LabModules>> getyearlabModules() {
		return this.yearlabModules;
	}

	private HashMap<Integer, Timeslot> getTimeslots() {
		return this.timeslots;
	}

	private HashMap<Integer, Module> getModules() {
		return this.modules;
	}

	private HashMap<Integer, Professor> getProfessors() {
		return this.professors;
	}
	
	private HashMap<String, HashMap<Integer, Module>> getYearModulePair() {
		return this.yearModules;
	}
	
	private HashMap<Integer, LabModules> getLabModules() {
		return this.labModules;
	}

	/**
	 * Add new room
	 * 
	 * @param roomId
	 * @param roomName
	 * @param capacity
	 */
	public void addRoom(int roomId, String roomName, int capacity) {
		this.rooms.put(roomId, new Room(roomId, roomName, capacity));
	}

	/**
	 * Add new professor
	 * 
	 * @param professorId
	 * @param professorName
	 */
	public void addProfessor(int professorId, String professorName, int loadhr, int pratLoad) {
		this.professors.put(professorId, new Professor(professorId, professorName, loadhr, pratLoad));
	}

	/**
	 * Add new module
	 * 
	 * @param moduleId
	 * @param moduleCode
	 * @param module
	 * @param professorIds
	 */
	public void addModule(String key, int moduleId, String moduleCode,int sessionsPerWeek, int professorIds[], int sessionDuration) {
		HashMap<Integer, Module> module = this.yearModules.get(key);
		if(module==null)
		{
			module = new HashMap<Integer, Module>();
			this.yearModules.put(key, module);
		}
		module.put(moduleId, new Module(moduleId, moduleCode, sessionsPerWeek, professorIds, sessionDuration));
	}
	
	public void add(int moduleId, String moduleCode, String module, int sessionsPerWeek, int professorIds[], int sessionDuration) {
		this.modules.put(moduleId, new Module(moduleId, moduleCode, sessionsPerWeek, professorIds, sessionDuration));
	}
	
	
	public void addLab(int labId, String labName, int capacity) {
		this.labs.put(labId, new Lab(labId, labName, capacity));
	}
	
	

	/**
	 * Add new group
	 * 
	 * @param groupId
	 * @param groupSize
	 * @param moduleIds
	 */
	
	public void addDivision(String yyear,int id, String div) {
		HashMap<Integer, Group> grp = this.yearDiv.get(yyear);
		if(grp==null)
		{
			grp = new HashMap<Integer, Group>();
			this.yearDiv.put(yyear, grp);
		}
		grp.put(id,new Group(div,id));
	}

	/**
	 * Add new timeslot
	 * 
	 * @param timeslotId
	 * @param timeslot
	 */
	public void addTimeslot(int timeslotId, String timeslot) {
		this.timeslots.put(timeslotId, new Timeslot(timeslotId, timeslot));
	}
	
	public void addLabModule(String yyear, int id, String labModuleName, int sessionPerWeek, int professorIds[], int sessionDuration) {
		HashMap<Integer, LabModules> labModule = this.yearlabModules.get(yyear);
		if(labModule==null)
		{
			labModule = new HashMap<Integer, LabModules>();
			this.yearlabModules.put(yyear, labModule);
		}
		labModule.put(id, new LabModules(id, labModuleName, sessionPerWeek, professorIds, sessionDuration));
	}
	
	public void setTotalTimeDuration(String duration,String brk,int workDays)
	{
		this.brk = brk;
		this.duration = duration;
		String tt[] = duration.trim().split("-") ;
		
		String daysArray[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
		int startTime = Integer.parseInt(tt[0]);
		int endTime = Integer.parseInt(tt[1]);
		
		String BreakSplit[] = brk.trim().split("-") ;
		int bstartTime = Integer.parseInt(BreakSplit[0]);
		int bendTime = Integer.parseInt(BreakSplit[1]);
		int id = 1;
		for(int days = 0;days<workDays;days++) {
			for(int i = startTime ; i < endTime ; i++)
			{
				int j = i+1;
				String time = daysArray[days]+" "+Integer.toString(i)+"-"+Integer.toString(j);
				if(i!=bstartTime) {
					this.addTimeslot(id, time);
					//System.out.println(id+" "+time);
					id++;
				}
				
			}
		}
	}

	
	/**
	 * Get room from roomId
	 * 
	 * @param roomId
	 * @return room
	 */
	public Room getRoom(int roomId) {
		if (!this.rooms.containsKey(roomId)) {
			System.out.println("Rooms doesn't contain key " + roomId);
		}
		return (Room) this.rooms.get(roomId);
	}

	public HashMap<Integer, Room> getRooms() {
		return this.rooms;
	}
	
	public HashMap<Integer, Lab> getLabs() {
		return this.labs;
	}
	
	/*public HashMap<Integer, LabModules> getLabModules() {
		return this.labModules;
	}*/

	/**
	 * Get random room
	 * 
	 * @return room
	 */
	public int getRandomRoom() {
		Object[] roomsArray = this.rooms.values().toArray();
		Room room = (Room) roomsArray[(int) (roomsArray.length * Math.random())];
		int rrooms = room.getRoomId();
		return rrooms;
	}
	
	public int[] getRandomLabsRoom2() {
		Object[] labsArray = this.labs.values().toArray();
		Set<Integer> store = new HashSet<>();
		int counter = 4;
		int lrooms[] = new int[4];
		Lab labRooms = (Lab) labsArray[(int) (labsArray.length * Math.random())];
		store.add(labRooms.getLabId());
		lrooms[0] = labRooms.getLabId();
		for(int i=0;i<3;i++) {
			labRooms = (Lab) labsArray[(int) (labsArray.length * Math.random())];
			if(store.add(labRooms.getLabId())==false)
				i--;
			else
				lrooms[i+1] = labRooms.getLabId();
		}
		
		return lrooms;
	}
	
	public int getRandomLabsRoom() {
		Object[] labsArray = this.labs.values().toArray();
		Lab labRooms = (Lab) labsArray[(int) (labsArray.length * Math.random())];
		int lroom = labRooms.getLabId();
		
		return lroom;
	}

	/**
	 * Get professor from professorId
	 * 
	 * @param professorId
	 * @return professor
	 */
	public Professor getProfessor(int professorId) {
		return (Professor) this.professors.get(professorId);
	}
	
	

	/**
	 * Get module from moduleId
	 * 
	 * @param moduleId
	 * @return module
	 */
	
	public Group getGroup(int groupId) {
		return (Group) this.groups.get(groupId);
	}
	
	public Module getModule(int moduleId) {
		return (Module) this.modules.get(moduleId);
	}
	
	public Group getLab(int labId) {
		return (Group) this.groups.get(labId);
	}

	/**
	 * Get all student groups
	 * 
	 * @return array of groups
	 */
	public Group[] getGroupsAsArray() {
		return (Group[]) this.groups.values().toArray(new Group[this.groups.size()]);
	}

	/**
	 * Get timeslot by timeslotId
	 * 
	 * @param timeslotId
	 * @return timeslot
	 */
	public Timeslot getTimeslot(int timeslotId) {
		return (Timeslot) this.timeslots.get(timeslotId);
	}
	
	public HashMap<Integer,Module> getYear(String yyear) {
		return (HashMap<Integer,Module>) this.yearModules.get(yyear);
	}
	
	public HashMap<Integer,Group> getYearG(String yyear) {
		return (HashMap<Integer,Group>) this.yearDiv.get(yyear);
	}
	
	public HashMap<Integer, LabModules> getYearL(String yyear) {
		return (HashMap<Integer, LabModules>) this.yearlabModules.get(yyear);
	}

	/**
	 * Get random timeslotId
	 * 
	 * @return timeslot
	 */
	public int getRandomTimeslot() {
		Object[] timeslotArray = this.timeslots.values().toArray();
		Timeslot timeslot = (Timeslot) timeslotArray[(int) (timeslotArray.length * Math.random())];
		int slot = timeslot.getTimeslotId();
		return slot;
	}
	
	public int[] getRandomLabTimeslot() {
		Object[] timeslotArray = this.timeslots.values().toArray();
		int position = (int) (timeslotArray.length * Math.random());
		while(position != timeslotArray.length)
			position = (int) (timeslotArray.length * Math.random());
		Timeslot timeslot1 = (Timeslot) timeslotArray[position];
		Timeslot timeslot2 = (Timeslot) timeslotArray[position+1];
		
		int slots[] = { timeslot1.getTimeslotId() , timeslot2.getTimeslotId() };
		return slots;
	}
	
	public void createTrainerClasses(IndividualTrainer individual) {
		TrainerClass trainerClasses[] = new TrainerClass[this.getNumTrainerDivMappings()];
		
		int chromosome[] = individual.getChromosome();
		int chromosomePos = 0;
		int trainerClassIndex = 0;
		
		for(String yyear:this.getYearArray()) {
			for(Group div:this.getDivArray(yyear)) {
				for(Module subs:this.getModuleArray(yyear)) {
					int groupId = div.getGroupId(); //identified division
					int subId = subs.getModuleId(); //identified subject
					int duration = subs.getSessionDuration();
					//int proffId = subs.getRandomProfessorId(); //allocated random professor to that subject
					
					trainerClasses[trainerClassIndex] = new TrainerClass(trainerClassIndex);
					
					trainerClasses[trainerClassIndex].setYear(yyear);
					
					trainerClasses[trainerClassIndex].setDivId(groupId);
					
					trainerClasses[trainerClassIndex].setModuleId(subId);
					
					trainerClasses[trainerClassIndex].setSessionDuration(duration);
					
					trainerClasses[trainerClassIndex].setProfessorId(chromosome[chromosomePos]);
					chromosomePos++;
					
					trainerClassIndex++;
				}
				for(LabModules labsubs:this.getLabModuleArray(yyear)) {
					int groupId = div.getGroupId(); //identified division
					int subId = labsubs.getLabModuleId(); //identified subject
					int duration = labsubs.getLabDuration();
					
					trainerClasses[trainerClassIndex] = new TrainerClass(trainerClassIndex);
					
					trainerClasses[trainerClassIndex].setYear(yyear);
					
					trainerClasses[trainerClassIndex].setDivId(groupId);
					
					trainerClasses[trainerClassIndex].setModuleId(subId);
					
					trainerClasses[trainerClassIndex].setSessionDuration(duration);
					
					trainerClasses[trainerClassIndex].setProfessorId(chromosome[chromosomePos]);
					chromosomePos++;
					
					trainerClassIndex++;
				}
			}
		}
			
		this.trainerClass = trainerClasses;
	}
	
	
	public int calcTrainerClashes() {
		int clashes = 0;
		
		for(TrainerClass classA: this.getTrainerClasses()) {
			int trainerLoadHr;
			int professorId = classA.getProfessorId();
			int subPerWeekSessionCount;
			int subAsessionDuration;
			if(classA.getSessionDuration() == 1) {
				trainerLoadHr = this.getProfessor(classA.getProfessorId()).getProfessorLoadHr();
				subPerWeekSessionCount = this.yearModules.get(classA.getYear()).get(classA.getModuleId()).getSessionsPerWeek();
				subAsessionDuration = this.yearModules.get(classA.getYear()).get(classA.getModuleId()).getSessionDuration();
			}
			else {
				trainerLoadHr = this.getProfessor(classA.getProfessorId()).getProfessorLabLoadHr();
				subPerWeekSessionCount = this.yearlabModules.get(classA.getYear()).get(classA.getModuleId()).getSessionsPerWeek();
				subAsessionDuration = this.yearlabModules.get(classA.getYear()).get(classA.getModuleId()).getLabDuration();
			}
			
			int totalLoadA = subPerWeekSessionCount*subAsessionDuration;
			int totalLoadFinal = totalLoadA;
			
			//int subPerWeekSessionCount = this.getModule(classA.getModuleId()).getSessionsPerWeek();
			
			for(TrainerClass classB: this.getTrainerClasses()) {
				if(classB.getClassId() != classA.getClassId() && classA.getProfessorId() == classB.getProfessorId() && classA.getSessionDuration() == classB.getSessionDuration()) {
					int sessionsB;
					int subBsessionDuration;
					if(classB.getSessionDuration() == 1) {
						sessionsB = this.yearModules.get(classB.getYear()).get(classB.getModuleId()).getSessionsPerWeek();
						subBsessionDuration = this.yearModules.get(classB.getYear()).get(classB.getModuleId()).getSessionDuration();
					}
					else {
						sessionsB = this.yearlabModules.get(classB.getYear()).get(classB.getModuleId()).getSessionsPerWeek();
						subBsessionDuration = this.yearlabModules.get(classB.getYear()).get(classB.getModuleId()).getLabDuration();
					}
					subPerWeekSessionCount += sessionsB;
					int totalLoadB = sessionsB*subBsessionDuration;
					totalLoadFinal += totalLoadB;
				}
			}
			
			Professor p = this.getProfessor(classA.getProfessorId());
			if(subAsessionDuration == 1)
				p.setAllocatedLoadHr(totalLoadFinal);
			else
				p.setAllocatedLabLoadHr(totalLoadFinal);
			
			if(totalLoadFinal > trainerLoadHr+1 || trainerLoadHr-1 > totalLoadFinal) {
				clashes++;
			}
		}
		
		return clashes;
	}
	
	public int calcClashes(Timetable timetable,Individual individual) {
		int clashes = 0;
		int dynamicClash = 0;
		
		for(Class classA: this.classes ) {
			int dynamismCtr = 1;
			//int sessionDuration = this.getModule(classA.getModuleId()).getSessionDuration(); *******Error Exists here Null pointer exception
			int professorId = classA.getProfessorId();
			int roomIds = classA.getRoomId();
			int moduleIdA = classA.getModuleId();
			int timeslotId = classA.getTimeslotId();
			String yr = classA.getYear();
			int professorIDS[] = timetable.yearModules.get(yr).get(moduleIdA).getProfessors();
 			
			for(Class classB: this.classes) {
				int hashidA = classA.getTimeslotId();
				int hashidB = classB.getTimeslotId();
				int timeSlotArrayA[] = individual.getTimeslots(hashidA);
				int timeSlotArrayB[] = individual.getTimeslots(hashidB);
				boolean timesFlag = false;
				for(int i=0;i<timeSlotArrayA.length;i++) {
					for(int j=0;j<timeSlotArrayB.length;j++) {
						if(timeSlotArrayA[i] == timeSlotArrayB[j])
							timesFlag = true;
					}
				}
				
				if(classA.getClassId() != classB.getClassId() && ((timesFlag && classA.getRoomId() == classB.getRoomId()) || (timesFlag && classA.getProfessorId() == classB.getProfessorId()) || (timesFlag && classA.getGroupId() == classB.getGroupId()))) {
					//System.out.println(classA.getTimeslotId() + " " + classA.getRoomId());
					clashes++;
					break;
				}
				
			}
			
			for(int profid:professorIDS) {
				if(profid != professorId) {
					for(Class classB: this.classes) {
						int hashidA = classA.getTimeslotId();
						int hashidB = classB.getTimeslotId();
						int timeSlotArrayA[] = individual.getTimeslots(hashidA);
						int timeSlotArrayB[] = individual.getTimeslots(hashidB);
						boolean timesFlag = false;
						for(int i=0;i<timeSlotArrayA.length;i++) {
							for(int j=0;j<timeSlotArrayB.length;j++) {
								if(timeSlotArrayA[i] == timeSlotArrayB[j])
									timesFlag = true;
							}
						}
						if(classA.getClassId() != classB.getClassId() && classB.getProfessorId() == profid && timesFlag) {
							//System.out.println(classA.getTimeslotId() + " " + classA.getRoomId());
							dynamismCtr++;
							break;
						}
						
					}
				}
			}
			
			if(professorIDS.length == dynamismCtr) {
				clashes++;
			}
			
		}
		
		
		return clashes;
	}
	
	public int calcAfterClashes(Timetable timetable) {
		int clashes = 0;
		int dynamicClash = 0;
		
		for(Class classA: this.classes ) {
			//int sessionDuration = this.getModule(classA.getModuleId()).getSessionDuration(); *******Error Exists here Null pointer exception
			int professorId = classA.getProfessorId();
			int roomIds = classA.getRoomId();
			int moduleIdA = classA.getModuleId();
			int timeslotId = classA.getTimeslotId();
			String yr = classA.getYear();
 			
			for(Class classB: this.classes) {
				if(classA.getClassId() != classB.getClassId() && ((classA.getTimeslotId() == classB.getTimeslotId() && classA.getRoomId() == classB.getRoomId()) || (classA.getTimeslotId() == classB.getTimeslotId() && classA.getProfessorId() == classB.getProfessorId()) || (classA.getTimeslotId() == classB.getTimeslotId() && classA.getGroupId() == classB.getGroupId()))) {
					//System.out.println(classA.getTimeslotId() + " " + classA.getRoomId());
					clashes++;
					break;
				}
				
				
			}
			
		}
		
		
		return clashes;
	}
	
	public void createAlternateTTclasses(Timetable timetable, int id, String day) {
		for(Class classA: this.classes ) {
			int dynamismCtr = 1;
			//int sessionDuration = this.getModule(classA.getModuleId()).getSessionDuration(); *******Error Exists here Null pointer exception
			int professorId = classA.getProfessorId();
			
			if(professorId == id) {
				
				int roomIds = classA.getRoomId();
				int moduleIdA = classA.getModuleId();
				int timeslotId = classA.getTimeslotId();
				String timeslotA = timetable.getTimeslot(classA.getTimeslotId()).getTimeslot();
				String yr = classA.getYear();
				int professorIDS[] = timetable.yearModules.get(yr).get(moduleIdA).getProfessors();
				if(timeslotA.startsWith(day)) {
					for(int profid:professorIDS) {
						if(profid != professorId) {
							boolean flag = false;
							for(Class classB: this.classes) {
								String timeslotB = timetable.getTimeslot(classB.getTimeslotId()).getTimeslot();
								if(classA.getClassId() != classB.getClassId() && classB.getProfessorId() == profid && classB.getTimeslotId() == timeslotId) {
									//System.out.println(classA.getTimeslotId() + " " + classA.getRoomId());
									flag = true; //means we cannot assign this professor. he already has a lecture
									break;
								}								
							}
							if(flag == false)
								classA.setProfessorId(profid);
						}
					}
				}
				
			
			}
			
		}
	}
	/**
	 * Get classes
	 * 
	 * @return classes
	 */
	public Class[] getClasses() {
		return this.classes;
	}
	
	public TrainerClass[] getTrainerClasses() {
		if(this.trainerClass == null) {
			System.out.println("Hiii i m sad");
		}
		return this.trainerClass;
	}
	
	public int getNumTrainerDivMappings()
	{
		int numTrainerDivMappings=0;
		
		String yearArray[] = this.getYearArray();
		
		for(String yyear:yearArray) {
			HashMap<Integer, Group> yrDivs = this.yearDiv.get(yyear);
			HashMap<Integer, Module> yrModules = this.yearModules.get(yyear);
			HashMap<Integer, LabModules>labSubs = this.yearlabModules.get(yyear);
			for(int div : yrDivs.keySet()) {
				for(int module : yrModules.keySet()) {
					numTrainerDivMappings++;
				}
				for(int module : labSubs.keySet()) {
					numTrainerDivMappings++;
				}
			}
		}
		
		return numTrainerDivMappings;
	}
	
	public void createClasses(Individual individual, Timetable timetable) {
		Class classes[] = new Class[this.getNumClasses()];
		
		//get individual chromosomes
		int chromosome[] = individual.getChromosome();
		int chromosomePos = 0;
		int classIndex = 0;
		
		for(String yyear:this.getYearArray()) {
			for(Group div:this.getDivArray(yyear)) {
				for(Module subs:this.getModuleArray(yyear)) {
					int sessionsPerWeek = subs.getSessionsPerWeek();
					int groupId = div.getGroupId();
					int moduleId = subs.getModuleId();
					//****CHECK THIS NEATLY
					int professorId = timetable.getTrainerClass(moduleId,groupId,yyear).getProfessorId();
					
					for(int i=0;i<sessionsPerWeek;i++) {
						classes[classIndex] = new Class(classIndex,groupId,moduleId,professorId,yyear);
						//as we have stored hashmap ids at chromosome position we have to fetch value of that id and then insert it into class
						classes[classIndex].addTimeslot(chromosome[chromosomePos]);
						chromosomePos++;
						
						classes[classIndex].setRoomId(chromosome[chromosomePos]);
						chromosomePos++;
						
						classIndex++;
					}
				}
				for(LabModules subs:this.getLabModuleArray(yyear)) {
					int sessionsPerWeek = subs.getSessionsPerWeek();
					int groupId = div.getGroupId();
					int moduleId = subs.getLabModuleId();
					//****CHECK THIS NEATLY
					int professorId = timetable.getTrainerClass(moduleId,groupId,yyear).getProfessorId();
					
					for(int i=0;i<sessionsPerWeek;i++) {
						classes[classIndex] = new Class(classIndex,groupId,moduleId,professorId,yyear);
						//as we have stored hashmap ids at chromosome position we have to fetch value of that id and then insert it into class
						classes[classIndex].addTimeslot(chromosome[chromosomePos]);
						chromosomePos++;
						
						classes[classIndex].setRoomId(chromosome[chromosomePos]);
						chromosomePos++;
						
						classIndex++;
					}
				}
			}
		}
		
		this.classes = classes;
		
	}
	
	
	
	public int getNumClasses() {
		int numClasses = 0;
		String yearArray[] = this.getYearArray();
		
		for(String yyear:yearArray) {
			for(Group grp:this.getDivArray(yyear)) {
				for(Module subj:this.getModuleArray(yyear)) {
					int sessionPerWeekCount = subj.getSessionsPerWeek();
					numClasses += sessionPerWeekCount;
				}
			}
		}	
		return numClasses;
	}
	
	public String[] getYearArray() {
		String yearArray[] = new String[this.yearDiv.size()];
		int i=0;
		
		//Group groups[] = (Group[]) this.groups.values().toArray(new Group[this.groups.size()]);
		for(String yearName : this.yearModules.keySet()) {
			yearArray[i] = yearName;
			i++;
		}	
		return yearArray;
	}
	
	public TrainerClass getTrainerClass(int subjectId,int groupId,String year) {
		
		TrainerClass cls[] = this.getTrainerClasses();
		for(TrainerClass classes : cls) {
			if(classes.getModuleId() == subjectId && classes.getDivId() == groupId && classes.getYear() == year) {
				return classes;
			}
		}
		
		return null;
		
	}
	
	public Group[] getDivArray(String yearKey) {
		HashMap<Integer, Group> yrDivs = this.yearDiv.get(yearKey);
		Group divs[] = (Group[]) yrDivs.values().toArray(new Group[yrDivs.size()]);
		return divs;
	}
	
	public Module[] getModuleArray(String yearKey) {
		HashMap<Integer, Module> yrModule = this.yearModules.get(yearKey);
		Module subs[] = (Module[]) yrModule.values().toArray(new Module[yrModule.size()]);
		return subs;
	}
	
	public LabModules[] getLabModuleArray(String yearKey) {
		HashMap<Integer, LabModules>labSubs = this.yearlabModules.get(yearKey);
		LabModules subs[] = (LabModules[]) labSubs.values().toArray(new LabModules[labSubs.size()]);
		return subs;
	}

	
}