package com.primat.hierarchy.service;

import com.primat.hierarchy.model.Alternative;
import com.primat.hierarchy.model.Factor;
import com.primat.hierarchy.model.Problem;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

public class HelperService {

	public static double[][] reflectMatrix(double[][] matrix) {
		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix.length; j++) {
				if (i > j)
					matrix[i][j] = 1 / matrix[j][i];
			}
		}

		return matrix;
	}

	public static ArrayList<Factor> initializeFactors(final int size) {
		ArrayList<Factor> factors = new ArrayList<>(size);
		for (int i = 0; i < size; i++) {
			factors.add(new Factor("F_" + (i + 1)));
		}
		return factors;
	}

	public static ArrayList<Alternative> initializeAlternatives(final int size) {
		ArrayList<Alternative> alternatives = new ArrayList<>(size);
		for (int i = 0; i < size; i++) {
			alternatives.add(new Alternative("A_" + (i + 1)));
		}
		return alternatives;
	}

	public static double[] findLocalPriorities(double[][] matrix) {
		double sum = 0;
		for (double[] aMatrix : matrix)
			sum += geometricalMean(aMatrix);

		double[] priorities = new double[matrix.length];
		for (int i = 0; i < priorities.length; i++) {
			priorities[i] = geometricalMean(matrix[i]) / sum;
		}

		return priorities;
	}

	public static double geometricalMean(double[] array) {
		double product = 1.0;
		for (double anArray : array)
			product *= anArray;
		return Math.pow(product, 1.0 / array.length);
	}

	public static Problem initProblem() {
		Problem problem = new Problem();

		problem.setName("Best House Choice");
		problem.setAlternativesCount(3);
		problem.setFactorsCount(4);

		ArrayList<Factor> factors = HelperService.initializeFactors(problem
				.getFactorsCount());
		factors.get(0).setName("Size");
		factors.get(1).setName("Transport");
		factors.get(2).setName("Condition");
		factors.get(3).setName("Price");
		problem.setFactors(factors);

		ArrayList<Alternative> alternatives = HelperService
				.initializeAlternatives(problem.getAlternativesCount());
		alternatives.get(0).setName("House A");
		alternatives.get(1).setName("House B");
		alternatives.get(2).setName("House C");
		problem.setAlternatives(alternatives);

		double[][] factorsComparisonMatrix = new double[problem
				.getFactorsCount()][problem.getFactorsCount()];
		factorsComparisonMatrix[0][1] = 5;
		factorsComparisonMatrix[0][2] = (double) 1 / 3;
		factorsComparisonMatrix[0][3] = (double) 1 / 4;
		factorsComparisonMatrix[1][2] = (double) 1 / 5;
		factorsComparisonMatrix[1][3] = (double) 1 / 7;
		factorsComparisonMatrix[2][3] = (double) 1 / 2;
		problem.setMatrix(factorsComparisonMatrix);

		problem.setMatrixForFactor(factors.get(0).getCode(), new double[][] {
				{ 1, 5, 9 }, { 1.0 / 5, 1, 4 }, { 1.0 / 9, 1.0 / 4, 1.0 } });

		problem.setMatrixForFactor(factors.get(1).getCode(), new double[][] {
				{ 1.0, 4.0, 1.0 / 5 }, { 1.0 / 4, 1.0, 1.0 / 9 },
				{ 5.0, 9.0, 1.0 } });

		problem.setMatrixForFactor(factors.get(2).getCode(),
				new double[][] { { 1.0, 1.0 / 2, 1.0 / 2 }, { 2.0, 1.0, 1.0 },
						{ 2.0, 1.0, 1.0 } });

		problem.setMatrixForFactor(factors.get(3).getCode(), new double[][] {
				{ 1.0, 500.0 / 1000, 700.0 / 1000 },
				{ 1000.0 / 500, 1.0, 700.0 / 500 },
				{ 1000.0 / 700, 500.0 / 700, 1.0 } });

		return problem;
	}

	public static void saveInfoToFile(Problem problem) {
		File file = new File("./files/" + problem.getName() + ".json");
		file.getParentFile().mkdirs();
		try {
			FileWriter writer = new FileWriter(file);
			writer.append("{\n");
			writer.append("table:\"" + problem.getName() + "\",\n");
			int factorsCount = problem.getFactorsCount();
			int alternativesCout = problem.getAlternativesCount();
			writer.append("factorsCount: " + factorsCount + ",\n");
			writer.append("alternativesCout: " + alternativesCout + ",\n");
			ArrayList<Factor> factors = (ArrayList<Factor>) problem
					.getFactors();
			ArrayList<Alternative> alternatives = (ArrayList<Alternative>) problem
					.getAlternatives();
			writer.append("factorNames: [");
			for (int i = 0; i < factorsCount; i++) {
				String name = factors.get(i).getName();
				if (name != null) {
					writer.append("\"" + name + "\"");
					if (i + 1 < factorsCount)
						writer.append(", ");
				}
			}
			writer.append("],\n");
			writer.append("factorsValue :{\n");
			for (int i = 0; i < factorsCount; i++) {
				if (factors.get(i).getCode() != null) {
					double[][] prioritiesMatrix = problem
							.getMatrixForFactor(factors.get(i).getCode());
					String name = factors.get(i).getName();
					if (prioritiesMatrix != null) {
						writer.append(name + ":[\n");
						for (int s = 0; s < prioritiesMatrix.length; s++) {
							writer.append("[\n");
							for (int j = 0; j < prioritiesMatrix.length; j++) {
								writer.append("" + prioritiesMatrix[s][j]);
								if (j + 1 < prioritiesMatrix.length)
									writer.append(", ");
							}
							writer.append("\n]");
							if (s + 1 < prioritiesMatrix.length)
								writer.append(",\n");
							else
								writer.append("\n");
						}
						writer.append("],\n");
					}
				}
			}
			writer.append("},\n");
			writer.append("alternatives: [\n");
			for (int i = 0; i < alternativesCout; i++) {
				writer.append("\"" + alternatives.get(i).getName() + "\"");
				if (i + 1 < alternativesCout)
					writer.append(", ");
			}
			writer.append("\n],\n");
			double[][] comparisonMatrix = problem.getMatrix();
			writer.append("comparisonMatrix: [\n");
			for (int i = 0; i < comparisonMatrix.length; i++) {
				writer.append("[\n");
				for (int j = 0; j < comparisonMatrix.length; j++) {
					writer.append(comparisonMatrix[i][j] + "");
					if (j + 1 < comparisonMatrix.length)
						writer.append(", ");
				}
				writer.append("\n]");
				if (i + 1 < comparisonMatrix.length)
					writer.append(",\n");
				else
					writer.append("\n");
			}
			writer.append("]\n}");
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static Problem initProblemFromFile(String name) {
		File file = new File("./files/" + name);
		Problem problem = new Problem();
		String result = "";
		try {
			FileReader reader = new FileReader(file);
			BufferedReader buffReader = new BufferedReader(reader);
			String read = buffReader.readLine();
			while (read != null) {
				result += read + "\n";
				read = buffReader.readLine();
			}
			JSONObject obj = new JSONObject(result);

			problem.setName(obj.getString("table"));
			problem.setAlternativesCount(obj.getInt("alternativesCout"));
			problem.setFactorsCount(obj.getInt("factorsCount"));
			ArrayList<Factor> factors = HelperService.initializeFactors(problem
					.getFactorsCount());
			ArrayList<Alternative> alternatives = HelperService
					.initializeAlternatives(problem.getAlternativesCount());
			for (int i = 0; i < factors.size(); i++) {
				String str = obj.getJSONArray("factorNames").getString(i);
				factors.get(i).setName(str);
			}
			problem.setFactors(factors);
			problem.setAlternatives(alternatives);
			for (int i = 0; i < alternatives.size(); i++) {
				String str = obj.getJSONArray("alternatives").getString(i);
				alternatives.get(i).setName(str);
			}

			JSONArray factorsComparisonMatrixJson = obj
					.getJSONArray("comparisonMatrix");
			double[][] factorsComparisonMatrix = new double[problem
					.getFactorsCount()][problem.getFactorsCount()];
			for (int i = 0; i < problem.getFactorsCount(); i++)
				for (int j = 0; j < problem.getFactorsCount(); j++)
					factorsComparisonMatrix[i][j] = factorsComparisonMatrixJson
							.getJSONArray(i).getDouble(j);
			problem.setMatrix(factorsComparisonMatrix);
			for (int s = 0; s < problem.getFactorsCount(); s++) {
				JSONArray matrixForFactorsJson = obj.getJSONObject(
						"factorsValue").getJSONArray(factors.get(s).getName());
				double[][] matrixForFactors = new double[problem
						.getAlternativesCount()][problem.getAlternativesCount()];
				for (int i = 0; i < problem.getAlternativesCount(); i++)
					for (int j = 0; j < problem.getAlternativesCount(); j++)
						matrixForFactors[i][j] = matrixForFactorsJson
								.getJSONArray(i).getDouble(j);
				problem.setMatrixForFactor(factors.get(s).getCode(),
						matrixForFactors);
			}
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return problem;
	}
}
