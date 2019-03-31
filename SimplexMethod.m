function [ xB,b0,z0 ] = SimplexMethod( A,b,c,xB )
global t;
B=A(:,xB); % ��������
A0=B\A;
b0=B\b; 
cB=c(xB);
sigma=c-A0'*cB; % ��������
z0=cB'*b0; 

while(1)
    k=find(sigma<0,1); 
    if(k)
        B=A0(:,k);
        y=find(B>0); 
        if(y)
            cB=b0(y); 
            B=B(y); 
            B=cB./B; % Ѱ�����е���Сֵ
            [~,cB]=min(B); % �ҵ�������Сֵ�±�
            cB=y(cB); 
            out=xB(cB);
            xB(cB)=k; % ����������
            y=-A0(:,k);y(cB)=y(cB)+1; 
            z0=z0+sigma(k)*b0(cB)/A0(cB,k); 
            %������ر������±�
            sigma=sigma-sigma(k)*A0(cB,:)'/A0(cB,k); 
            b0=b0+y*b0(cB)/A0(cB,k); 
            A0=A0+y*A0(cB,:)/A0(cB,k);
            t=t+1;
            disp(['��',num2str(t),'�ε�����,�����α�����Ϊ��']);
            disp(['       b','                                             xi                 '])
            disp([b0,A0;(c(xB))'*b0,sigma']);
            disp(['�������Ϊx',num2str(k),'����������Ϊx',num2str(out)]);
        else 
            error('Ŀ�꺯�������޽��');
        end
    else
        return; 
    end
end
end