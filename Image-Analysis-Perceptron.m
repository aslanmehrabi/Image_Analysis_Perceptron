% Aslan Mehrabi
% Detection of eight Latin characters(A,B,C,D,E,J,K) by Image Analysis using Perceptron. Each image is converted to binary pixels of size 9*7.

%Sample Data: 4 samples for each character has been attached to the project.

%Running the project on the samle data: For the case of using 3 first samples of each character as train set and the last sample as the test set, the writtern code was able to detect all of the test characters correctly.

% Phase 2: Detecting the threshold of number of pixel errors (By generating random noises) to keep the accuracy of classification greater than 95%


let=['A' 'B' 'C' 'D' 'E' 'J' 'K' ];
data = zeros(28,9,7);


x=dlmread('A1.txt');

for i=1:7
    for j=1:4
         data((i-1)*4+j,:,:)=dlmread([let(i),int2str(j),'.txt']); %       let(i*4+j,:,:)=
    end
    
end


numCor=0;
numIter=0;

w=zeros(7,9,7);


for alph=0:6
i=1;
while true
    if(numIter==84)
       zz=5; 
    end
   if(mod(i,4)==0)
       i=i+1;
       if(i==29)
           i=1;
       end
       continue;
   end
   
   res=0;
   for ii=1:9
      for jj=1:7
          res=res+data(i,ii,jj)*w(alph+1,ii,jj);
      end
   end
   
   if(floor((i-1)/4) == alph)%
        r=1;
   else
       r=-1;
   end

   

   if(res*r<=0)
      %w=w+r*data(i,:,:); 
       for ii=1:9
            for jj=1:7
                 w(alph+1,ii,jj)=w(alph+1,ii,jj)+r*data(i,ii,jj);
            end
       end
      numCor=0;
   else
       numCor=numCor+1;
   end

    if(numCor==21)
        break;
    end
   
   
   
    numIter=numIter+1;
    
    i=i+1;
    if(i==29)
        i=1;
    end
end

end


for i=4:4:28
    res=0;
    best=-100000;

    for alph=1:7
      
        res=0;
   for ii=1:9
      for jj=1:7
          res=res+data(i,ii,jj)*w(alph,ii,jj);
          
      end
   end
   res2(i,alph)=res;
   if(res > best)
       best=res;
       bestInd=alph;
   end
    end
   
   
    bestInd
end




% Generating random error and accuracy detection


modify=zeros(63);

for alph=7:-1:1
   i=alph*4;
   
  
   for numPixel = 1:63
       totalCor=0;
      for j=1:1000   % Generating 1000 data with random errors
           tdata=data(i,:,:);
            modify=zeros(9,7);
           for k=1:numPixel
              x=ceil(rand*9);
              y=ceil(rand*7);
              while(modify(x,y)~=0)
                  x=ceil(rand*9);
                  y=ceil(rand*7);
              end
              modify(x,y)=1;
              
              if(tdata(1,x,y)==-1)
                  tdata(1,x,y)=1;
              else
                  tdata(1,x,y)=-1;
              end       
          
           end
           
           totalCor=totalCor+recog(w,tdata,alph);
      end
      if(totalCor/1000 < 0.95)
          break;
      end
   end
   
   numPixel=numPixel-1;
   ans(alph)=numPixel;
   
   
    
end

