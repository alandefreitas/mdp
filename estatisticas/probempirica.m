function probempirica( tempo, prob_sucesso, str )
%PROBEMPIRICA recebe lista com valores de tempo e plota a probabilidade
% empírica
% prob_sucesso é a probabilidade de o algoritmo obter sucesso
%    se apenas 50% obterao sucesso, a linha só vai até 0.5
%    se não é passado este parâmetro, prob_sucesso = 1
%str pode receber informação de cor

if nargin<2
    prob_sucesso = 1;
end
if nargin<3
    str = 'b-';
end

tempo = sort(tempo);
num_de_testes = 10;

%disp(['tempo tem ',num2str(numel(tempo)), ' elementos e probabilidade de sucesso foi ' num2str(prob_sucesso)]);
plot(tempo,linspace(1/num_de_testes,prob_sucesso,numel(tempo)),str);
ylim([1/num_de_testes 1]);
ylabel('%');

end

