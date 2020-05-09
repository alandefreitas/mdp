function resultado = testescons(  )

%definir os problemas existentes
problemas = [100,100,100,100,200,200,200,200,300,300,300,300,400,400,400,400,500,500,500,500;10,20,30,40,20,40,60,80,30,60,90,120,40,80,120,160,50,100,150,200;];
%cada linha de resultado representará um método e cada 100 colunas os
%tempos para 1 instância
resultado = zeros(3,100);

resultado = '';

%para apenas uma instância
if (nargin == 0) meta = 0.9; end
if (nargin < 2) instancias = 1:(size(problemas,2)); end

%para todas as instâncias como parametro
for i = instancias;
    
   if (mod(i-1,4)==0)
        resultado = [resultado,'\hline',char(10)];
   end

   %abrir o problema
   cd instancias;
   fid = open(['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)), '.mat']);
   problema = fid.problema;
   cd ..;

   %resolve com a heurística construtiva
   s = solucaoinicial(problema);
   s_fo = fo(problema,s);
   
   resultado = [resultado, num2str(i), ' & ', num2str(problema.n), ' & ', num2str(problema.m), ' & ', num2str(s_fo/2), ' & ', num2str(problema.fo_max/2), ' & ', num2str((1 - s_fo/problema.fo_max)*100), '\% \\', char(10)]; 
   clc; 
   disp(resultado);
   
end

end