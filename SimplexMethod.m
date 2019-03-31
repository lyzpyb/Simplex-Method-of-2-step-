function [ xB,b0,z0 ] = SimplexMethod( A,b,c,xB )
global t;
B=A(:,xB); % 基向量组
A0=B\A;
b0=B\b; 
cB=c(xB);
sigma=c-A0'*cB; % 检验向量
z0=cB'*b0; 

while(1)
    k=find(sigma<0,1); 
    if(k)
        B=A0(:,k);
        y=find(B>0); 
        if(y)
            cB=b0(y); 
            B=B(y); 
            B=cB./B; % 寻找其中的最小值
            [~,cB]=min(B); % 找到数组最小值下标
            cB=y(cB); 
            out=xB(cB);
            xB(cB)=k; % 更换基分量
            y=-A0(:,k);y(cB)=y(cB)+1; 
            z0=z0+sigma(k)*b0(cB)/A0(cB,k); 
            %更新相关变量及下表
            sigma=sigma-sigma(k)*A0(cB,:)'/A0(cB,k); 
            b0=b0+y*b0(cB)/A0(cB,k); 
            A0=A0+y*A0(cB,:)/A0(cB,k);
            t=t+1;
            disp(['第',num2str(t),'次迭代后,单纯形表（矩阵）为：']);
            disp(['       b','                                             xi                 '])
            disp([b0,A0;(c(xB))'*b0,sigma']);
            disp(['换入变量为x',num2str(k),'，换出变量为x',num2str(out)]);
        else 
            error('目标函数存在无界解');
        end
    else
        return; 
    end
end
end