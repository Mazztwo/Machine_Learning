
% Inputs:
% the transition matrix A (from hmm_starter.m),
% the observation matrix B (from hmm_starter.m),
% N, the number of states,
% M, the number of words in the vocabulary, and
% sent, a vector of integers representing the sentence whose observation probability we want to compute.
% 
% Outputs:
% prob, the probability of observing the input sentence.



function [prob] = naive_solution(A,B,N,M,sent)

    % Prob is a running sum
    prob = 0;
    
    % NOT CONSIDERING TRANSITION TO END STATE 
    % The number of words in the sentence + the start state.
    num_states = size(sent,2) + 1;
    
    % Get all possible sequences of len of sentence
    sequences = permn(A, num_states);
    
    % Consider all possible state sequences of length of sentence sent
    for s = sequences
        
        % Compute probability of a given state sequence from A
        state_transition_probability = 1;
        for row = 1:num_states
            % Can do this because I know that none of my sentences are less
            % than two words. Bad practice otherwise!
            col = 2;
            
            start_state = s(row);
            end_state = s(col);
            
            state_transition_probability = state_transition_probability * A(start_state, end_state);
            
            col = col + 1;
            
            if ( col > num_states )
                break
            end
        end
        
        % Compute probability of generating sent in each of the
        % corresponding states in the sequence. Skip first state of state
        % sequence as this corresponds to start state.
        observation_probability = 1;
        for r = 1:num_states-1
            state = s(r+1);
            
            % Skip state 1
            if ( state == 1)
                continue
            end
           
            word = sent(r);
            
            observation_probability = observation_probability * B (state, word);
        end
        
        % Add probability of seeing sent given the state sequence to prob
        prob_temp = state_transition_probability * observation_probability;
        prob = prob + prob_temp;    
        
    end
  
end 


