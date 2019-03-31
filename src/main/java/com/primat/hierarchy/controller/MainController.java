package com.primat.hierarchy.controller;

import com.primat.hierarchy.dto.MatrixForm;
import com.primat.hierarchy.model.Alternative;
import com.primat.hierarchy.model.Factor;
import com.primat.hierarchy.model.Problem;
import com.primat.hierarchy.service.HelperService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

import java.util.ArrayList;
import java.util.Optional;

@Controller("/")
public class MainController {

	public static final String PROBLEM_KEY = "problem";

	private Problem problem = null;

	@GetMapping("/")
	public ModelAndView showBasicInfo(
			@Valid @RequestParam(value = "file", defaultValue = "") String fileName) {
		if (fileName.length() != 0)
			problem = HelperService.initProblemFromFile(fileName);
		else
			problem = HelperService.initProblem();
		return new ModelAndView("start", PROBLEM_KEY, problem);
	}

	@PostMapping("/")
	public String enterBasicInfo(
			@Valid @ModelAttribute(PROBLEM_KEY) Problem problem,
			BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "error";
		}

		if (this.problem.getName() != problem.getName())
			this.problem.setName(problem.getName());
		if (this.problem.getFactorsCount() != problem.getFactorsCount()
				|| this.problem.getAlternativesCount() != problem
						.getAlternativesCount()) {
			this.problem.setAlternativesCount(problem.getAlternativesCount());
			this.problem.setFactorsCount(problem.getFactorsCount());
			ArrayList<Factor> factors = HelperService.initializeFactors(problem
					.getFactorsCount());
			ArrayList<Alternative> alternatives = HelperService
					.initializeAlternatives(problem.getAlternativesCount());
			this.problem.setFactors(factors);
			this.problem.setAlternatives(alternatives);
			double[][] initComparisonMatrix = new double[problem
					.getFactorsCount()][problem.getFactorsCount()];
			for (int i = 0; i < problem.getFactorsCount(); i++)
				for (int j = 0; j < problem.getFactorsCount(); j++)
					initComparisonMatrix[i][j] = 0;
			this.problem.setMatrix(initComparisonMatrix);
			for (int s = 0; s < problem.getFactorsCount(); s++) {
				double[][] initPrioritiesMatrix = new double[problem
						.getAlternativesCount()][problem.getAlternativesCount()];
				for (int i = 0; i < problem.getFactorsCount(); i++)
					for (int j = 0; j < problem.getFactorsCount(); j++)
						initPrioritiesMatrix[i][j] = 0;
				this.problem.setMatrixForFactor(this.problem.getFactors()
						.get(s).getCode(), initPrioritiesMatrix);
			}
		}

		return "redirect:enterFactors";
	}

	@GetMapping("/enterFactors")
	public ModelAndView showEnterFactors() {
		Problem problemModel = this.problem;

		if (CollectionUtils.isEmpty(problemModel.getFactors())
				|| problemModel.getFactorsCount() != problemModel.getFactors()
						.size())
			problemModel.setFactors(HelperService
					.initializeFactors(problemModel.getFactorsCount()));

		return new ModelAndView("factors", PROBLEM_KEY, problemModel);
	}

	@PostMapping("/enterFactors")
	public String enterFactors(
			@Valid @ModelAttribute(PROBLEM_KEY) Problem problem,
			BindingResult result, ModelMap model) {
		if (result.hasErrors())
			return "error";

		this.problem.setFactors(problem.getFactors());

		return "redirect:enterAlternatives";
	}

	@GetMapping("/enterAlternatives")
	public ModelAndView showEnterAlternatives() {
		Problem problemModel = this.problem;

		if (CollectionUtils.isEmpty(problemModel.getAlternatives())
				|| problemModel.getAlternativesCount() != problemModel
						.getAlternatives().size())
			problemModel
					.setAlternatives(HelperService
							.initializeAlternatives(problemModel
									.getAlternativesCount()));

		return new ModelAndView("alternatives", PROBLEM_KEY, problemModel);
	}

	@PostMapping("/enterAlternatives")
	public String enterAlternatives(
			@Valid @ModelAttribute(PROBLEM_KEY) Problem problem,
			BindingResult result, ModelMap model) {
		if (result.hasErrors())
			return "error";

		this.problem.setAlternatives(problem.getAlternatives());

		return "redirect:enterMatrix";
	}

	@GetMapping("/enterMatrix")
	public ModelAndView showEnterMatrix() {
		Problem problemModel = this.problem;

		if (problemModel.getMatrix() == null)
			problemModel
					.setMatrix(new double[problemModel.getFactorsCount()][problemModel
							.getFactorsCount()]);

		return new ModelAndView("matrix", PROBLEM_KEY, problemModel);
	}

	@PostMapping("/enterMatrix")
	public String enterMatrix(
			@Valid @ModelAttribute(PROBLEM_KEY) Problem problem,
			BindingResult result, ModelMap model) {
		if (result.hasErrors())
			return "error";

		double[][] matrix = HelperService.reflectMatrix(problem.getMatrix());
		this.problem.setMatrix(matrix);
		double[] localPriorities = HelperService.findLocalPriorities(matrix);
		this.problem.setPrioritiesVector(Problem.FACTORS_KEY, localPriorities);

		return "redirect:enterFactorMatrices?factor="
				+ this.problem.getFactors().get(0).getCode();
	}

	@GetMapping("/enterFactorMatrices")
	public ModelAndView showEnterFactorMatrices(
			@RequestParam("factor") String factorKey, ModelMap model)
			throws Exception {
		Optional<Factor> factorOptional = this.problem.getFactors().stream()
				.filter(factor -> factor.getCode().equals(factorKey))
				.findFirst();
		if (factorOptional.isPresent()) {
			Factor factor = factorOptional.get();
			double[][] matrix = this.problem.getMatrixForFactor(factor
					.getCode());

			model.addAttribute(PROBLEM_KEY, problem);
			model.addAttribute("factor", factor);
			model.addAttribute(
					"form",
					new MatrixForm(factorKey,
							matrix != null ? matrix : new double[problem
									.getAlternativesCount()][problem
									.getAlternativesCount()]));

			return new ModelAndView("factorMatrices", model);
		} else
			throw new Exception("Factor with entered code's not found");
	}

	@PostMapping("/enterFactorMatrices")
	public String enterFactorMatrices(
			@Valid @ModelAttribute("form") MatrixForm form, BindingResult result) {
		if (result.hasErrors())
			return "error";

		double[][] matrix = HelperService.reflectMatrix(form.getMatrix());
		this.problem.setMatrixForFactor(form.getKey(), matrix);
		this.problem.setPrioritiesVector(form.getKey(),
				HelperService.findLocalPriorities(matrix));

		return this.problem.getFirstFactorWithoutPrioritiesVector()
				.map(f -> "redirect:enterFactorMatrices?factor=" + f.getCode())
				.orElse("redirect:calculate");
	}

	@GetMapping("/calculate")
	public ModelAndView showCalculate(ModelMap model) {

		double[][] matrix = new double[problem.getFactorsCount()][problem
				.getAlternativesCount()];

		for (int i = 0; i < problem.getFactors().size(); i++) {
			String code = problem.getFactors().get(i).getCode();
			double[] prioritiesVector = problem.getPrioritiesVector(code);
			matrix[i] = prioritiesVector;
		}

		double[] factorPrioritiesVector = problem
				.getPrioritiesVector(Problem.FACTORS_KEY);
		double[] globalPriorities = new double[problem.getAlternativesCount()];
		for (int i = 0; i < problem.getAlternativesCount(); i++) {
			globalPriorities[i] = 0;
			for (int j = 0; j < problem.getFactorsCount(); j++) {
				globalPriorities[i] += matrix[j][i] * factorPrioritiesVector[j];
			}
		}

		model.addAttribute(PROBLEM_KEY, problem);
		model.addAttribute("matrix", matrix);
		model.addAttribute("globalPriorities", globalPriorities);

		return new ModelAndView("calculate", model);
	}

	@PostMapping("/saveInfoToFile")
	public String saveInfoToFile() {
		HelperService.saveInfoToFile(this.problem);
		return "redirect:/";
	}

	@PostMapping("/getInfoAboutFile")
	public String getInfoAboutFile(@RequestParam("file") String fileName) {
		return "redirect:/?file=" + fileName;
	}
}
