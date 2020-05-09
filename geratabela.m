function geratabela( resultado )

a = 11;
b = 20;

string = '';
%para cada método
for i=1:5
   string = [string, '\hline', char(10)];
   %calcula fo
   if (i<5)
       string = [string,'ILS ',num2str(i)];
   else
       string = [string,'EE '];
   end
   
   for j=a:b
       string = [string, '& ', num2str(mean(resultado((i*2),(1+10*(j-1)):(10*j)))/2) , ' '];
   end   
   string = [string,'\\',char(10)];
   %std fo
   string = [string,'$std$ '];
   for j=a:b
       string = [string, '& ', num2str(std(resultado((i*2),(1+10*(j-1)):(10*j)))/2,4) , ' '];
   end   
   string = [string,'\\',char(10)];
   %tempo
   string = [string,'Min. '];
   for j=a:b
       if (mean(resultado((i*2-1),(1+10*(j-1)):(10*j)))/60 < 5)
           string = [string, '& ', num2str(mean(resultado((i*2-1),(1+10*(j-1)):(10*j)))/60,3) , ' '];
       else
           string = [string, '& 5+ '];
       end  
   end
   string = [string,'\\',char(10)];
   %std tempo
   string = [string,'$std$ '];
   for j=a:b
        if (mean(resultado((i*2-1),(1+10*(j-1)):(10*j)))/60 < 5)
            string = [string, '& ', num2str(std(resultado((i*2-1),(1+10*(j-1)):(10*j)))/60) , ' '];
        else
           string = [string, '& 0 '];
        end
   end   
   string = [string,'\\',char(10)];
   
end

disp(string);

end

