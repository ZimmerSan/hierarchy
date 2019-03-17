package com.primat.hierarchy.service;

import com.primat.hierarchy.model.Alternative;
import com.primat.hierarchy.model.Factor;
import com.primat.hierarchy.model.Problem;

import java.util.ArrayList;

public class HelperService {

    public static double[][] reflectMatrix(double[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix.length; j++) {
                if (i > j) matrix[i][j] = 1/matrix[j][i];
            }
        }

        return matrix;
    }

    public static ArrayList<Factor> initializeFactors(final int size) {
        ArrayList<Factor> factors = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            factors.add(new Factor("F_" + (i+1)));
        }
        return factors;
    }

    public static ArrayList<Alternative> initializeAlternatives(final int size) {
        ArrayList<Alternative> alternatives = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            alternatives.add(new Alternative("A_" + (i+1)));
        }
        return alternatives;
    }

    public static double[] findLocalPriorities(double[][] matrix) {
        double sum = 0;
        for (double[] aMatrix : matrix) sum += geometricalMean(aMatrix);

        double[] priorities = new double[matrix.length];
        for (int i = 0; i < priorities.length; i++) {
            priorities[i] = geometricalMean(matrix[i]) / sum;
        }

        return priorities;
    }

    public static double geometricalMean(double[] array) {
        double product = 1.0;
        for (double anArray : array) product *= anArray;
        return Math.pow(product, 1.0 / array.length);
    }

    public static Problem initProblem() {
        Problem problem = new Problem();

        problem.setName("Best House Choice");
        problem.setAlternativesCount(3);
        problem.setFactorsCount(4);

        ArrayList<Factor> factors = HelperService.initializeFactors(problem.getFactorsCount());
        factors.get(0).setName("Size");
        factors.get(1).setName("Transport");
        factors.get(2).setName("Condition");
        factors.get(3).setName("Price");
        problem.setFactors(factors);

        ArrayList<Alternative> alternatives = HelperService.initializeAlternatives(problem.getAlternativesCount());
        alternatives.get(0).setName("House A");
        alternatives.get(1).setName("House B");
        alternatives.get(2).setName("House C");
        problem.setAlternatives(alternatives);

        double[][] factorsComparisonMatrix = new double[problem.getFactorsCount()][problem.getFactorsCount()];
        factorsComparisonMatrix[0][1] = 5;
        factorsComparisonMatrix[0][2] = (double)1/3;
        factorsComparisonMatrix[0][3] = (double)1/4;
        factorsComparisonMatrix[1][2] = (double)1/5;
        factorsComparisonMatrix[1][3] = (double)1/7;
        factorsComparisonMatrix[2][3] = (double)1/2;
        problem.setMatrix(factorsComparisonMatrix);

        problem.setMatrixForFactor(factors.get(0).getCode(), new double[][]{
                {1, 5, 9},
                {1.0 /5, 1, 4},
                {1.0 /9, 1.0/4, 1.0}
        });

        problem.setMatrixForFactor(factors.get(1).getCode(), new double[][]{
                {1.0, 4.0, 1.0/5},
                {1.0 /4, 1.0, 1.0/9},
                {5.0, 9.0, 1.0}
        });

        problem.setMatrixForFactor(factors.get(2).getCode(), new double[][]{
                {1.0, 1.0/2, 1.0/2},
                {2.0, 1.0, 1.0},
                {2.0, 1.0, 1.0}
        });

        problem.setMatrixForFactor(factors.get(3).getCode(), new double[][]{
                {1.0, 500.0/1000, 700.0/1000},
                {1000.0/500, 1.0, 700.0/500},
                {1000.0/700, 500.0/700, 1.0}
        });

        return problem;
    }
    
}
