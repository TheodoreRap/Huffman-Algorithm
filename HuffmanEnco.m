function my_enco = myHuffmanEnco(testSample,my_dict)
N=length(testSample);
my_enco='';
k=1;
flag=false;
for z=1:N
    for i=1:length(my_dict)
        if my_dict{i,1}==testSample(z) % ξάχνω στο my_dict να βρώ το σύμβολο
            temp=my_dict{i,2}; % που είναι στην πρώτη στήλη και όταν το βρω
            flag=true; % εκχωρώ τα bits που το αντιπροσωπεύουν στην temp
        end
        if flag==true % αν έχει βρεθεί το σύμβολο στο my_dict, παίρνω την
            lenTemp=length(temp); % ακολουθία απο τα bits και τα βάζω 
            for j=1:lenTemp % γραμμη-γραμμή απο πάνω προς τα κάτω για να 
                my_enco(k,:)=string(temp(j)); % έχω το ίδιο αποτέλεσμα
                k=k+1; % με την έτοιμη huffmanenco
            end
        end
        flag=false;
    end
end
my_enco=str2num(my_enco); % επιστρέφω το αποτέλεσμα στην μορφή αριθμών 0-1
end
