function bateriadetestes( meta , instancias )

%definir os problemas existentes
problemas = [10,20,30,40,50,100,100,100,100,200,200,200,200,300,300,300,300,400,400,400,400,500,500,500,500;4,4,3,4,5,10,20,30,40,20,40,60,80,30,60,90,120,40,80,120,160,50,100,150,200;];
%cada linha de resultado representará um método e cada 100 colunas os
%tempos para 1 instância
resultado = zeros(3,100);


%para apenas uma instância
if (nargin == 0) meta = 1; end
if (nargin < 2) instancias = 1:(size(problemas,2)); end

%para todas as instâncias como parametro
for i = instancias;

    %para todos os métodos de busca
    for metodo=1:5

            %abrir o problema
            cd instancias;
            fid = open(['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)), '.mat']);
            problema = fid.problema;
            cd ..;

            %resultado armazenará o tempo gasto
            for j=1:100
                %rodar a heurística 100 vezes calculando o tempo
                resultado(metodo,j) = cputime;
                if (metodo <5)
                    ils(problema, metodo, meta);
                else
                    ee(problema, meta)
                resultado(metodo,j) = cputime - resultado(metodo,j);

                %organiza o vetor
                resultado(metodo,1:j) = sort(resultado(metodo,1:j));

                %imprime os resultados
                hold off;
                figure(1);
                fim = j;
                for k=1:metodo
                    if (k<metodo) %para método anteriores
                        if (k == 1)
                            plot([0,resultado(k,(1:100))], 0:100, 'k-');
                            hold on;
                        elseif (k == 2)
                            plot([0,resultado(k,(1:100))], 0:100, 'b-');
                        elseif (k == 3)
                            plot([0,resultado(k,(1:100))], 0:100, 'r-');
                        elseif (k == 4)
                            plot([0,resultado(k,(1:100))], 0:100, 'g-');
                        end
                    elseif (k==metodo) %para método corrente
                        if (k == 1)
                            plot([0,resultado(k,(1:fim))], 0:fim, 'k-');
                            hold on;
                        elseif (k == 2)
                            plot([0,resultado(k,(1:fim))], 0:fim, 'b-');
                        elseif (k == 3)
                            plot([0,resultado(k,(1:fim))], 0:fim, 'r-');
                        elseif (k==4)
                            plot([0,resultado(k,(1:fim))], (0:fim), 'g-');
                        end
                    end
                end 
                %coloca legendas
                if (metodo == 1)
                    h = legend('ILS_1',1);
                elseif (metodo == 2)
                    h = legend('ILS_1','ILS_2',2);
                elseif (metodo == 3)
                    h = legend('ILS_1','ILS_2','ILS_3',3);
                elseif (metodo > 3)
                    h = legend('ILS_1','ILS_2','ILS_3','ILS_4',3);
                end
                set(h,'Interpreter','none');
                xlabel('Tempo');
                ylabel('%');

            end

    end

    %%salva figura


    cd figuras
            nomedafigura = ['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)), 'meta', num2str(meta*100) ,'%.tif'];
            print('-dtiffnocompression',nomedafigura);
    cd ..

end

end