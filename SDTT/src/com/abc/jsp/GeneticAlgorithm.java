package com.abc.jsp;

public class GeneticAlgorithm {

	private int populationSize;
	private double mutationRate;
	private double crossoverRate;
	private int elitismCount;
	protected int tournamentSize;

	public GeneticAlgorithm(int populationSize, double mutationRate, double crossoverRate, int elitismCount,
			int tournamentSize) {
		this.populationSize = populationSize;
		this.mutationRate = mutationRate;
		this.crossoverRate = crossoverRate;
		this.elitismCount = elitismCount;
		this.tournamentSize = tournamentSize;
	}
	/**
	 * Initialize population
	 * 
	 * @param chromosomeLength
	 *            The length of the individuals chromosome
	 * @return population The initial population generated
	 */
	public Population initPopulation(Timetable timetable) {
		// Initialize population
		Population population = new Population(this.populationSize, timetable);
		return population;
	}
	
	public TrainerPopulation initTrainer (Timetable timetable)
	{
		//Initialize teacher div mapping
		TrainerPopulation population = new TrainerPopulation(this.populationSize, timetable);
		return population;
	}

	/**
	 * Check if population has met termination condition
	 * 
	 * @param generationsCount
	 *            Number of generations passed
	 * @param maxGenerations
	 *            Number of generations to terminate after
	 * @return boolean True if termination condition met, otherwise, false
	 */
	public boolean isTerminationConditionMet(int generationsCount, int maxGenerations) {
		return (generationsCount > maxGenerations);
	}

	/**
	 * Check if population has met termination condition
	 *
	 * @param population
	 * @return boolean True if termination condition met, otherwise, false
	 */
	public boolean isTerminationConditionMet(Population population) {
		return population.getFittest(0).getFitness() == 1.0;
	}
	
	public boolean isTerminationConditionMet(TrainerPopulation population) {
		return population.getFittest(0).getFitness() == 1;
	}

	/**
	 * Calculate individual's fitness value
	 * 
	 * @param individual
	 * @param timetable
	 * @return fitness
	 */
	
	/**
	 * Evaluate population
	 * 
	 * @param population
	 * @param timetable
	 */
	public void evalPopulation(Population population, Timetable timetable) {
		double populationFitness = 0;

		// Loop over population evaluating individuals and summing population
		// fitness
		for(Individual individual: population.getIndividuals()) {
			populationFitness += this.calcFitness(individual, timetable);
		}
		
		population.setPopulationFitness(populationFitness);
	}
	
	public void evalTrainerPopulation(TrainerPopulation trainerPopulation, Timetable timetable)
	{
		double TpopulationFitness = 0;
		
		for(IndividualTrainer individual: trainerPopulation.getIndividuals()) {
			TpopulationFitness += this.calcTrainerFitness(individual,timetable);
		}
		trainerPopulation.setPopulationFitness(TpopulationFitness);
	}
	
	
	public double calcTrainerFitness(IndividualTrainer individual,Timetable timetable) {
		Timetable threadTrainer = new Timetable (timetable);
		threadTrainer.createTrainerClasses(individual);
		
		int clashes = threadTrainer.calcTrainerClashes();
		double fitness = 1 / (double) (clashes + 1);
		
		individual.setFitness(fitness);
		
		return fitness;
	}
	
	public double calcFitness(Individual individual, Timetable timetable) {
		Timetable threadTimetable = new Timetable (timetable);
		threadTimetable.createClasses(individual,timetable);
		
		int clashes = threadTimetable.calcClashes(timetable);
		double fitness = 1/ (double) (clashes + 1);
		
		individual.setFitness(fitness);
		return fitness;
	}
	
	/**
	 * Selects parent for crossover using tournament selection
	 * 
	 * Tournament selection works by choosing N random individuals, and then
	 * choosing the best of those.
	 * 
	 * @param population
	 * @return The individual selected as a parent
	 */
	public Individual selectParent(Population population) {
		// Create tournament
		Population tournament = new Population(this.tournamentSize);

		// Add random individuals to the tournament
		population.shuffle();
		for (int i = 0; i < this.tournamentSize; i++) {
			Individual tournamentIndividual = population.getIndividual(i);
			tournament.setIndividual(i, tournamentIndividual);
		}

		// Return the best
		return tournament.getFittest(0);
	}
	
	public IndividualTrainer selectParent(TrainerPopulation population) {
		// Create tournament
		TrainerPopulation tournament = new TrainerPopulation(this.tournamentSize);

		// Add random individuals to the tournament
		population.shuffle();
		for (int i = 0; i < this.tournamentSize; i++) {
			IndividualTrainer tournamentIndividual = population.getIndividual(i);
			tournament.setIndividual(i, tournamentIndividual);
		}

		// Return the best
		return tournament.getFittest(0);
	}
	
	
	public TrainerPopulation crossoverTrainerPopulation (TrainerPopulation trainerPopulation) {
		TrainerPopulation newTrainerPopulation = new TrainerPopulation(trainerPopulation.size());
		
		for (int populationIndex = 0; populationIndex < trainerPopulation.size(); populationIndex++) {
			IndividualTrainer parent1 = trainerPopulation.getFittest(populationIndex);  //return fittest invidual
			
			if (this.crossoverRate > Math.random() && populationIndex >= this.elitismCount) {
				// Initialize offspring
				IndividualTrainer offspring = new IndividualTrainer(parent1.getChromosomeLength());
				
				IndividualTrainer parent2 = selectParent(trainerPopulation);
				
				for (int geneIndex = 0; geneIndex < parent1.getChromosomeLength(); geneIndex++) {
					if (0.5 > Math.random()) {
						offspring.setGene(geneIndex, parent1.getGene(geneIndex));
					} else {
						offspring.setGene(geneIndex, parent2.getGene(geneIndex));
					}
				}
				newTrainerPopulation.setIndividual(populationIndex, offspring);
			}
			else {
				newTrainerPopulation.setIndividual(populationIndex, parent1);
			}
		}
		
		return newTrainerPopulation;
	}
	
	public TrainerPopulation mutateTrainerPopulation (TrainerPopulation trainerPopulation,Timetable timetable) {
		TrainerPopulation newTrainerPopulation = new TrainerPopulation(trainerPopulation.size());
		
		for(int populationIndex = 0; populationIndex < trainerPopulation.size(); populationIndex++) {
			IndividualTrainer individualTrainer = trainerPopulation.getFittest(populationIndex);
			IndividualTrainer randomIndividual = new IndividualTrainer(timetable);
			
			for (int geneIndex = 0; geneIndex < individualTrainer.getChromosomeLength(); geneIndex++) {
				// Skip mutation if this is an elite individual
				if (populationIndex > this.elitismCount) {
					// Does this gene need mutation?
					if (this.mutationRate > Math.random()) {
						// Swap for new gene
						individualTrainer.setGene(geneIndex, randomIndividual.getGene(geneIndex));
					}
				}
			}
			newTrainerPopulation.setIndividual(populationIndex, individualTrainer);

		}
		
		return newTrainerPopulation;
	}


	/**
     * Apply mutation to population
     * 
     * @param population
     * @param timetable
     * @return The mutated population
     */
	public Population mutatePopulation(Population population, Timetable timetable) {
		// Initialize new population
		Population newPopulation = new Population(this.populationSize);

		// Loop over current population by fitness
		for (int populationIndex = 0; populationIndex < population.size(); populationIndex++) {
			Individual individual = population.getFittest(populationIndex);

			// Create random individual to swap genes with
			Individual randomIndividual = new Individual(timetable);

			// Loop over individual's genes
			for (int geneIndex = 0; geneIndex < individual.getChromosomeLength(); geneIndex++) {
				// Skip mutation if this is an elite individual
				if (populationIndex > this.elitismCount) {
					// Does this gene need mutation?
					if (this.mutationRate > Math.random()) {
						// Swap for new gene
						individual.setGene(geneIndex, randomIndividual.getGene(geneIndex));
					}
				}
			}

			// Add individual to population
			newPopulation.setIndividual(populationIndex, individual);
		}

		// Return mutated population
		return newPopulation;
	}

    /**
     * Apply crossover to population
     * 
     * @param population The population to apply crossover to
     * @return The new population
     */
	public Population crossoverPopulation(Population population) {
		// Create new population
		Population newPopulation = new Population(population.size());

		// Loop over current population by fitness
		for (int populationIndex = 0; populationIndex < population.size(); populationIndex++) {
			Individual parent1 = population.getFittest(populationIndex);

			// Apply crossover to this individual?
			if (this.crossoverRate > Math.random() && populationIndex >= this.elitismCount) {
				// Initialize offspring
				Individual offspring = new Individual(parent1.getChromosomeLength());
				
				// Find second parent
				Individual parent2 = selectParent(population);

				// Loop over genome
				for (int geneIndex = 0; geneIndex < parent1.getChromosomeLength(); geneIndex++) {
					// Use half of parent1's genes and half of parent2's genes
					if (0.5 > Math.random()) {
						offspring.setGene(geneIndex, parent1.getGene(geneIndex));
					} else {
						offspring.setGene(geneIndex, parent2.getGene(geneIndex));
					}
				}

				// Add offspring to new population
				newPopulation.setIndividual(populationIndex, offspring);
			} else {
				// Add individual to new population without applying crossover
				newPopulation.setIndividual(populationIndex, parent1);
			}
		}

		return newPopulation;
	}



}
