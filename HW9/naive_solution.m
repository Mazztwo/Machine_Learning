
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
    
    % The number of words in the sentence 
    num_words = size(sent,2);
    
    % NOT CONSIDERING TRANSITION TO END STATE 
    % The number of words in the sentence + the start state.
    num_states = num_words + 1;
 
    % Possible states in the sequence. Does not consider state 6, the end
    % state.
    possible_states = [1 2 3 4 5];
    
    % Get all possible sequences of len of sentence
    sequences = permn(possible_states, num_states);
    
    % The total number of possible sequences of length of sentence
    num_sequences = size(sequences,1);
    
    % Consider all possible state sequences of length of sentence sent
    for curr_seq = 1:num_sequences
        
        % current sequence
        s = sequences(curr_seq, : );
        
        % Compute probability of a given state sequence from A
        state_transition_probability = 1;
        for row = 1:num_states
            % Can do this because I know that none of my sentences are less
            % than two words. Bad practice otherwise!
            col = row + 1;
            
            if ( col > num_states )
                break
            end
            
            start_state = s(row);
            end_state = s(col);
            
            state_transition_probability = state_transition_probability * A(start_state, end_state);
           
        end
        
        % Compute probability of generating sent in each of the
        % corresponding states in the sequence. Skip first state of state
        % sequence as this corresponds to start state.
        observation_probability = 1;
        for r = 1:num_words
            
            % Skip start state
            state = s(r+1);
            
            % Skip state 1
            if ( state == 1)
                continue
            end
           
            word = sent(r);
            
            % note we skip start/end states here so B(1, :) correponds to A(2, :)
            observation_probability = observation_probability * B (state-1, word);
        end
        
        % Add probability of seeing sent given the state sequence to prob
        prob_temp = state_transition_probability * observation_probability;
        prob = prob + prob_temp;    
        
    end
  
end 


