import java.io.*;
import java.util.Scanner;
import java.sql.*;

/**
 * Don't be daunted by the number of classes in this chapter -- most of them are
 * just simple containers for information, and only have a handful of properties
 * with setters and getters.
 * 
 * The real stuff happens in the GeneticAlgorithm class and the Timetable class.
 * 
 * The Timetable class is what the genetic algorithm is expected to create a
 * valid version of -- meaning, after all is said and done, a chromosome is read
 * into a Timetable class, and the Timetable class creates a nicer, neater
 * representation of the chromosome by turning it into a proper list of Classes
 * with rooms and professors and whatnot.
 * 
 * The Timetable class also understands the problem's Hard Constraints (ie, a
 * professor can't be in two places simultaneously, or a room can't be used by
 * two classes simultaneously), and so is used by the GeneticAlgorithm's
 * calcFitness class as well.
 * 
 * Finally, we overload the Timetable class by entrusting it with the
 * "database information" generated here in initializeTimetable. Normally, that
 * information about what professors are employed and which classrooms the
 * university has would come from a database, but this isn't a book about
 * databases so we hardcode it.
 * 
 * @author bkanber
 *
 */
public class TimetableGA {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/tt";
	static final String USER = "root";
	static final String PASSWORD = "Rsg@24091998";

    public static void main(String[] args) throws ClassNotFoundException, IOException, SQLException {
    	
    	Connection conn = null;
    	Statement stmt = null;
    	
    	Scanner sc = new Scanner(System.in);
    	
    	int co;
    	
    	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    	
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	
    	BufferedReader br = new BufferedReader (new InputStreamReader (System.in));
    	stmt = conn.createStatement();
    	
    	
    	
    	
    	// Get a Timetable object with all the available information.
        Timetable timetable = initializeTimetable();
        
        // Initialize GA
        GeneticAlgorithm ga = new GeneticAlgorithm(100, 0.01, 0.9, 2, 5);
        
        //Assign trainer to respective class grps via genetic algorithm
        TrainerPopulation Tpopulation = ga.initTrainer(timetable);
        
        //Evaluate trainer population
        ga.evalTrainerPopulation(Tpopulation,timetable);
        
        //keep track of trainer genaration
        int trainerGeneration = 1;
        
        while(ga.isTerminationConditionMet(trainerGeneration, 5000)==false && ga.isTerminationConditionMet(Tpopulation)==false) {
        	Tpopulation = ga.crossoverTrainerPopulation(Tpopulation);
        	
        	Tpopulation = ga.mutateTrainerPopulation(Tpopulation, timetable);
        	
        	ga.evalTrainerPopulation(Tpopulation,timetable);
        	
        	trainerGeneration++;
        }
        
        timetable.createTrainerClasses(Tpopulation.getFittest(0));
        TrainerClass trainerClasses[] = timetable.getTrainerClasses();
        System.out.println("geaneration count : "+trainerGeneration);
        System.out.println("clashes count : "+timetable.calcTrainerClashes());
        
               
        for(TrainerClass bestClass : trainerClasses) {
        	if(bestClass.getSessionDuration() == 1) {
	        	System.out.println("CLasses id"+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
	        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getDivId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("-----");
        	}
        	else {
        		System.out.println("CLasses id"+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	System.out.println("prof load : "+p.getAllocatedLabLoadHr()+" prof excepted : "+p.getProfessorLabLoadHr());
	        	System.out.println("Module: " + timetable.getYearL(bestClass.getYear()).get(bestClass.getModuleId()).getlabModuleName());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getDivId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("-----");
        	}
        }
        
        
        int reply = 1;
        
        while(reply == 1) {
        
        // Initialize population
        Population population = ga.initPopulation(timetable);
        
        // Evaluate population
        ga.evalPopulation(population, timetable);
        
        // Keep track of current generation
        int generation = 1;
        
        // Start evolution loop
        while (ga.isTerminationConditionMet(generation, 4000) == false
            && ga.isTerminationConditionMet(population) == false) {
            // Print fitness
            //System.out.println("G" + generation + " Best fitness: " + population.getFittest(0).getFitness());

            // Apply crossover
            population = ga.crossoverPopulation(population);

            // Apply mutation
            population = ga.mutatePopulation(population, timetable);

            // Evaluate population
            ga.evalPopulation(population, timetable);

            // Increment the current generation
            generation++;
        }
        
        
        Individual individual = population.getFittest(0);
        timetable.createClasses(individual,timetable);
        Class classes[] = timetable.getClasses();
        System.out.println("\n\n\n\n\n\n\n\n");
        //String daysArray[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
        
	        for(Class bestClass : classes) {
	        	String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
	        	
	        	System.out.println("Class Id : "+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
	        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getGroupId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("Timeslot : "+timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            System.out.println("Room : "+timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
	            System.out.println("-----");
	        	
	
	        }
        
        int systemClashes = timetable.calcClashes(timetable,individual);
        System.out.println("geaneration count : "+generation);
        System.out.println("clashes count : "+timetable.calcClashes(timetable,individual));
        
        if(systemClashes == 0)
        	break;
        else {
        	System.out.println("Clashes exists, we recomend you to re-run the system.\nEnter 1 if you want to re-run the system.");
        	reply = sc.nextInt();
        }
        
        }
        
    
        
        /*
        System.out.println("\n\n\n\n\nEnter abscent prof id : ");
        int id;
        id = sc.nextInt();
        System.out.println("\nAbsent prof id : "+id);
        System.out.println("\nEnter day of absence : ");
        String day = sc.next(); 
        timetable.createAlternateTTclasses(timetable, id, day);
        Class classes[] = timetable.getClasses();
        System.out.println("\n\n\n\n\n\n\n\n");
        String daysArray2[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
        
	        for(Class bestClass : classes) {
	        	String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
	        	System.out.println("Class Id : "+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
	        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getGroupId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("Timeslot : "+timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            System.out.println("Room : "+timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
	            System.out.println("-----");
	
	        }
        
        
        System.out.println("clashes count AFTER CHANGE : "+timetable.calcAfterClashes(timetable));
        */
        
        conn.close(); 
    }
    
 
    /**
     * Creates a Timetable with all the necessary course information.
     * 
     * Normally you'd get this info from a database.
     * 
     * @return
     */
	private static Timetable initializeTimetable() {
		// Create timetable
		Timetable timetable = new Timetable();

		// Set up rooms
		timetable.addRoom(1, "201", 80);
		timetable.addRoom(2, "202", 80);
		timetable.addRoom(3, "203", 80);
		timetable.addRoom(4, "204", 80);
		timetable.addRoom(5, "111", 80);
		timetable.addRoom(6, "101", 80);
		timetable.addRoom(7, "102", 80);
		
		timetable.addLab(1, "205A", 20);
		timetable.addLab(2, "205B", 20);
		timetable.addLab(4, "205C", 20);
		timetable.addLab(5, "206", 20);
		timetable.addLab(6, "207", 20);
		timetable.addLab(7, "210", 20);
		timetable.addLab(8, "212A", 20);
		timetable.addLab(9, "212B", 20);
		timetable.addLab(10, "212C", 20);
		timetable.addLab(11, "112A", 20);
		timetable.addLab(12, "112B", 20);
		timetable.addLab(13, "112C", 20);
		

		// Set up timeslots DURATION, BRK TIME, WORKING DAYS
		timetable.setTotalTimeDuration("9-17","13-14",5);

		// Set up professors
		timetable.addProfessor(1, "A", 8, 6);
		timetable.addProfessor(2, "B", 8, 6);
		timetable.addProfessor(3, "C", 8, 6);
		timetable.addProfessor(4, "D", 8, 6);
		timetable.addProfessor(5, "E", 8, 6);
		timetable.addProfessor(6, "F", 8, 6);
		timetable.addProfessor(7, "G", 8, 6);
		timetable.addProfessor(8, "H", 8, 6);
		timetable.addProfessor(9, "I", 8, 6);
		timetable.addProfessor(10, "J",8, 6);
		timetable.addProfessor(11, "K",8, 6);
		timetable.addProfessor(12, "L", 7, 6);
		timetable.addProfessor(13, "M", 7, 6);
		timetable.addProfessor(14, "N", 7, 6);
		timetable.addProfessor(15, "O", 7, 6);
		timetable.addProfessor(16, "P", 7, 6);
		timetable.addProfessor(17, "Q",7, 6);
		timetable.addProfessor(18, "R", 7, 6);
		timetable.addProfessor(19, "S", 8, 6);
		timetable.addProfessor(20, "T", 8, 6);
		timetable.addProfessor(21, "U", 8, 6);
		timetable.addProfessor(22, "V", 8, 6);
		timetable.addProfessor(23, "W", 8, 6);
		timetable.addProfessor(24, "X", 8, 6);
		timetable.addProfessor(25, "Y", 8, 6);
		timetable.addProfessor(26, "Z", 8, 6);

		// Set up subjects and define the professors that teach them
		timetable.addModule("SE",1, "ADS",3, new int[] { 24, 11 },1);
		timetable.addModule("SE",2, "PPL",3, new int[] { 23, 19 },1);
		timetable.addModule("SE",3, "CG",3, new int[] { 25, 17 },1);
		timetable.addModule("SE",4, "M3",4, new int[] { 22, 8, 15},1);
		timetable.addModule("SE",5, "MP",3, new int[] { 26,21 },1);
		timetable.addModule("TE",6, "DAA",4, new int[] { 1, 2, 3 },1);
		timetable.addModule("TE",7, "SMD",3, new int[] { 4, 6, 23 },1);
		timetable.addModule("TE",8, "WT",3, new int[] { 7, 8, 9 },1);
		timetable.addModule("TE",9, "IOT",3, new int[] { 10, 11, 12},1);
		timetable.addModule("TE",10, "OS",3, new int[] { 13, 14, 15},1);
		timetable.addModule("BE",11, "AA",3, new int[] { 5, 16 },1);
		timetable.addModule("BE",12, "BB",4, new int[] { 1, 17, 14 },1);
		timetable.addModule("BE",13, "CC",3, new int[] { 18, 2},1);
		timetable.addModule("BE",14, "DD",4, new int[] { 19, 6},1);
		timetable.addModule("BE",15, "EE",4, new int[] { 3, 20, 16},1);
		
		
		//integrate labsModules into subjects
		
		timetable.addLabModule("SE",16,"ADSL",1,new int[] {24 , 21},2);
		timetable.addLabModule("SE",17,"CGL",1,new int[] {19 , 20},2);
		timetable.addLabModule("SE",18,"ML",2,new int[] {13 , 18, 12},2);
		timetable.addLabModule("TE",19,"IOTL",1,new int[] { 22, 7},2);
		timetable.addLabModule("TE",20,"WTL",2,new int[] {15 , 16},2);
		timetable.addLabModule("TE",21,"OSL",1,new int[] {17 , 18},2);
		timetable.addLabModule("BE",22,"AAL",1,new int[] {10 , 25},2);
		timetable.addLabModule("BE",23,"DDL",1,new int[] {24 , 9},2);
		timetable.addLabModule("BE",24,"CCL",2,new int[] {4 , 26},2);
		
		// Set up student groups(div) and the modules they take.
		timetable.addDivision("TE", 1, "A1");
		timetable.addDivision("TE", 2, "B1");
		timetable.addDivision("TE", 3, "C1");
		timetable.addDivision("BE", 4, "A2");
		timetable.addDivision("BE", 5, "B2");
		timetable.addDivision("BE", 6, "C2");
		timetable.addDivision("SE", 7, "A3");
		timetable.addDivision("SE", 8, "B3");
		timetable.addDivision("SE", 9, "C3");
		
		return timetable;
	}
}
