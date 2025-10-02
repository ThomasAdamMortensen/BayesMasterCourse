
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
}

model {
  beta ~ multi_normal(mu, sigma);
  y ~ poisson_log(X * beta);
}

generated quantities{
  vector[N] log_lik;
  for (n in 1:N){
    log_lik[n] = poisson_log_lpmf(y[n] | X[n] * beta);
  }
}
