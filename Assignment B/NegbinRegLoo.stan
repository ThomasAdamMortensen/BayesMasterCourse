
data {
  int<lower=1> N;
  int<lower=0> y[N];
  int<lower=1> K;
  matrix[N,K] X;
  vector[K] mu;
  cov_matrix[K] sigma;
}

parameters {
  vector[K] beta;
  real<lower=0> phi;
}

model {
  beta ~ multi_normal(mu, sigma);
  y ~ neg_binomial_2_log(X * beta, phi);
}

generated quantities{
  vector[N] log_lik;
  for (n in 1:N){
    log_lik[n] = neg_binomial_2_log_lpmf(y[n] | X[n] * beta, phi);
  }
}
