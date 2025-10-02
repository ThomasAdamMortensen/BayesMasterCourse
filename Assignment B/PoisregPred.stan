
data {
  int<lower=1> N;
  int<lower=0> y[N];
  int<lower=1> K;
  matrix[N,K] X;
  vector[K] mu;
  cov_matrix[K] sigma;
  int<lower=1>N_new;
  matrix[N_new, K] X_new; # Note that we have written this as if the new value was more than one observation, for one obs matrix is not necessary but good to learn ig :)
}

parameters {
  vector[K] beta;
}

model {
  beta ~ multi_normal(mu, sigma);
  y ~ poisson_log(X * beta);
}

generated quantities{
  int<lower=0> y_new[N_new];
  for (n in 1:N_new){
    y_new[n] = poisson_log_rng(X_new[n] * beta);
  }
}
