function [A, c, b] = TansStandard(A, c, b, st, MinMax,unst)
[m, n] = size(A);
if MinMax == 1
	c = -c;
end
if(find(unst~=0))
    for i =1:length(unst)
        A(:,unst(i)+i+1:n+1)=A(:,unst(i)+i:n);
        A(:,unst(i)+i)=-1*A(:,unst(i)+i-1);
        [m, n] = size(A);
    end
end
[m, n] = size(A);
for i = 1:m
	if st(i) == -1
		A(i, n + 1) = 1;
		st(i) = 0;
        c(n + 1) = 0;
		n = n + 1;
	elseif st(i) == 1
		A(i, n + 1) = -1;
		st(i) = 0;
        c(n + 1) = 0;
		n = n + 1;
	end
end
end

