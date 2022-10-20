package com.abc.jsp;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Random;
public class TrainerPopulation {
	
	private IndividualTrainer trainerPopulation[];
	private double populationFitness = -1;

	/**
	 * Initializes blank population of individuals
	 * 
	 * @param populationSize
	 *            The size of the population
	 */
	public TrainerPopulation(int populationSize) {
		// Initial population
		this.trainerPopulation = new IndividualTrainer[populationSize];
	}
	
	/**
     * Initializes population of individuals
     * 
     * @param populationSize The size of the population
     */
	public TrainerPopulation(int populationSize, Timetable timetable) {
		// Initial population
		this.trainerPopulation = new IndividualTrainer[populationSize];

		// Loop over population size 100 Individual trainer and subject mapping sets are created.
		for (int individualCount = 0; individualCount < populationSize; individualCount++) {
			// Create individual
			IndividualTrainer individual = new IndividualTrainer(timetable);
			// Add individual to population
			this.trainerPopulation[individualCount] = individual;
		}
	}


	/**
	 * Initializes population of individuals
	 * 
	 * @param populationSize
	 *            The size of the population
	 * @param chromosomeLength
	 *            The length of the individuals chromosome
	 */
	public TrainerPopulation(int populationSize, int chromosomeLength) {
		// Initial population
		this.trainerPopulation = new IndividualTrainer[populationSize];

		// Loop over population size
		for (int individualCount = 0; individualCount < populationSize; individualCount++) {
			// Create individual
			IndividualTrainer individual = new IndividualTrainer(chromosomeLength);
			// Add individual to population
			this.trainerPopulation[individualCount] = individual;
		}
	}

	/**
	 * Get individuals from the population
	 * 
	 * @return individuals Individuals in population
	 */
	public IndividualTrainer[] getIndividuals() {
		return this.trainerPopulation;
	}

	/**
	 * Find fittest individual in the population
	 * 
	 * @param offset
	 * @return individual Fittest individual at offset
	 */
	public IndividualTrainer getFittest(int offset) {
		// Order population by fitness
		Arrays.sort(this.trainerPopulation, new Comparator<IndividualTrainer>() {
			@Override
			public int compare(IndividualTrainer o1, IndividualTrainer o2) {
				if (o1.getFitness() > o2.getFitness()) {
					return -1;
				} else if (o1.getFitness() < o2.getFitness()) {
					return 1;
				}
				return 0;
			}
		});

		// Return the fittest individual
		return this.trainerPopulation[offset];
	}

	/**
	 * Set population's fitness
	 * 
	 * @param fitness
	 *            The population's total fitness
	 */
	public void setPopulationFitness(double fitness) {
		this.populationFitness = fitness;
	}

	/**
	 * Get population's fitness
	 * 
	 * @return populationFitness The population's total fitness
	 */
	public double getPopulationFitness() {
		return this.populationFitness;
	}

	/**
	 * Get population's size
	 * 
	 * @return size The population's size
	 */
	public int size() {
		return this.trainerPopulation.length;
	}

	/**
	 * Set individual at offset
	 * 
	 * @param individual
	 * @param offset
	 * @return individual
	 */
	public IndividualTrainer setIndividual(int offset, IndividualTrainer individual) {
		return trainerPopulation[offset] = individual;
	}

	/**
	 * Get individual at offset
	 * 
	 * @param offset
	 * @return individual
	 */
	public IndividualTrainer getIndividual(int offset) {
		return trainerPopulation[offset];
	}

	/**
	 * Shuffles the population in-place
	 * 
	 * @param void
	 * @return void
	 */
	public void shuffle() {
		Random rnd = new Random();
		for (int i = trainerPopulation.length - 1; i > 0; i--) {
			int index = rnd.nextInt(i + 1);
			IndividualTrainer a = trainerPopulation[index];
			trainerPopulation[index] = trainerPopulation[i];
			trainerPopulation[i] = a;
		}
	}



}
