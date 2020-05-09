function inseremaxfos

%definir os problemas existentes
problemas = [10,20,30,40,50,100,100,100,100,200,200,200,200,300,300,300,300,400,400,400,400,500,500,500,500;4,4,3,4,5,10,20,30,40,20,40,60,80,30,60,90,120,40,80,120,160,50,100,150,200;];
fo_maxs = 2*[47,50,27,53,86,333,1195,2457,4142,1247,4450,9437,16225,2694,9689,20743,35881,4658,16956,36317,62487,7141,26258,56572,97344];

cd instancias;

for i=1:25
    %abrir o problema
    open(['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)), '.mat']);
    problema = ans.problema;
    %inserir o fo_max
    problema.fo_max = fo_maxs(i);
    %salvar o problema
    save(['matrizn',num2str(problemas(1,i)),'m',num2str(problemas(2,i)),'.mat'],'problema');

end
cd ..;
end