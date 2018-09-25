%% Example of Monte Carlo error estimate
% Author: Oliver Sheridan-Methven, September 2018.
% 
% For Monte Carlo methods we estimate a quantity by associating its
% value to some corresponding expectation, and then estimate this 
% expected value by simulating many random instances and taking the
% average. 
%

%% Hidding code
%
%
% We probably don't want to show the author all the code we wrote, but 
% maybe a few very choice snippets. To achieve this set the 
% **include code** option to |false| in the publishing options. 

%% Unbiased estimators
% 
% The typical unbiased estimator that we use for the mean $\mu$ is the the
% emprical average $\hat{\mu}$ where 
% 
% $$\hat{\mu} = \frac{1}{N}\sum_{i=1}^N X_i $$
% 
% where $\hat{\mu}$ is unbiased because $E(\hat{\mu}) = \mu$.

%%
N = 10000; % Number of samples
pi_mean = 0.0;
pi_exact = pi;

for i=1:N
   x = rand();
   y = rand();
   pi_mean =  pi_mean + ((x^2 + y^2) <= 1.0);
end

pi_mean = pi_mean * 4.0 / N;
pi_error = pi_mean - pi_exact;

%% Error in the estimates 
% If we want to show the user some results (as we likely do), then it is
% helpful to plot these.

M = 24;
x = zeros(1,M);
y = zeros(1,M);
for i=1:M
    N = 2^i;
    x(i) = N;
    y(i) = abs(mean(((rand(1,N).^2 + rand(1,N).^2) <= 1.0)) * 4 - pi);
end
loglog(x,y)
title('Error in Monte Carlo estimate of \pi')
xlabel('Number of samples')
ylabel('Absolute error')

%
% General code comments (not for the reader) are hidden by not opening them
% with a leading double %% symbol. 
% 

%%
% We can see from this that as we increase the number of samples to around 
% a million we have an answer correct to about 4 decimal places. Hence, 
% while this works, it is not very efficient. 

%% More markdown features
% For more features please familiarise yourself with
% <https://ch.mathworks.com/help/matlab/matlab_prog/marking-up-matlab-comments-for-publishing.html>
