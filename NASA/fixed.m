function sol = fixed(myfun,x,tol,N)
i=l
y=feval(myfun,x)
if y==x
    fprintf('The fixed point is %f', y)
end
while abs(x-y)>tol && i+1<=N
    i=i+1
    x=y;
    y=feval(myfun,x)
end

end