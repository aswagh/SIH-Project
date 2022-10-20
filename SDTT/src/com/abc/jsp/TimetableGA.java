package com.abc.jsp;
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
	
	static Timetable timetable;
	static GeneticAlgorithm ga;
	static TrainerPopulation Tpopulation;
	static Population population;
	
	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/tt";
	static final String USER = "root";
	static final String PASSWORD = "mysql";

    public static void main(String[] args) throws Exception {
    	
    	Connection conn = null;
    	Statement stmt = null;
    	Scanner sc = new Scanner(System.in);
    	    	
    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    	
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	
    	BufferedReader br = new BufferedReader (new InputStreamReader (System.in));
    	stmt = conn.createStatement();
    	stmt.executeUpdate("truncate table timetable");
    	String query = " insert into timetable (slotId, Professor_id, sub_id, div_id, timeslot,Room,day)"+ " values (?, ?, ?, ?, ?, ?, ?)";
    	PreparedStatement preparedStmt = conn.prepareStatement(query);//setting prepared statement to insert fields into tables
    	generateTimetable();
        /*
        System.out.println("\n\n\n\n\nEnter abscent prof id : ");
        int id;
        id = sc.nextInt();
        System.out.println("\nAbsent prof id : "+id);
        System.out.println("\nEnter day of absence : ");
        String day = sc.next(); 
        */
    	
        
        conn.close(); 
    }
    
    public static void generateTimetable() throws Exception {
    	Connection conn = null;
    	Statement stmt = null;
    	Scanner sc = new Scanner(System.in);
    	    	
    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    	
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	
    	BufferedReader br = new BufferedReader (new InputStreamReader (System.in));
    	stmt = conn.createStatement();
    	stmt.executeUpdate("truncate table timetable");
    	String query = " insert into timetable (slotId, Professor_id, sub_id, div_id, timeslot,Room,day)"+ " values (?, ?, ?, ?, ?, ?, ?)";
    	PreparedStatement preparedStmt = conn.prepareStatement(query);//setting prepared statement to insert fields into tables
    	
    	
    	// Get a Timetable object with all the available information.
        timetable = initializeTimetable();
        
        // Initialize GA
        ga = new GeneticAlgorithm(100, 0.01, 0.9, 2, 5);
        
        //Assign trainer to respective class grps via genetic algorithm
        Tpopulation = ga.initTrainer(timetable);
        
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
        	System.out.println("CLasses id"+bestClass.getClassId());
        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
        	System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getDivId()).getGroupId());
            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
            System.out.println("-----");
            
            
            
        }
        
        
        int reply = 1;
        
        while(reply == 1) {
        
        // Initialize population
        population = ga.initPopulation(timetable);
        
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
        
        
        
        timetable.createClasses(population.getFittest(0),timetable);
        Class classes[] = timetable.getClasses();
        System.out.println("\n\n\n\n\n\n\n\n");
        String daysArray[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
        
        for (String year:timetable.getYearArray()) {
        	for(Module div:timetable.getModuleArray(year)) {
        		for(String day:daysArray) {
			        for(Class bestClass : classes) {
			        	String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
			        	if(bestClass.getYear()==year && timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()) == div && tslot.contains(day)) {
			        	//String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
			        	
				        	System.out.println("Class Id : "+bestClass.getClassId());
				        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
				        	System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
				        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
				            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getGroupId()).getGroupId());
				            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
				            System.out.println("Timeslot : "+timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
				            System.out.println("Room : "+timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
				            System.out.println("-----");
				            
				            preparedStmt.setInt(1, bestClass.getClassId());
				            preparedStmt.setInt(2,bestClass.getProfessorId());
				            preparedStmt.setInt(3, bestClass.getModuleId());
				            preparedStmt.setInt(4, bestClass.getGroupId());
				            preparedStmt.setString(5, timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
				            preparedStmt.setInt(6, bestClass.getRoomId());
				            preparedStmt.setString(7, day);
				            
				            preparedStmt.execute();
			        	}
			        
			        }
        		}
        	}
        }
        
        int systemClashes = timetable.calcClashes(timetable);
        System.out.println("geaneration count : "+generation);
        System.out.println("clashes count : "+timetable.calcClashes(timetable));
        
        if(systemClashes == 0)
        	break;
        else {
        	System.out.println("Clashes exists, we recomend you to re-run the system.\nEnter 1 if you want to re-run the system.");
        	reply = sc.nextInt();
        }
        
        }
        
    	}
  //for single day trainer replacement
    public static void replaceTrainer(int id,String day) throws Exception {
    	timetable = initializeTimetable();
    	timetable.createDynamicTTclasses();
    	timetable.createAlternateTTclasses(timetable, id, day);
        Class classes[] = timetable.getClasses();
        
        Connection conn = null;
    	Statement stmt = null;
    	Scanner sc = new Scanner(System.in);
    	    	
    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    	
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	
    	BufferedReader br = new BufferedReader (new InputStreamReader (System.in));
    	stmt = conn.createStatement();
    	stmt.executeUpdate("truncate table dynamictable");
        String query = " insert into dynamictable (slotId, Professor_id, sub_id, div_id, timeslot,Room,day)"+ " values (?, ?, ?, ?, ?, ?, ?)";
    	PreparedStatement preparedStmt = conn.prepareStatement(query);
    	
    	
        System.out.println("\n\n\n\n\n\n\n\n");
        String daysArray2[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
        
	        for(Class bestClass : classes) {
	        	String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
	        	
	        	System.out.println("Class Id : "+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	//System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
	        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getGroupId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("Timeslot : "+timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            System.out.println("Room : "+timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
	            System.out.println("-----");
	            
	            
	            preparedStmt.setInt(1, bestClass.getClassId());
	            preparedStmt.setInt(2,bestClass.getProfessorId());
	            preparedStmt.setInt(3, bestClass.getModuleId());
	            preparedStmt.setInt(4, bestClass.getGroupId());
	            preparedStmt.setString(5, timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            preparedStmt.setInt(6, bestClass.getRoomId());
	            String slots[] = tslot.split(" ");

	            preparedStmt.setString(7, slots[0]);
	            preparedStmt.execute();
	        	}
	
	        
        		
        	
        
        
        
        System.out.println("clashes count AFTER CHANGE : "+timetable.calcAfterClashes(timetable));
        
    	}     
    //function for a slot
    public static void replaceTrainerForAslot(int id,String slot,int div_id,int sub_id,int room_id,String status) throws Exception {
    	
    	
    	timetable = initializeTimetable();
    	timetable.createDynamicTTclasses();
    	timetable.createAlternateTTclassesForAslot(timetable, id, slot,  div_id, sub_id, room_id, status);
        Class classes[] = timetable.getClasses();
        
        
        
        Connection conn = null;
    	Statement stmt = null;
    	Scanner sc = new Scanner(System.in);
    	    	
    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    	
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	
    	BufferedReader br = new BufferedReader (new InputStreamReader (System.in));
    	stmt = conn.createStatement();
    	stmt.executeUpdate("truncate table dynamictable");
        String query = " insert into dynamictable (slotId, Professor_id, sub_id, div_id, timeslot,Room,day)"+ " values (?, ?, ?, ?, ?, ?, ?)";
    	PreparedStatement preparedStmt = conn.prepareStatement(query);
    	
    	
    	
    	
        System.out.println("\n\n\n\n\n\n\n\n");
        String daysArray2[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
        
	        for(Class bestClass : classes) {
	        	String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
	        	
	        	System.out.println("Class Id : "+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	//System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
	        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getGroupId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("Timeslot : "+timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            System.out.println("Room : "+timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
	            System.out.println("-----");
	            
	            
	            preparedStmt.setInt(1, bestClass.getClassId());
	            preparedStmt.setInt(2,bestClass.getProfessorId());
	            preparedStmt.setInt(3, bestClass.getModuleId());
	            preparedStmt.setInt(4, bestClass.getGroupId());
	            preparedStmt.setString(5, timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            preparedStmt.setInt(6, bestClass.getRoomId());
	            String slots[] = tslot.split(" ");

	            preparedStmt.setString(7, slots[0]);
	            preparedStmt.execute();
	        	}

        
        System.out.println("clashes count AFTER CHANGE : "+timetable.calcAfterClashes(timetable));
 
        
    	} 
    
    
    
    //function for after a slot i.e. hALF DAY leave
    public static void replaceTrainerForAfterDayslot(int id,String slot) throws Exception {
    	timetable = initializeTimetable();
    	timetable.createDynamicTTclasses();
    	timetable.createAlternateTTclassesForAfterDayslot(timetable, id, slot);
        Class classes[] = timetable.getClasses();
        
        Connection conn = null;
    	Statement stmt = null;
    	Scanner sc = new Scanner(System.in);
    	    	
    	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    	
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	
    	BufferedReader br = new BufferedReader (new InputStreamReader (System.in));
    	stmt = conn.createStatement();
    	stmt.executeUpdate("truncate table dynamictable");
        String query = " insert into dynamictable (slotId, Professor_id, sub_id, div_id, timeslot,Room,day)"+ " values (?, ?, ?, ?, ?, ?, ?)";
    	PreparedStatement preparedStmt = conn.prepareStatement(query);
    	
    	
        System.out.println("\n\n\n\n\n\n\n\n");
        String daysArray2[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
        
	        for(Class bestClass : classes) {
	        	String tslot = timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot();
	        	
	        	System.out.println("Class Id : "+bestClass.getClassId());
	        	Professor p = timetable.getProfessor(bestClass.getProfessorId());
	        	//System.out.println("prof load : "+p.getAllocatedLoadHr()+" prof excepted : "+p.getProfessorLoadHr());
	        	System.out.println("Module: " + timetable.getYear(bestClass.getYear()).get(bestClass.getModuleId()).getModuleCode());
	            System.out.println("Group: " + timetable.getYearG(bestClass.getYear()).get(bestClass.getGroupId()).getGroupId());
	            System.out.println("Professor: " +timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
	            System.out.println("Timeslot : "+timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            System.out.println("Room : "+timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
	            System.out.println("-----");
	            
	            
	            preparedStmt.setInt(1, bestClass.getClassId());
	            preparedStmt.setInt(2,bestClass.getProfessorId());
	            preparedStmt.setInt(3, bestClass.getModuleId());
	            preparedStmt.setInt(4, bestClass.getGroupId());
	            preparedStmt.setString(5, timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
	            preparedStmt.setInt(6, bestClass.getRoomId());
	            String slots[] = tslot.split(" ");

	            preparedStmt.setString(7, slots[0]);
	            preparedStmt.execute();
	        	}

        
        System.out.println("clashes count AFTER CHANGE : "+timetable.calcAfterClashes(timetable));
        
    	} 
    
 
    /**
     * Creates a Timetable with all the necessary course information.
     * 
     * Normally you'd get this info from a database.
     * 
     * @return
     */
	private static Timetable initializeTimetable()throws Exception {
		// Create timetable
		Timetable timetable = new Timetable();
    	Connection conn = null;
    	Statement stmt = null;
    	ResultSet rs=null;
    	String sql="";
    	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    	conn = DriverManager.getConnection(DB_URL,USER,PASSWORD);
    	stmt = conn.createStatement();
		
    	sql="select * from room;";
		rs=stmt.executeQuery(sql);
		
		while(rs.next()) {

		timetable.addRoom(rs.getInt("room_id"),rs.getString("room_name"),rs.getInt("capacity"));
			
		}
		rs.close();
		// Set up rooms
		//timetable.addRoom(2, "202", 80);
		/*
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
		*/

		// Set up timeslots DURATION, BRK TIME, WORKING DAYS
		timetable.setTotalTimeDuration();
 
		sql="select * from trainer inner join load_hr on trainer.trainer_id = load_hr.trainer_id;";
		rs=stmt.executeQuery(sql);
		while(rs.next()) {
			
			timetable.addProfessor(rs.getInt("trainer_id"),rs.getString("trainer_name"),rs.getInt("lec_load_hr"));
		}
		rs.close();

		// Set up professors
		//timetable.addProfessor(1, "A", 8);
		
		ResultSet rs2,rs1;
		sql="select year, sub_id, sub_name, weekly_hours from subjects";
		rs=stmt.executeQuery(sql);
		Statement stmt1 = conn.createStatement();
		while(rs.next()) {
			int sub_id2 = rs.getInt("sub_id");
			String yr = rs.getString("year");
			String sub_name = rs.getString("sub_name");
			int hrs = rs.getInt("weekly_hours");
			System.out.println("rrr"+sub_id2);
			String sql2 = "select trainer_id from trainer_skills where sub_id = "+sub_id2+";";
			rs2 = stmt1.executeQuery(sql2);
			System.out.println("rrrww"+rs2.getRow());
			rs2.last();
			int t[] = new int[rs2.getRow()];
			rs2.beforeFirst();
			int i=0;
			while(rs2.next()) {
				t[i] = rs2.getInt("trainer_id");
				System.out.println(t[i]);
				i++;
			}
			rs2.close();
			timetable.addModule(yr,sub_id2,sub_name,hrs,t,1);
		}
		rs.close();
		
		
		
		//integrate labsModules into subjects
		/*
		timetable.addModule("SE",16,"ADSL",1,new int[] {24 , 21},2);
		timetable.addModule("SE",17,"CGL",1,new int[] {19 , 20},2);
		timetable.addModule("SE",18,"ML",2,new int[] {13 , 18, 12},2);
		timetable.addModule("TE",19,"IOTL",1,new int[] { 22, 7},2);
		timetable.addModule("TE",20,"WTL",2,new int[] {15 , 16},2);
		timetable.addModule("TE",21,"OSL",1,new int[] {17 , 18},2);
		timetable.addModule("BE",22,"AAL",1,new int[] {10 , 25},2);
		timetable.addModule("BE",23,"DDL",1,new int[] {24 , 9},2);
		timetable.addModule("BE",24,"CCL",2,new int[] {4 , 26},2);
		*/
		// Set up student groups(div) and the modules they take.
		sql="select * from division;";
		rs=stmt.executeQuery(sql);
		while(rs.next()) {
			timetable.addDivision(rs.getString("year"),rs.getInt("div_id"), rs.getString("div_name"));
		}
		//timetable.addDivision("TE", 1, "A1");
		
		return timetable;
	}
}
