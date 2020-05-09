function testesinv()

%definir os problemas existentes
problemas = [100,100,100,100,200,200,200,200,300,300,300,300,400,400,400,400,500,500,500,500;10,20,30,40,20,40,60,80,30,60,90,120,40,80,120,160,50,100,150,200;];
%cada 2 linhas de resultado representarão um método e cada 10 colunas os
%tempos para 1 instância
resultado = zeros(5*2,size(problemas,2)*10);

instancias = 1:(size(problemas,2));

string = '';

%para todas as instâncias como parametro
for i = fliplr(instancias);

    %abrir o problema
    cd instancias;
    fid = open(['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)), '.mat']);
    problema = fid.problema;
    cd ..;
   
    string = [string, 'Instância ',num2str(i), char(10)];
    clc;
    disp(string);
    
    
    %para todos os métodos de busca ILS e EE
    for metodo=fliplr(1:5)

        if (metodo < 5)
            string = [string, 'ILS',num2str(metodo), char(10)];
        else
            string = [string, 'EE', char(10)];
        end
        clc;
        disp(string);
        
        %rodará 10 vezes
        for j=1:10

            string = [string, ' * '];
            clc;
            disp(string);
            
            %rodar a heurística 10 vezes calculando o tempo
            tic;
            if (metodo < 5)
                [ignore, resultado((metodo-1)*2+2,(i-1)*10+j)] = ils(problema, metodo, 1, 60*5);
            else
                disp('Estratégia Evolutiva');
                [ignore, resultado((metodo-1)*2+2,(i-1)*10+j)] = ee(problema,1,5*60);
            end

            resultado((metodo-1)*2+1,(i-1)*10+j) = toc;

            save('resultados.mat', 'resultado');

        end
        
        string = [string, char(10)];

    end
    
    string = '';
    for j=1:i
        string = [string, 'Instância ', num2str(j), ' OK', char(10)];
    end

end

clc;
disp(string);

end