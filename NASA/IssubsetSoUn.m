function answer =  IssubsetSoUn(A,B)
    answer = true;
    %answer = all(ismember(A,B));
   if length(A)>length(B)
        answer = false;
        return 
   end
   for n = 1 : length(A)
       count = 0;
       for x = 1 : length(B)
           if(A(n)== B(x))
               count = count+1;
           end
       end
       if (count==0)
           answer= false;
           return
       end
       
   end
  


end



