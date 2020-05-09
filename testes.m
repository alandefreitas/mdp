function testes()
%faz a tabela de resultados

%definir os problemas existentes
%problemas = [100,100,100,100,200,200,200,200,300,300,300,300,400,400,400,400,500,500,500,500;10,20,30,40,20,40,60,80,30,60,90,120,40,80,120,160,50,100,150,200;];
problemas = [100,200,300,400,500;10,20,30,40,50;];
lista_mu = [1,10,30,50];
n_instancias = size(problemas,2);
lista_lambda = [1,2,5,10];
n_mu = 4;
n_lambda = 4;
n_replicacoes = 10;
total_de_testes = n_instancias*n_mu*n_lambda*n_replicacoes;


%cada 2 linhas de resultado representar�o um m�todo e cada 10 colunas os
%tempos para 1 inst�ncia
filename = ['resultados',num2str(n_instancias),'_',num2str(n_mu),'_',num2str(n_lambda),'_',num2str(n_replicacoes),'.mat'];
filename2 = ['ordem',num2str(n_instancias),'_',num2str(n_mu),'_',num2str(n_lambda),'_',num2str(n_replicacoes),'.mat'];
%cria tabela de resultados
if ~(exist(filename)==2)
    tempo = inf(n_replicacoes,n_instancias, n_mu, n_lambda);
    sucesso = inf(n_replicacoes,n_instancias, n_mu, n_lambda);
    resultados = inf(n_replicacoes,n_instancias, n_mu, n_lambda);
    save(filename, 'tempo', 'sucesso', 'resultados');
    %ordem em que os experimentos ser�o executados
    ordem = randperm(total_de_testes);
    %qual o pr�ximo teste a ser executado
    pos = 1;
    save(filename2, 'ordem', 'pos');
%ou carrega o arquivo se este j� existe
else
    load(filename);
    load(filename2);
end




%para todas as condi��es ainda n�o testadas
for i = pos:total_de_testes;

    
    %%Converter o n�mero ordem(i) em uma combina��o de fatores
    num = ordem(i);
    %n�mero m�ximo para este fator
    num_max = total_de_testes;
    %n�mero de observa��es para cada n�vel de instancia
    num_obs = num_max./n_instancias;
    %dividindo num_max e fatias de num_obs, num est� em qual fatia?
    num_instancia = ceil((num./num_max).*n_instancias);
    instancia = problemas(:,num_instancia);
    %num passa a ser o n�mero num antigo dentro da fatia existente
    num = mod(num-1,num_obs)+1;
    %n�mero m�ximo para o pr�ximo fator � o tamanho da fatia do �ltimo
    num_max = num_obs;
    %n�mero de observa��es para cada n�vel de instancia
    num_obs = num_max./n_mu;
    %dividindo num_max e fatias de num_obs, num est� em qual fatia?
    num_mu = ceil((num./num_max).*n_mu);
    mu = lista_mu(num_mu);
    %num passa a ser o n�mero num antigo dentro da fatia existente
    num = mod(num-1,num_obs)+1;
    %n�mero m�ximo para o pr�ximo fator � o tamanho da fatia do �ltimo
    num_max = num_obs;
    %n�mero de observa��es para cada n�vel de instancia
    num_obs = num_max./n_lambda;
    %dividindo num_max e fatias de num_obs, num est� em qual fatia?
    num_lambda = ceil((num./num_max).*n_lambda);
    lambda = lista_lambda(num_lambda)*mu;
    %num passa a ser o n�mero num antigo dentro da fatia existente
    num = mod(num-1,num_obs)+1;
    %n�mero m�ximo para o pr�ximo fator � o tamanho da fatia do �ltimo
    num_max = num_obs;
    %n�mero de observa��es para cada n�vel de replica��o (deve ser 1!)
    %num_obs = num_max./n_replicacoes;
    %dividindo num_max e fatias de num_obs, num est� em qual fatia?
    replicacao = ceil((num./num_max).*n_replicacoes);

    %abrir o problema
    cd instancias;
    fid = open(['matrizn',num2str(instancia(1,1)),'m',num2str(instancia(2,1)), '.mat']);
    problema = fid.problema;
    cd ..;
    
    %clc;
    clc;
    string = ['NÃO DESLIGUE O COMPUTADOR... TESTE EM EXECUÇÃO!', char(10), char(10),'Resolvendo o problema ',num2str(i), ' de ',num2str(total_de_testes),char(10)];
    string = [string, num2str(i*100/total_de_testes), '% do processo concluído', char(10)];
    string = [string, 'Instância n=', num2str(instancia(1,1)), ' m=',num2str(instancia(2,1)),char(10)];
    string = [string, 'EE com mu=', num2str(mu), ' e lambda=', num2str(lambda), char(10)];
    disp(string);
    
    
    %roda a heur�stica
    [~, resultados(replicacao,num_instancia, num_mu, num_lambda), tempo(replicacao,num_instancia, num_mu, num_lambda), sucesso(replicacao,num_instancia, num_mu, num_lambda)] = ee(problema,1,5*60,mu,lambda);
    
    
    %salva os resultados
    save(filename, 'tempo', 'sucesso', 'resultados');
    pos = pos + 1;
    save(filename2, 'ordem', 'pos');

end

end