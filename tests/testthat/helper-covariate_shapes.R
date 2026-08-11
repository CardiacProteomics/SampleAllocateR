# Covariate shapes used to parameterise the type-sensitive tests.
# Covariate handling branches on whether continuous and categorical covariates
# are present, so any test asserting on covariate-derived output should run
# against all three shapes rather than the mixed case alone.

covariate_shapes <- list(
  continuous_only = c("age_at_baseline", "bmi_at_baseline"),
  categorical_only = c("sex", "treatment"),
  mixed = c("age_at_baseline", "bmi_at_baseline", "sex")
)
