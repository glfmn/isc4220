function v = randU(v0, N)
%%%
%  RANDU creates a uniform random distribution
%
%  Creates random distribution such that each successive triad of randomly
%    generated generated numbers lies in a distinct plane, and generates 
%    histogram and 3D plot to show those properties of the distribution.
%
%  Synopsis:
%    x = RANDU creates a vector of 10000 random numbers with a seed of 1
%    x = RANDU(v0) create vector of 10000 random numbers with a seed of v0
%    x = RANDU(v0,N) create vector of N random numbers with a seed of v0

if nargin < 1, v0 = 1;     end
if nargin < 2, N  = 10000; end

%% Generate the Random Numbers

v    = zeros(N, 1); % Preallocate to speed up algorithm
v(1) = v0; % Set the initial value of the distribution at first index

nextRand = @(x) mod(65539 .* x, 2^31);

for i = 2:N, v(i) = nextRand(v(i-1)); end

v = v/2^31; % Normalize for a range of [0,1)


%%% Check Uniformity
% Create the histogram to display and confirm uniformity of the
% distribution

hist(v)
title('Distribution of Random Numbers')

%%% Create and Plot Triads
% Truncate the array of random numbers and determine the number of triads 
% to proplery reshape the array so that each column corresponds exaclty to 
% a triad for easy plotting.

truncatedN = N - rem(N,3);
numTriads = truncatedN/3;

triads = reshape(v(1:truncatedN), 3, numTriads);
%%%
% Plot the triads to show that they lie in distinct planes
plot3(triads(1,:),triads(2,:),triads(3,:),'.')
title('Distribution of Triads of Random Numbers')

end
