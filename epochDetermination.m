function [ epochNum ] = epochDetermination( T, Toe )
% This function sifts through the epoch times and restores various epochs, 
% in incrementing order from 1 to n+1. The amount of increments will be the
% amount of different epochs recorded.

cycle=0;j=0;

% Initial time from reference epoch
tk = T-Toe;
tk_selective = tk; 

% Set the value to close the loop on (max epoch time)
cutValue = max(tk_selective);

% Creates new variable epochNum
while min(tk_selective) > 0;
    tk_selectiveMin = min(tk_selective);
    tk_selective = 0; % Resets this variable to zero for recreation
    j=0; % Resets j to zero
    cycle=cycle+1; % Increases the epoch cycle by one
    for i = 1:length(tk);
        if tk(i) == tk_selectiveMin;
            epochNum(i) = cycle;
        else
            j=j+1;
            tk_selective(j) = tk(i); % Creates new tempary tk variable with later unprocessed epochs only
        end
    end
    % Tests for the cut value to end the loop
    if tk_selectiveMin == cutValue;
        break;
    end
end 