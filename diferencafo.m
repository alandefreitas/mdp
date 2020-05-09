function delta = diferencafo( problema, sel, elemm, elemn )

delta = 0;

%Dist�ncias do elemento removido at� os outros selecionados * 2
delta = delta - sum(problema.matriz(elemm,sel)) * 2;

%Dist�ncias do elemento incluso at� os outros * 2
delta = delta + sum(problema.matriz(elemn,sel)) * 2;

%Dist�ncia do elemento incluso ao removido * 2
delta = delta - problema.matriz(elemm,elemn) * 2;

end

