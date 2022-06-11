function [dict_num,len] = myHuffmanDict(symbols,freq_prob)
N=length(symbols);
nodes={1:N};
% dict_sym={1,N}; % η πρώτη στήλη περιέχει τα σύμβολα
dict_num={1,N}; % η πρώτη στήλη περιέχει νούμερα [1:N]
S(1:N,1:N)=-1;
row=1;
for i=1:N
    nodes(i,1)={symbols(i)}; % δημιουργία ενός cell (dictionary) που
    nodes(i,2)={freq_prob(i)}; % περιέχει τα σύμβολα και τις πιθανότητες
end

while true
    if nodes{1,2}==1 % όταν η πιθανότητα γίνεται 1 κάνει break
        break
    end
    nodes=sortrows(nodes,(2)); % ταξινόμηση βάσει πιθανότητας

    left=nodes(1,:); % επιλέγω τα δύο σύμβολα με την
    right=nodes(2,:); % μικρότερη πιθανότητα
    
    left_huff = 1; % τα χρησιμοποιώ για να γεμίσω τον πίνακα S
    right_huff = 0; % με 0 και 1
    
    new_prob=left{1,2}+right{1,2}; % νέα πιθανότητα των 2 μικρότερων συμβόλων
    new_symbol=[left{1,1},right{1,1}]; % νέο "σύμβολο"

    nodes(1,:)=[]; % διαγράφω το στοιχείο με την μικρότερη πιθανότητα και
    nodes(1,1)={new_symbol}; % αντικαθιστώ το αμέσως επόμενο με το αποτέλεσμα
    nodes(1,2)={new_prob}; % τον δυο μικρότερων πιθανοτήτων και συμβόλων
    
    len_l_symbol=length(left{1}); % μέγεθος που cell array που 
    len_r_symbol=length(right{1}); % χρησιμοποιείται για τα σύμβολα

    l=left{1}; % παίρνω το πρώτο μερος απο το cell array
    r=right{1}; % που περιέχει ένα πίνακα με τα σύμβολα

    for i=1:len_l_symbol
        for j=1:N
            if l(i)==symbols(j) % index του συμβόλου
                index_symbol=j;
            end
        end
        for k=1:N 
            if k==index_symbol % βάζω 1 στην θέση που βρίσκεται
                S(row,k)=left_huff; % το σύμβολο
            end
        end
    end
    for i=1:len_r_symbol
        for j=1:N
            if r(i)==symbols(j) % index του συμβόλου
                index_symbol=j;
    
            end
        end
        for k=1:N
            if k==index_symbol % βάζω 0 στην θέση που βρίσκεται
                S(row,k)=right_huff; %  το σύμβολο
            end
        end
    end
    row=row+1; % μετρητής γραμμών του S

end
for i=1:N 
    temp=[];
    for j=N-1:-1:1
        if S(j,i)~=-1 % παίρνω την ακολουθία απο το S για να δημιουργήσω
            temp=[temp,S(j,i)]; % το ζητούμενο dictionary (dict)
        end
    end
    % dict_sym(i,1)={char(97+i-1)}; % dict με δυο στήλες, η πρώτη τα σύμβολα
    % dict_sym(i,2)={temp}; % και η δεύτερη η αναπαράσταση απο bits
    
    dict_num(i,1)={i}; % βάσει της συνάρτησης θα στείλω αυτό που έχει
    dict_num(i,2)={temp}; % στη πρώτη στήλη νούμερα 
end

% dict_sym(27,1)={char(32)};

len=0;
for i=1:N
    len=len+length(dict_num{i,2})*freq_prob(i); % υπολογισμός του L
end
end
