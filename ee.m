function [ s_star, fo_star, tempo_gasto , sucesso] = ee( problema, meta, tempo_max, mu, lambda )
%aplica estrat�gia evolutiva ao problema



if (nargin<2)
    meta = 1;
end
if (nargin<3)
    tempo_max = inf;
end

tic;

%popula��o inicial
%existem n!/(m!*n-m!) combina��es para o problema
%o tamanho da popula��o depender� dos tamanhos de n e m
if nargin<4
    mu = 10;
    lambda = 5*mu;
end
x = solucaoinicial(problema);
X = zeros(mu,problema.m);
for i=fliplr(1:mu)
    X(i,:) = x;
end


%Define as diferentes perturba��es
%7 n�veis de perturba��o
perturbacao = [0.02,0.10,0.40,0.50,0.70,0.80,-1];

%Define par�metros da estrat�gia
sigma = zeros(8,mu);
for i=1:mu
    soma = 0;
    for j=1:7
        sigma(j,i) = rand();
        soma = soma + sigma(j,i);
    end
    sigma(8,i) = soma;
end

%Inicializa a estrat�gia
ger = 1;
Y = zeros(lambda,size(X,2));
sigmay = zeros(8,lambda);
fitness = zeros(1,lambda);
fos = zeros(1,mu);
fo_star = fo(problema,x);

while ((ger<problema.n*10)&&(fo_star < meta*problema.fo_max)&&(toc < tempo_max))
    disp(['Geração ', num2str(ger), ',  Meta em ', num2str(fo_star/problema.fo_max)]);
    %para cada filho
    for i=1:lambda;
        %se ocorrer crossover
        if (rand() < 0.005)
            %escolhe dois pais
            pai1 = ceil(rand() * double(mu));
            pai2 = ceil(rand() * double(mu));
            if (pai1~=pai2)                
                %cruza os par�metros
                alfa = 0.3 + rand()*0.4;
                sigmay(:,i) = alfa*sigma(:,pai1) + (1-alfa)*sigma(:,pai2); 
                %cruzamento para gerar z
                Y(i,:) = cruza(problema, X(pai1,:),X(pai2,:));
            else                       
                Y(i,:) = X(pai1,:);
                sigmay(:,i) = sigma(:,pai1);
            end 
        else
            pai1 = ceil(rand() * double(mu));
            Y(i,:) = X(pai1,:);
            sigmay(:,i) = sigma(:,pai1);
        end
        %faz muta��o nos par�metros de z
        for j=1:7
            delta = sigmay(j,i)*(randn())*0.2;
            sigmay(8,i) = sigmay(8,i) + delta;
            sigmay(j,i) = sigmay(j,i) + delta;
        end
        menor = min(sigmay(1:7,i));
        if (menor <=0)
            sigmay(1:7,i) = sigmay(1:7,i) + menor + sigmay(8,i)*0.1;
            sigmay(8,i) = sum(sigmay(1:7,i));
            if (sigmay(8,i)>10)
                sigmay(:,i) = sigmay(:,i)/10;
            end
        end
        %nenhum par�metro pode passar do limite de 4/7 da soma
        limite = (4/7)*sigmay(8,i);
        for j=1:7
            if (sigmay(j,i) > limite)
                sigmay(8,i) = sigmay(8,i) - sigmay(j,i) + limite;
                sigmay(j,i) = limite;
            end
        end
        
        %faz muta��o na solu��o z
        %faz uma roleta para escolher a perturba��o aplicada
        roleta = rand()*sigmay(8,i);
        soma = 0;
        for j=1:7
            soma = soma + sigmay(j,i);
            if (roleta <= soma)
                break;
            end
        end
        Y(i,:) = perturbar(problema, Y(i,:), perturbacao(j));
        
        %refina z com busca rand�mica
        Y(i,:) = buscarandomica( problema, Y(i,:));
        
        %avalia z
        fitness(i) = fo(problema, Y(i,:));
    end
    
    %Escolhe mu indiv�duos para X entre os lambda de Y
    [~, ordem] = sort(fitness);
    for i=1:mu
        X(i,:) = Y(ordem(lambda-i+1),:);
        %refina os individuos
        X(i,:) = buscafi(problema, X(i,:));
        %copia seus valores de sigma
        sigma(:,i) = sigmay(:,ordem(lambda-i+1));
        %calcula seus valores de fitness
        fos(i) = fo(problema,X(i,:));
    end
       
    %salva a melhor solu��o conhecida
    [~, pos] = max(fos);
    if (fo_star<fos(pos))
        s_star = X(pos,:);
        fo_star = fos(pos);
    end
    
    disp(num2str(sigma(:,pos)'));
        
    %pr�xima gera��o
    ger = ger + 1;
end

tempo_gasto = toc;
sucesso = (fo_star/problema.fo_max);
disp(['Gera��o ', num2str(ger), ',  Meta em ', num2str(fo_star/problema.fo_max)]);

end

