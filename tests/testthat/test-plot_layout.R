# plot_layout Tests
# Covariates must be classified by their own type, not by the type of every
# column in the layout: batch_allocation is itself a factor, which previously
# made the categorical branch run even when no categorical covariate was present.

for (shape in names(covariate_shapes)) {
  test_that(paste("plot_layout returns a plot per covariate type present:", shape), {
    set.seed(123)
    covariates <- covariate_shapes[[shape]]
    toy_data <- simulate_data(n_samples = 60, block_size = 1)[, c("sample_id", covariates)]

    plots <- plot_layout(
      allocate_samples(
        data = toy_data,
        method = "random",
        covariates = covariates,
        batch_size = 12,
        seed = 123
      ),
      covariates = covariates
    )

    expected_plots <- c(
      if (any(sapply(toy_data[covariates], is.numeric))) "continuous",
      if (any(sapply(toy_data[covariates], is.factor))) "categorical"
    )
    expect_setequal(names(plots), expected_plots)

    # the plots must also build, not merely be constructed
    lapply(plots, function(plot) expect_s3_class(ggplot2::ggplot_build(plot), "ggplot_built"))
  })
}
