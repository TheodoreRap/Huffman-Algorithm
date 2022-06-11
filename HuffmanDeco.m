function my_sig = myHuffmanDeco(my_enco,my_dict,X)
N=length(my_enco);
test_symbols=X;
test_bits={};
my_sig={};
temp=[];
k=1;

for i=1:length(X) % απο το dictionary παίρνω την δεύτερη στήλη που περιέχει τα 
    test_bits{i,1}=string(my_dict{i,2}); % bits και τα κάνω string array  
end % μέσα στο cell test_bits

for i=1:N    
    temp=[temp,string(my_enco(i))]; % string array που παίρνει ένα ένα τα 
                                    % στοιχεία του my_enco 
    for j=1:length(X)
        if length(temp)==length(test_bits{j,1}) % όταν τα arrays έχουν ίδιο
            if temp==test_bits{j,1} % μήκος γίνεται σύγκριση ώστε να βρεθεί 
                my_sig{k,1}=test_symbols(j); % στο cell array test_bits το
                k=k+1; % σύμβολο που έχει ίδια κωδικοποίηση
                temp=[]; % τελείωνω με αυτό το σύμβολο και μηδενίζω για
            end          % για να βρώ το επόμενο
        end
    end
end
end
