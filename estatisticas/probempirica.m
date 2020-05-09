function probempirica( tempo, prob_sucesso, str )
%PROBEMPIRICA recebe lista com valores de tempo e plota a probabilidade
% emp�rica
% prob_sucesso � a probabilidade de o algoritmo obter sucesso
%    se apenas 50% obterao sucesso, a linha s� vai at� 0.5
%    se n�o � passado este par�metro, prob_sucesso = 1
%str pode receber informa��o de cor

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

