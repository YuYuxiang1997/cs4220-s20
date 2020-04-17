function [lambda] = p1discrepancy(obj,lmin,lmax)
    myfun = @p1resid;
    fun = @(x) myfun(obj,x);
    lambda = fzero(fun, 1e-2);
end