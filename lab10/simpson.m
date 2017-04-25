function [ I ] = simpson( Y, a, b, n )
%SIMPSON's rule integration.
%   Performs SIMPSON's rule integration for a desired function between a
%   and b. The integration routine handles single integrals of a single
%   dimensional function.
%
%   SIMPSON(Y,a,b) where Y is a vector estimates the integral using the
%   data in Y assuming equally spaced points between A and B.  Requires a
%   vector with an odd number of elements, which corresponds to an even
%   number of regions.
%   SIMPSON(f,a,b) where f is a function will estimate the integral between
%   a and b with four regions.
%   SIMPSON(f,a,b,n) where f is a function will estimate the integral
%   between a and b with n regions, where n is an even number.
%
%   I = SIMPSON(...) is the estimated integral
%
%   Examples:
%
%   I = SIMPSON(@(x.^2),0,1,10);
%
%   is equivalent to:
%
%   Y = linspace(0,1,11).^2;
%   I = SIMPSON(Y,0,1);

% Handle input arguments
if exist('Y','var') == 0, error('Must provide function or data');   end
if exist('a','var') == 0, error('Must provide integration bounds'); end
if exist('b','var') == 0, error('Must provide integration bounds'); end
if exist('n','var') == 0, n = 4;                                    end
if ~isnumeric(Y),         Y = Y(linspace(a,b,n+1));                 end
if mod(numel(Y),2) == 0,  error('requires even number of regions'); end
if isnan(a) || isnan(b),  error('nan in integraiton bounds');       end
if isinf(a) || isinf(b),  error('inf in integraiton bounds');       end

% Calculate h value for simpson's integration
h = (b-a)/(n*3);

% Estimate the integral using the vector Y of function data
I = h * (Y(1) + 2*sum(Y(2:2:end-2)) + 4*sum(Y(3:2:end-1)) + Y(end));

end