%% Approximation: Lab 8
%%%
% *Gwen Zapata*
%%%
% *ISC4220C*
%%
%% Football Team rankings
clear

%%%
% Each 1 represents a win for each team; each -1 represents a loss for each
% team.  0 indicates a team didn't play.
%
% The final row adds sufficient conditions to find a solution.
game_matrix = [
    1 -1  0  0
    0 -1  1  0
    1  0  0 -1
    0  0  1 -1
    0  1  0 -1
    1  1  1  1
];
%%%
% Construct column vector of game score differences where the last element
% is the total.
differences = [
    4 9 6 3 7 20
]';

%%%
% Use linear least squares to determine the ranking numbers for the teams:
rank = (game_matrix'*game_matrix) \ (game_matrix'*differences);

fprintf('T1\tT2\tT3\tT4\n');
fprintf('%g\t%g\t%g\t%g\n',rank(1),rank(2),rank(3),rank(4));
