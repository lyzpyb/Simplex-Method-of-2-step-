function [ xB ] = TwoStage( A,b )
    [m,n]=size(A); % 矩阵大小
    A=[A eye(m)]; % 增加人工变量
    i=[zeros(n,1);ones(m,1)];
    xB=n+1:n+m; % 基变量下标
    [xB,~,w]=SimplexMethod(A,b,i,xB); % 辅助问题
    if(w>0) 
        error('目标函数无解');
    else
    index=find(xB>n); 
    N=1:n+m;
    N(xB)=0;
    N=N(logical(N)); % 非基变量下标
    B=A(:,xB); % 基变量
    N=A(:,N); % 非基变量
    for i=index % 遍历人工变量下标
        j=B\N;
        j=j(i,:); % n*1
        j=(j~=0)&(N<=n);
        j=find(j,1); % 非基变量下标
        w=xB(i);xB(i)=N(j);N(j)=w;
        w=B(:,i);B(:,i)=N(:,j);N(:,j)=w;
    end
    return; 
    end
end