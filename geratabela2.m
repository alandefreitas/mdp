function geratabela2( resultado )

problemas = [100,100,100,100,200,200,200,200,300,300,300,300,400,400,400,400,500,500,500,500;10,20,30,40,20,40,60,80,30,60,90,120,40,80,120,160,50,100,150,200;];

string = '';
string2 = '';
%para cada instância
for i=1:20
    if (mod(i-1,4) == 0)
        string = [string, '\hline ', char(10)];
    end
    string = [string, num2str(i), ' & '];
    %abre a instancia
    cd instancias;
    fid = open(['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)), '.mat']);
    problema = fid.problema;
    cd ..;
    string = [string, num2str(problema.n), ' & '];
    string = [string, num2str(problema.m), ' & '];
    string2 = [string2, num2str(problema.fo_max/2), ' & '];
    string = [string, num2str(mean(resultado(1,(i-1)*10+1:i*10))/60), ' & '];
    string = [string, num2str(mean(resultado(3,(i-1)*10+1:i*10))/60), ' & '];
    string = [string, num2str(mean(resultado(5,(i-1)*10+1:i*10))/60), ' & '];
    string = [string, num2str(mean(resultado(7,(i-1)*10+1:i*10))/60), ' & '];
    string = [string, num2str(mean(resultado(9,(i-1)*10+1:i*10))/60), ' \\', char(10)];
end

disp(string);

disp(string2);


end

