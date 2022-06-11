%----------------------open file-------------------------------------------
file = fopen('cvxopt.txt','r'); % άνοιγμα του txt αρχείου για ανάγνωση
while true
    tline = fgetl(file);
    if ~ischar(tline), break, end
    text=tline; % καταχώρηση του κειμένου της πρώτης γραμμής
end
fclose(file);

%------------------frequency propability-----------------------------------
N=length(text); % μήκος του κειμένου
freq=zeros(1,27); % αρχικοποίηση ενός vector για τις συχνότητες
token=double(text); % μετατροπή των χαρακτήρων του κειμένου βάσει του ascii

k=1;
for i=97:122 % ascii από το a-(97) μέχρι το z-(122)
    count=0; % μετρητής, αρχοκοποιείται κάθε φορά στο 0 για κάθε σύμβολο
    for j=1:N
        if (token(j)==i) % κάθε φορά που βρίσκει το αντίστοιχο i
            count=count+1;
        end
    end
    freq(k)=count; % αντιστοίχηση των γραμμάτων a:z freq(1):freq(26)
    k=k+1;
end
freq(k)=0; % freq(27) είναι τα κενά (space)
for i=1:6184
    if token(i)==32
        freq(k)=freq(k)+1;
    end
end

freq_prob=zeros(1,27); % πιθανότητα εμφάνισης
symbols=""; % τα σύμβολα a:z και το κενό (space)
X=zeros(1,27);
total_freq_prob=0;
for i=1:27
    freq_prob(i)=freq(i)/N; % εύρεση πιθανότητας εμφάνισης συμβόλου
    total_freq_prob=total_freq_prob+freq_prob(i);
    symbols(i)=char(97+i-1); % γέμισμα a:z σε ascii
    X(i)=i;
end
symbols(27)=char(32); % προσθέτω το κενό (space) σε ascii;

%--------------------huffmandict-------------------------------------------
[my_dict,len]=myHuffmanDict(symbols,freq_prob); 

entropy=0; % υπολογισμός εντροπίας
for i = 1:27
    entropy=entropy-(freq_prob(i)*log2(freq_prob(i)));
end

nn=entropy/len; % απόδοση βάσει την συνάρτησης myHuffmanDict

%----------------------huffmanenco-----------------------------------------
testSample = randsrc(50,1,X); % δημιουργία 50 τυχαίων συμβόλων

enco = huffmanenco(testSample,my_dict); % έτοιμη συνάρτηση huffman
my_enco = myHuffmanEnco(testSample,my_dict);

Success_enco=false;
if length(enco)==length(my_enco) % σύγκριση μεγεθών συναρτήσεων
    Success_enco=true;
end
for i=1:length(enco) % σύγκριση τιμών συναρτήσεων
    if enco(i)~=my_enco(i)
        Success_enco=false;
    end
end

%----------------------huffmandeco-----------------------------------------
sig = huffmandeco(enco,dict); % έτοιμη συνάρτηση huffman
my_sig = myHuffmanDeco(my_enco,my_dict,X);

Success_deco=false;
if length(sig)==length(my_sig) % σύγκριση μεγεθών συναρτήσεων
    Success_deco=true;
end
for i=1:length(my_sig) % σύγκριση τιμών συναρτήσεων και για τις δύο
    if my_sig{i,1}==testSample(i) && sig(i)==testSample(i)
        Success_deco=true;
    end
end

%----------------------source B--------------------------------------------
load("cameraman.mat");
cameraman=conj(i);
max=0;
min=1000;
for i=1:256 % εύρεση του μεγαλύτερου και του μικρότερου στοιχείου
    for j=1:256
        if max<cameraman(i,j)
            max=cameraman(i,j);
        end
        if min>cameraman(i,j)
            min=cameraman(i,j);
        end
    end
end
k=1;
i_len=max-min+1; % αριθμός συμβόλων
i_cell={i_len,2};
for i=1:i_len % γέμισμα της πρώτης στήλης με τα σύμβολα 7:253
    i_cell(i,1)={min+i-1}; 
end
for i=min:max % εύρεση συχνότητς εμφάνισης
    count=0; % μετρητής, αρχοκοποιείται κάθε φορά στο 0 για κάθε σύμβολο
    for j=1:length(cameraman)
        for jj=1:length(cameraman)
            if (cameraman(j,jj)==i) % κάθε φορά που βρίσκει το αντίστοιχο i
                count=count+1;
            end
        end
    end
    i_cell(k,2)={count}; % αντιστοίχηση των συμβόλων 7:253
    k=k+1; 
end
i_X=zeros(1,i_len);
i_prob=[];
i_symbols=[];
i_total_prob=0;
for i=1:i_len
    i_prob=[i_prob,i_cell{i,2}/(256*256)]; % πιθανότητα εμφάνισης
    i_symbols=[i_symbols,i_cell{i,1}]; % αντίστοιχο σύμβολο
    i_total_prob=i_total_prob+i_cell{i,2}/(256*256); % αθροισμα πιθανοτήτων
    i_X(i)=i;
end

[i_dict,i_avglen]=myHuffmanDict(i_symbols,i_prob);

i_entropy=0; % υπολογισμός εντροπίας
for i = 1:i_len
    i_entropy=i_entropy-(i_prob(i)*log2(i_prob(i)));
end

i_n=i_entropy/i_avglen;

i_testSample = randsrc(50,1,i_X); % δημιουργία 50 τυχαίων συμβόλων

i_enco = myHuffmanEnco(i_testSample,i_dict);

i_sig = myHuffmanDeco(i_enco,i_dict,i_X);

Success_i=false;
for i=1:length(i_sig) 
    if i_sig{i,1}==i_testSample(i)
        Success_i=true;
    end
end
