function [ xB ] = TwoStage( A,b )
    [m,n]=size(A); % �����С
    A=[A eye(m)]; % �����˹�����
    i=[zeros(n,1);ones(m,1)];
    xB=n+1:n+m; % �������±�
    [xB,~,w]=SimplexMethod(A,b,i,xB); % ��������
    if(w>0) 
        error('Ŀ�꺯���޽�');
    else
    index=find(xB>n); 
    N=1:n+m;
    N(xB)=0;
    N=N(logical(N)); % �ǻ������±�
    B=A(:,xB); % ������
    N=A(:,N); % �ǻ�����
    for i=index % �����˹������±�
        j=B\N;
        j=j(i,:); % n*1
        j=(j~=0)&(N<=n);
        j=find(j,1); % �ǻ������±�
        w=xB(i);xB(i)=N(j);N(j)=w;
        w=B(:,i);B(:,i)=N(:,j);N(:,j)=w;
    end
    return; 
    end
end