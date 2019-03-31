package com.primat.hierarchy.model;

import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Data
public class Problem {

	public static final String FACTORS_KEY = "FACTORS";

	private String name;

	private int factorsCount;
	private List<Factor> factors;

	private int alternativesCount;
	private List<Alternative> alternatives;

	private double[][] matrix;

	@Getter(AccessLevel.PRIVATE)
	@Setter(AccessLevel.PRIVATE)
	private Map<String, double[]> priorities = new HashMap<>();

	@Getter(AccessLevel.PRIVATE)
	@Setter(AccessLevel.PRIVATE)
	private Map<String, double[][]> factorMatrices = new HashMap<>();

	public void setPrioritiesVector(String key, double[] vector) {
		priorities.put(key, vector);
	}

	public double[] getPrioritiesVector(String key) {
		return priorities.get(key);
	}

	public void setMatrixForFactor(String factorCode, double[][] matrix) {
		factorMatrices.put(factorCode, matrix);
	}

	public double[][] getMatrixForFactor(String factorCode) {
		return factorMatrices.get(factorCode);
	}

	public Optional<Factor> getFirstFactorWithoutPrioritiesVector() {
		return factors.stream()
				.filter(factor -> !priorities.containsKey(factor.getCode()))
				.findFirst();
	}

}
