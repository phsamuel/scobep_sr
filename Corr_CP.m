function [Result]=Corr_CP(DIC,Input,Size)
    [Dx Dy]=size(DIC);
    [Ix Iy Iz]=size(Input); 
    Result=zeros(Size,3);
    INPUT= reshape(Input, [Ix*Iy Iz])';
     tic;

    for i=1:Ix*Iy
         if mod(i,100)==0
             disp(i);
             toc;
         end
        [x y]=itoxy(i,Ix,Iy);
       
%         Corr_R=corr(INPUT(:,i),DIC); % correlation function
        Corr_R=INPUT(:,i)'*DIC; % correlation function
        
        for j=1:Size
            [M Mid]=max(Corr_R);
            [px py]=itoxy(Mid,Ix,Iy);
            Corr_R(Mid)=NaN;
            Result(x,y,j,1)=M;
            Result(x,y,j,2)=px;
            Result(x,y,j,3)=py;
        end
    end
end

function [x y]=itoxy(index, row,col)
y=ceil(index/row);    
x=mod(index-1,row)+1; % x=index-(y-1*row);
end